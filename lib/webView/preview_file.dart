import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

const debug = true;


class PreviewFile extends StatefulWidget {
  final String downloadUrl, title;

  PreviewFile(this.downloadUrl, this.title);

  @override
  _PreviewFileState createState() => _PreviewFileState();
}

class _PreviewFileState extends State<PreviewFile> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  List<_TaskInfo> _tasks = List();
  List<_ItemHolder> _items;
  bool _isLoading, downloaded = false;
  bool _permissionReady;
  String _localPath;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback);

    _isLoading = true;
    _permissionReady = false;

    _prepare();

  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

//      final task = _tasks != null?_tasks?.firstWhere((task) => task.taskId == id):null;
//      if (task != null) {
//        setState(() {
//          task.status = status;
//          task.progress = progress;
//        });
//      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Builder(
          builder: (_) => _isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : _permissionReady
              ? PDF.network(
            widget.downloadUrl,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,

          )
              : _buildNoPermissionWarning()
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.file_download),
          onPressed: ()async{
            _requestDownload(_TaskInfo(), context);
          },
        )
    );
  }

  Widget _buildDownloadList() => Container(
    child: ListView(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      children: _items
          .map((item) => item.task == null
          ? _buildListSection(item.name)
          : DownloadItem(
        data: item,
        onItemClick: (task) {
          _openDownloadedFile(task).then((success) {
            if (!success) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Cannot open this file')));
            }
          });
        },
        onAtionClick: (task) {
          if (task.status == DownloadTaskStatus.undefined) {
            _requestDownload(task, context);
          } else if (task.status == DownloadTaskStatus.running) {
            _pauseDownload(task);
          } else if (task.status == DownloadTaskStatus.paused) {
            _resumeDownload(task);
          } else if (task.status == DownloadTaskStatus.complete) {
            _delete(task);
          } else if (task.status == DownloadTaskStatus.failed) {
            _retryDownload(task);
          }
        },
      ))
          .toList(),
    ),
  );

  Widget _buildListSection(String title) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 18.0),
    ),
  );

  Widget _buildNoPermissionWarning() => Container(
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Please grant accessing storage permission to continue -_-',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
            ),
          ),
          SizedBox(
            height: 32.0,
          ),
          FlatButton(
              onPressed: () {
                _checkPermission().then((hasGranted) {
                  setState(() {
                    _permissionReady = hasGranted;
                  });
                });
              },
              child: Text(
                'Retry',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ))
        ],
      ),
    ),
  );

  void _requestDownload(_TaskInfo task, BuildContext context) async {
    print("1");
    setState(() {
      _isLoading = true;
    });
    _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';

    await FlutterDownloader.enqueue(
        url: widget.downloadUrl,
        headers: {"auth": "test_for_sql_encoding"},
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true
    );
    await showDialog(context: context, child: AlertDialog(
      title: Center(child: Text("تم تحميل الملف بنجاح !")),
      actions: [
        RaisedButton(
          child: Text("حسناً", textAlign: TextAlign.center,),
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.pop(context),
        )
      ],
    )
    );
    setState(() {
      _isLoading = false;
    });

  }

  void _cancelDownload(_TaskInfo task) async {
    await FlutterDownloader.cancel(taskId: task.taskId);
  }

  void _pauseDownload(_TaskInfo task) async {
    await FlutterDownloader.pause(taskId: task.taskId);
  }

  void _resumeDownload(_TaskInfo task) async {
    String newTaskId = await FlutterDownloader.resume(taskId: task.taskId);
    task.taskId = newTaskId;
  }

  void _retryDownload(_TaskInfo task) async {
    String newTaskId = await FlutterDownloader.retry(taskId: task.taskId);
    task.taskId = newTaskId;
  }

  Future<bool> _openDownloadedFile(_TaskInfo task) {
    return FlutterDownloader.open(taskId: task.taskId);
  }

  void _delete(_TaskInfo task) async {
    await FlutterDownloader.remove(
        taskId: task.taskId, shouldDeleteContent: true);
    await _prepare();
    setState(() {});
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<Null> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();

    int count = 0;
    _tasks = [];
    _items = [];


    tasks?.forEach((task) {
      for (_TaskInfo info in _tasks) {
        if (info.link == task.url) {
          info.taskId = task.taskId;
          info.status = task.status;
          info.progress = task.progress;
        }
      }
    });

    _permissionReady = await _checkPermission();

    _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }
}

class DownloadItem extends StatelessWidget {
  final _ItemHolder data;
  final Function(_TaskInfo) onItemClick;
  final Function(_TaskInfo) onAtionClick;

  DownloadItem({this.data, this.onItemClick, this.onAtionClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
      child: InkWell(
        onTap: data.task.status == DownloadTaskStatus.complete
            ? () {
          onItemClick(data.task);
        }
            : null,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 64.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      data.name,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: _buildActionForTask(data.task),
                  ),
                ],
              ),
            ),
            data.task.status == DownloadTaskStatus.running ||
                data.task.status == DownloadTaskStatus.paused
                ? Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: LinearProgressIndicator(
                value: data.task.progress / 100,
              ),
            )
                : Container()
          ].where((child) => child != null).toList(),
        ),
      ),
    );
  }

  Widget _buildActionForTask(_TaskInfo task) {
    if (task.status == DownloadTaskStatus.undefined) {
      return RawMaterialButton(
        onPressed: () {
          onAtionClick(task);
        },
        child: Icon(Icons.file_download),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.running) {
      return RawMaterialButton(
        onPressed: () {
          onAtionClick(task);
        },
        child: Icon(
          Icons.pause,
          color: Colors.red,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.paused) {
      return RawMaterialButton(
        onPressed: () {
          onAtionClick(task);
        },
        child: Icon(
          Icons.play_arrow,
          color: Colors.green,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.complete) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Ready',
            style: TextStyle(color: Colors.green),
          ),
          RawMaterialButton(
            onPressed: () {
              onAtionClick(task);
            },
            child: Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.canceled) {
      return Text('Canceled', style: TextStyle(color: Colors.red));
    } else if (task.status == DownloadTaskStatus.failed) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Failed', style: TextStyle(color: Colors.red)),
          RawMaterialButton(
            onPressed: () {
              onAtionClick(task);
            },
            child: Icon(
              Icons.refresh,
              color: Colors.green,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else {
      return null;
    }
  }
}

class _TaskInfo {
  final String name;
  final String link;

  String taskId;
  int progress = 0;
  DownloadTaskStatus status = DownloadTaskStatus.undefined;

  _TaskInfo({this.name, this.link});
}

class _ItemHolder {
  final String name;
  final _TaskInfo task;

  _ItemHolder({this.name, this.task});
}

