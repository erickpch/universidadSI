import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:univapp/Business/RoleBusiness.dart';
import 'package:univapp/Data/DataResponse.dart';
import 'package:univapp/Entities/Role.dart';
import 'package:univapp/assets/widgets/buttons.dart';
import 'package:univapp/assets/widgets/dialog.dart';
import 'package:univapp/assets/widgets/styles.dart';

import '../../main.dart';

import 'dart:typed_data';
import 'package:univapp/env.dart';
import 'package:file_picker/file_picker.dart';

class EditRoleArguments {
  final Role role;

  EditRoleArguments(this.role);
}

class EditRole extends StatefulWidget{
  const EditRole({Key? key, }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __EditRoleState();
  }

}

class __EditRoleState extends State<EditRole>{
  RoleBusiness roleBusiness=new RoleBusiness();

  final controllername = TextEditingController();

  Role role=new Role();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EditRoleArguments;
    this.role=args.role;
    controllername.text=args.role.name;


    controllername.addListener(() {
      role.name = controllername.text;
    });


    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              //appBackground(),
              SingleChildScrollView(
                child: todo(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget todo(BuildContext context) {
    return
      SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                cardRole(context),
                SizedBox(height: 10,),
                buttonSecondary(context, "Save", update),
                SizedBox(height: 10,),
                buttonPrimary(context, "Back", cancel)
              ],
            ),
          )
      );
  }

  Widget cardRole(BuildContext context){
    return Card(
      color: Style().backgroundColor(),
      child:Container(
        height: 90,
        color: Style().backgroundColor(),
        child: Column(
          children: [
            SizedBox(height: 5,),
            Center(
              child: Text('name', style: TextStyle(fontSize: 21,color: Style().primaryColor()),),
            ),
            SizedBox(height: 5,),
            TextField(
            //keyboardType: TextInputType.multiline,
            //minLines: 4,
            //maxLines: 4,
              controller: controllername,
            ),
 
          ],
        ),
        margin: EdgeInsets.all(10),
      ),
      elevation: 8,
      margin: EdgeInsets.all(5),
    );
  }

  
  Future<String> getTime() async {
    TimeOfDay? _newTime=await showTimePicker(context: context,initialTime: TimeOfDay.now());
    if (_newTime!=null){
      return '${_newTime.hour}:${_newTime.minute}';
    }
    return '';
  }

  Future<String> getDate() async {
    DateTime? _newDate=await showDatePicker(context: context, initialDate: DateTime.now(),
        firstDate: DateTime(1800),
        lastDate: DateTime(3000));
    if (_newDate!=null){
        return '${_newDate.year}-${_newDate.month}-${_newDate.day}';
    }
    return '';
  }

  Future<dynamic> uploadFile() async{
      FilePickerResult? result=await FilePicker.platform.pickFiles(
          //allowMultiple: false,
          //type: FileType.image,
          //allowedExtensions: ['jpg', 'png', 'jpeg', 'bmp']
        );

      if (result != null) {
        if (renderType=='android'){
          return result.files.single.path.toString();
        }
        if (renderType=='web'){
          return result.files.first.bytes as Uint8List;
        }
      } else {
        // User canceled the picker
      }
  }

  Future<dynamic> uploadImage() async{
    FilePickerResult? result;
      if (renderType=='android'){
        result=await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.image,
          //allowedExtensions: ['jpg', 'png', 'jpeg', 'bmp']
        );
      }
      if (renderType=='web'){
        result = await FilePicker.platform.pickFiles(
          //allowMultiple: false,
          //type: FileType.image,
          //allowedExtensions: ['jpg', 'png', 'jpeg', 'bmp']
        );
      }

    if (result != null) {
      if (renderType=='android'){
        return result.files.single.path.toString();
      }
      if (renderType=='web'){
        return result.files.first.bytes as Uint8List;
      }
    } else {
      // User canceled the picker
    }
  }

  Future<void> update() async{
    showLoadingIndicator(context,'Updating Role...');

    DataResponse dataResponse=await roleBusiness.update(this.role);

    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context,roleAllRoute());
      }else{
        showAlertDialog(context, "Error updating Role", dataResponse.message);
      }
    });
  }

  Future<void> cancel() async{
    Navigator.of(context).pop();
  }

}