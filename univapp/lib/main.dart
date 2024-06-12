import 'package:flutter/material.dart';
import 'package:univapp/Presentation/Asistencia/asistencia.dart';
import 'package:univapp/Presentation/Horarios/horarios.dart';
import 'package:univapp/Presentation/User/login.dart';
import 'package:univapp/Presentation/menu.dart';
import 'package:univapp/Presentation/Role/all.dart' as RoleAll;
import 'package:univapp/Presentation/Role/create.dart' as RoleCreate;
import 'package:univapp/Presentation/Role/edit.dart' as RoleEdit;



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: loginRoute(),
      routes: {
        '/login' : (context) => const Login(),    
        '/menu' : (context) => const Menu(),

        '/horario': (context) => const Horario(),
        '/asistencia': (context) => const Asistencia(),



        '/role/all' : (context) => const RoleAll.AllRole(),
        '/role/create' : (context) => const RoleCreate.CreateRole(),
        '/role/edit' : (context) => const RoleEdit.EditRole(),


      },
    );
  }
}

String loginRoute() => '/login'; 
String menuRoute() => '/menu';

String asistenciaRoute() => '/asistencia';
String horarioRoute() => '/horario';




String roleAllRoute() => '/role/all';
String roleCreateRoute() => '/role/create';
String roleEditRoute() => '/role/edit';



