import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:univapp/Data/DataResponse.dart';
import 'package:univapp/Data/UserData.dart';
import 'package:univapp/Entities/User.dart';
import 'package:univapp/Entities/loginResponse.dart';
import 'package:univapp/Session/UserSession.dart';
//excel
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as Excel;




class UserBuiness{
  UserData userData=new UserData();

  Future<DataResponse> checkLogin() async{
    //obtiene la sesion interna
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String token=sharedPreferences.getString('token') ?? '';

    DataResponse response=await this.userData.checkLogin(token);
    if (response.status){
      User usr=response.data;
      usr.token=token;
      UserSession.setSession(usr);
    }
    return response;
  }

  Future<DataResponse> login(String email,String password) async{
    
    DataResponse response=await this.userData.login(email,password);
    if (response.status){
      LoginResponse user=response.data;  

      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreferences.setString('token',user.token);
      sharedPreferences.setString('username',user.username);
    }
    return response;
  }



  Future<DataResponse> index()async{
    DataResponse dataResponse=await this.userData.index(UserSession.user.token);
    return dataResponse;
  }

  Future<DataResponse> store(String name,String email,String password,String passwordConfirm,String hiringDate,String roleId) async{
    DataResponse dataResponse=new DataResponse();

    if (password!=passwordConfirm){
      dataResponse.status=false;
      dataResponse.message='La contraseña y la confirmacion no son iguales';
      return dataResponse;
    }

    dataResponse=await this.userData.store(UserSession.user.token,name,email,password,passwordConfirm,hiringDate,roleId);
    if (dataResponse.status){
      User usr=dataResponse.data;
      UserSession.setSession(usr);
    }

    return dataResponse;
  }

  Future<DataResponse> update(User user,String password,String passwordConfirm) async{
    DataResponse dataResponse=await userData.update(UserSession.user.token,user,password,passwordConfirm);
    return dataResponse;
  }

  Future<DataResponse> delete(String id) async{
    return await userData.delete(UserSession.user.token,id);
  }

  Future<DataResponse> restore(String id) async{
    DataResponse dataResponse=await userData.restore(UserSession.user.token,id);
    return dataResponse;
  }




}