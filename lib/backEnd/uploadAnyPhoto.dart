import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart'as dio;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

Future<String> uploadAnyPhoto(File profileImage, {bool isFile = false}) async {
    var profileMediaType = {
    lookupMimeType(profileImage.path).split('/')[0]:
        lookupMimeType(profileImage.path).split('/')[1]
  };
  String url = 'https://afkarestithmar.com/api/uploadapi.php';
  Map<String, String> headers = {'Content-Type': 'multipart/form-data'};


  var formData = dio.FormData.fromMap({

    "logo": await dio.MultipartFile.fromFile(profileImage.path,
        contentType: MediaType(profileMediaType.keys.elementAt(0),
            profileMediaType.values.elementAt(0))),
  });
 // print('FormData:${formData.fields}');
  dio.Response response = await dio.Dio()
      .post(url, data: formData, options: dio.Options(headers: headers));
//  print('Status:${response.statusCode}');
    var data = jsonDecode(response.data);
    print(data[""]);
    print(data);
      return "${data["fileName"]}";
    
}