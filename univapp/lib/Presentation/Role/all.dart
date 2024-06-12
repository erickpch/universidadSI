
import 'package:flutter/material.dart';
import 'package:univapp/Business/RoleBusiness.dart';
import 'package:univapp/Data/DataResponse.dart';
import 'package:univapp/Entities/Role.dart';
import 'package:univapp/Presentation/Layouts/header.dart';
import 'package:univapp/Presentation/Role/edit.dart';
import 'package:univapp/assets/widgets/dialog.dart';
import 'package:univapp/assets/widgets/styles.dart';
import 'package:univapp/main.dart';


class AllRole extends StatefulWidget{
  const AllRole({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __AllRoleState();
  }

}

class __AllRoleState extends State<AllRole>{

  RoleBusiness roleBusiness=new RoleBusiness();
  List<Widget> listaDeCards=List.generate(0, (index) =>SizedBox(height: 1,));

  @override
  void initState() {
    super.initState();
    loadRole(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Style().backgroundColor(),
      appBar: headerAppBar(context),
      drawer: SideNav(),
      floatingActionButton:  FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context,roleCreateRoute());
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.black
      ),
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
                //searchBar(context),
                listOfRole()
              ],
            ),
          )
      );

  }

  void loadRole(BuildContext context) async{

    await Future.delayed(Duration(milliseconds: 10));
    showLoadingIndicator(context,'');
    DataResponse dataResponse=await roleBusiness.index();
    List<Role> items=dataResponse.data;
    setState(() {
      hideOpenDialog(context);
      items.forEach((item) {
        var c = cardRole(context,item);
        listaDeCards.add(c);
      });
    });
  }

  Widget listOfRole() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: listaDeCards.length,
        padding: new EdgeInsets.only(top: 5.0),
        itemBuilder: (context, index) {
          return listaDeCards[index];
        });
  }

Widget cardRole(BuildContext context,Role role){
    return Card(
      child:Container(
        height: 200,
        color: Style().backgroundColor(),
        child: Row(
          children: [
            Expanded(
              child:Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: InkWell(
                        child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                  Text(role.name),

                                ],
                              ),
                            )
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            color: Style().primaryColor(),
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.pushNamed(context, roleEditRoute(),arguments: EditRoleArguments(role));
                            },
                          ),
                          SizedBox(width: 8,),
                          IconButton(
                            color: Style().primaryColor(),
                            icon: const Icon(Icons.delete),
                            onPressed: () async{
                              showAlertDialogOptions(context,"Delete Role","¿Are you sure?",
                                      () async{
                                await deleteRole(role);
                              });
                            },
                          ),
                          SizedBox(width: 8,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex:8 ,
            ),
          ],
        ),
      ),
      elevation: 8,
      margin: EdgeInsets.all(10),
    );
  }

  Future<void> deleteRole(Role role) async{
    showLoadingIndicator(context,'Deleting Role...');
    DataResponse dataResponse=await roleBusiness.delete(role.id);
    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status){
        Navigator.pushReplacementNamed(context, roleAllRoute());
      }else{
        showAlertDialog(context, "Error deleting Role", dataResponse.message);
      }
    });
  }

}

