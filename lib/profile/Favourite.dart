
import 'package:afkar/AppBar1.dart/appBar2.dart';
import 'package:afkar/main.dart';
import 'package:afkar/screens/dataSource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
class Favourite extends StatefulWidget{
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  

  @override
  Widget build(BuildContext context) {
    AppState myState =Provider.of<AppState>(context,listen: false);
    return Scaffold(
      appBar:appBar3(context , "تفضيلات المجالات"),
      body: Container(
        width:MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
          width:MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.7,
          child: SingleChildScrollView(
                    child: Column(
              children:<Widget>[
//             CheckboxGroup(
//   labels: dataSource,
//   onSelected: (List<String> checked) {

//     print(checked.toString());
//     }
// )
CustomCheckBoxGroup(
horizontal: true,
enableShape: true,
buttonColor: Theme.of(context).canvasColor,
buttonLables: namesOfData,
buttonValuesList: idsOfData,
checkBoxButtonValues: (value) {
  print(value);
},
selectedColor: Theme.of(context).accentColor,
),
              ]
            ),
          ),
        ),
      ),
    );
  }
}