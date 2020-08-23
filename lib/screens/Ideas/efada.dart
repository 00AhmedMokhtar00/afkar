import 'dart:convert';

import 'package:afkar/alerts/alerts.dart';
import 'package:afkar/models/investor/feedback_model.dart';
import 'package:http/http.dart' as http;
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:flutter/material.dart';

class Efada extends StatefulWidget {
  final String requestId, investorId;

  Efada({this.investorId, this.requestId});

  @override
  _EfadaState createState() => _EfadaState();
}

class _EfadaState extends State<Efada> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  List<String> selectedList = [], selectedQuestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar3(context, "عمل إفادة"),
      body: _initialView(),
    );
  }

  Widget _initialView() {
    return Container(
        margin: EdgeInsets.only(top: 5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(children: <Widget>[
          _mainTitle("عمل إفادة جديدة", icon: "images/note2.png"),
          SizedBox(
            height: 10.0,
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              //height: MediaQuery.of(context).size.height * 0.8,
              color: Colors.white,
              child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<List<FeedbackModel>>(
                  future: _getAllQuestions(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                      children: snapshot.data.map((question) =>
                          question.answerType == "text"?Container():CheckboxListTile(
                            title: Text(question.title),
                            value: selectedList.contains(question.id),
                            onChanged: (value) {
                              setState(() {
                                if (value) {
                                  selectedList.add(question.id);
                                  selectedQuestions.add(question.title);
                                }
                                else {
                                  selectedList.remove(question.id);
                                  selectedQuestions.remove(question.title);
                                }
                              });
                            },
                          )
                      ).toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(height: 20.0),
                Text("أخرى"),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  enableSuggestions: true,
                  autocorrect: true,
                  minLines: 6,
                  maxLines: 6,
                  decoration: InputDecoration(
                      hintText: "إكتب ملاحظتك",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      contentPadding: const EdgeInsets.all(5)),
                  validator: (value) =>
                      value.isNotEmpty ? null : "الرجاء كتابة الملاحظة",
                ),
                SizedBox(height: 20.0),
              ],
              ),
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            child: RaisedButton(
              onPressed: _done,
              child: Text("تم", style: TextStyle(color: Colors.white, fontSize: 14.0),),
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              elevation: 0.0,
            ),
          ),
        ]));
  }

  Widget _mainTitle(String title, {String icon}) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        height: MediaQuery.of(context).size.height * 0.055,
        child: Row(children: <Widget>[
          Image.asset(
            icon,
            width: 20.0,
            height: 20.0,
            fit: BoxFit.fill,
          ),
          SizedBox(
            width: 6.0,
          ),
          Text(title),
        ]));
  }

  Future<List<FeedbackModel>> _getAllQuestions() async {
    final url = "https://afkarestithmar.com/api/api.php?type=feedbackques";
    try {
      http.Response response = await http.get(url);
      var data = jsonDecode(response.body);
      if (data['success'] == 1) {
        List questionsData = data["ques"];
        List<FeedbackModel> feedbackModel = List();

        feedbackModel.addAll(
            questionsData
            .map((question) => FeedbackModel(
                id: question["id"],
                title: question["title"],
                answerType: question["answer_type"])
            )
            .toList()
        );
        return feedbackModel;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _done()async{

    for(int i = 0 ; i < selectedList.length ; i++){
      final String url = "https://afkarestithmar.com/api/api.php?type=feedbackinvest&invest_id=${widget.investorId}&ques_id=${selectedList[i]}&request_id=${widget.requestId}&answer=${selectedQuestions[i]}";
      print(url);
      http.Response response = await http.post(url);
      var data = jsonDecode(response.body);
      if(data['success']== 1){
        print("Done!");
      }
    }

    if(_controller.text.isNotEmpty){
      final String url = "https://afkarestithmar.com/api/api.php?type=feedbackinvest&invest_id=${widget.investorId}&ques_id=4&request_id=${widget.requestId}&answer=${_controller.text.trim()}";
      print(url);
      http.Response response = await http.post(url);
      var data = jsonDecode(response.body);
    }
    await alertTost("تم إرسال الإفادة بنجاح!");
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
