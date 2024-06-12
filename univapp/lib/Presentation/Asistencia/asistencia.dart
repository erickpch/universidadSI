import 'package:flutter/material.dart';
import 'package:univapp/Presentation/Layouts/header.dart';
import 'package:univapp/assets/widgets/styles.dart';

class Asistencia extends StatelessWidget {
  const Asistencia({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
        backgroundColor:Style().backgroundColor(),
        appBar: headerAppBar(context),
        drawer: SideNav(),
        floatingActionButton:  FloatingActionButton(
            onPressed: () {
             // Navigator.pushNamed(context,roleCreateRoute());
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
                 listOfAsistencia()
              ],
            ),
          )
      );

  }

  Widget listOfAsistencia(){
    return Container();
  }