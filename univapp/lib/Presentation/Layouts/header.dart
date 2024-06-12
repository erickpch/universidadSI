import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:univapp/Business/UserBusiness.dart';
import 'package:univapp/Data/DataResponse.dart';
import 'package:univapp/Session/UserSession.dart';
import 'package:univapp/assets/widgets/dialog.dart';
import 'package:univapp/assets/widgets/styles.dart';

import '../../main.dart';

class SideNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return __SideNavState();
  }
}

class __SideNavState extends State<SideNav> {
  UserBuiness userBuiness = new UserBuiness();

  List<Widget> listaDeCards = List.generate(0, (index) => SizedBox(height: 1,));

  Future<String?> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 0, 119, 255),
        child: ListView(
          children: [
            FutureBuilder<String?>(
              future: _getUsername(),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No username found'),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Bienvenido: ${snapshot.data}',
                      style: TextStyle(fontSize: 21, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  );
                }
              },
            ),
            Divider(
              color: Color.fromARGB(255, 63, 70, 109),
            ),
            cardRoute(context, 'Asistencia', () {
              Navigator.pushNamed(context, '/asistenciaRoute');
            }),
            cardRoute(context, 'Horario', () {
              Navigator.pushNamed(context, '/horarioRoute');
            }),
            cardLogout(context),
          ],
        ),
      ),
    );
  }

  Widget cardLogout(BuildContext context) {
    return Container(
      color: Colors.blue, // Color de fondo azul
      child: ListTile(
        title: Text('Cerrar sesión', style: TextStyle(color: Colors.white)),
        trailing: Icon(Icons.logout, color: Colors.white),
        onTap: () async {     
              hideOpenDialog(context);   
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('username');
              await prefs.remove('token');       
            Navigator.pushReplacementNamed(context, loginRoute());          
         
        },
      ),
    );
  }

  Widget cardRoute(BuildContext context, String text, VoidCallback action) {
    return Container(
      color: Colors.blue, // Color de fondo azul
      child: ListTile(
        title: Text(text, style: TextStyle(color: Colors.white)),
        trailing: Icon(Icons.chevron_right, color: Colors.white),
        onTap: () async {
          action();
        },
      ),
    );
  }
}

PreferredSizeWidget headerAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Style().backgroundColor(),
    elevation: 0,
    titleSpacing: 0.0,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          color: Style().primaryColor(),
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    ),
  );
}

Widget navigationHeader(BuildContext context, String title) {
  return Container(
    color: Style().seccondaryColor(),
    width: MediaQuery.of(context).size.width,
    height: 50,
    child: Row(
      children: [
        SizedBox(width: 20,),
        Icon(Icons.home, color: Style().primaryColor(),),
        SizedBox(width: 20,),
        Icon(Icons.chevron_right, color: Style().uiColor(),),
        SizedBox(width: 20,),
        Text(title, style: TextStyle(color: Style().primaryColor(), fontSize: 20),)
      ],
    ),
  );
}
