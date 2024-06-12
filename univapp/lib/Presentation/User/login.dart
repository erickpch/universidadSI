import 'package:flutter/material.dart';
import 'package:univapp/Business/UserBusiness.dart';
import 'package:univapp/Data/DataResponse.dart';
import 'package:univapp/assets/widgets/buttons.dart';
import 'package:univapp/assets/widgets/dialog.dart';
import 'package:univapp/assets/widgets/inputs.dart';
import 'package:univapp/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return __LoginState();
  }
}

class __LoginState extends State<Login> {
  UserBuiness userBusiness = UserBuiness();

  final controllerEmail = TextEditingController();
  final controllerPass = TextEditingController();
  String email = "";
  String pass = "";
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    checkLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    controllerEmail.addListener(() {
      email = controllerEmail.text;
    });
    controllerPass.addListener(() {
      pass = controllerPass.text;
    });
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0099FF), Color(0xFF004488)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: todo(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget todo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Log In",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50.0),
          CustomInputField(
            Icon(Icons.person, color: Colors.white),
            "usuario",
            controllerEmail,
            false,
            
          ),
          SizedBox(height: 20.0),
          CustomInputField(
            Icon(Icons.lock, color: Colors.white),
            "Contraseña",
            controllerPass,
            true,
            
          ),
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
          SizedBox(height: 20.0),  
          Center(
            child:buttonPrimary(context, "INICIAR SESION", login),
          ),
        ],
      ),
    );
  }

  Future<void> login() async {
    showLoadingIndicator(context, 'Iniciando sesion');

    DataResponse dataResponse = await userBusiness.login(email, pass);
    setState(() {
      hideOpenDialog(context);
      if (dataResponse.status) {
        Navigator.pushReplacementNamed(context, menuRoute());
      } else {
        errorMessage = "Incorrect password.";
      }
    });
  }

  void checkLogin(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 10));
    showLoadingIndicator(context, '');
    DataResponse dataResponse = await userBusiness.checkLogin();
    hideOpenDialog(context);
    if (dataResponse.status) {
      Navigator.pushReplacementNamed(context, menuRoute());
    }
  }
}
