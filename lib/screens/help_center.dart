import 'package:flutter/material.dart';


class HelpCenter extends StatefulWidget {
  final String userId;

  HelpCenter(this.userId);

  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  bool isLoading = false;
  GlobalKey<FormState> _formKey;
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _titleController;
  TextEditingController _detailsController;
  FocusNode _emailFocusNode;
  FocusNode _titleFocusNode;
  FocusNode _detailsFocusNode;


  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nameController   = TextEditingController();
    _emailController   = TextEditingController();
    _titleController = TextEditingController();
    _detailsController = TextEditingController();
    _emailFocusNode    = FocusNode();
    _titleFocusNode    = FocusNode();
    _detailsFocusNode    = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _titleController.dispose();
    _detailsController.dispose();
    _emailFocusNode.dispose();
    _titleFocusNode.dispose();
    _detailsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'الدعم الفني',
          style: TextStyle(color: Colors.white),
        ),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      ),

      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_){FocusScope.of(context).requestFocus(_emailFocusNode);},
                  enableSuggestions: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                      hintText: "الإسم",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                      contentPadding: const EdgeInsets.all(5)
                  ),
                  validator: (value) => value.isNotEmpty? null : "الرجاء إدخال إسم صحيح",
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  onFieldSubmitted: (_){FocusScope.of(context).requestFocus(_titleFocusNode);},
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  enableSuggestions: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                      hintText: "البريد الإلكتروني",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                      contentPadding: const EdgeInsets.all(5)
                  ),
                  validator: (value) => value.length > 6 && value.contains("@")?null:"الرجاء إدخال بريك إلكتروني صحيح",
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: _titleController,
                  focusNode: _titleFocusNode,
                  onFieldSubmitted: (_){FocusScope.of(context).requestFocus(_detailsFocusNode);},
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  enableSuggestions: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                      hintText: "عنوان الموضوع",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                      contentPadding: const EdgeInsets.all(5)
                  ),
                  validator: (value) => value.isNotEmpty?null:"الرجاء إدخال عنوان",
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: _detailsController,
                  focusNode: _detailsFocusNode,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  enableSuggestions: true,
                  autocorrect: true,
                  minLines: 6,
                  maxLines: 6,
                  decoration: InputDecoration(
                      hintText: "الموضوع",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                      contentPadding: const EdgeInsets.all(5)
                  ),
                  validator: (value) => value.isNotEmpty?null:"الرجاء كتابة الموضوع",
                ),
                SizedBox(height: 20.0),
                isLoading?Center(child: CircularProgressIndicator()):Container(),
                GestureDetector(
                  onTap: _submit,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text("إرسال" ,style:TextStyle(fontSize:13 , color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit()async{
    final bool isValid = _formKey.currentState.validate();
    if(isValid){
      // send to server
      setState(() => isLoading = true);
      
      await Future.delayed(Duration(seconds: 2));
      setState(() => isLoading = false);
      await showDialog(
        context: context,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Text("تم إستقبال الإستفسار بنجاح!", textAlign: TextAlign.center, style: TextStyle(color: Colors.green),),
          actions: [
            Center(
                child: RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: (){
                Navigator.pop(context, true);
                _clearFields();
                },
              child: Text("حسناً", style: TextStyle(color: Colors.white),),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            )
            )
          ],
        )
      );

    }
  }

  void _clearFields(){
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _titleController.clear();
      _detailsController.clear();
    });
  }
}
