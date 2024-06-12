import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:univapp/Presentation/Asistencia/asistencia.dart';
import 'package:univapp/Presentation/Layouts/header.dart';
import 'package:univapp/assets/widgets/styles.dart';
import 'package:univapp/main.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __MenuState();
  }
}

class __MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerAppBar(context),
      drawer: SideNav(),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0099FF), Color(0xFF004488)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
             
              child: 
              todo(context),
            
          ),
        ),
      ),
    );
  }

  Widget todo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Bienvenido Docente",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          
          // Puedes agregar más widgets aquí y estilizar según sea necesario
        ],
      ),
    );
  }

}

class SideNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF004488),
            ),
            child: Text(
              'Navegación',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Horarios'),
              onTap: () {
                 Navigator.pushReplacementNamed(context, horarioRoute());
              },
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text('Asistencia'),
              onTap: () {
                 Navigator.pushReplacementNamed(context, asistenciaRoute());
              },
            ),

          // Agrega más opciones de navegación según sea necesario
        ],
      ),
    );
  }
}
