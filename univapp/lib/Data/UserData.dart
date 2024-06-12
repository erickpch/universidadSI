import 'dart:convert';

import 'package:univapp/Data/DataResponse.dart';
import 'package:univapp/Entities/User.dart';
import 'package:univapp/Entities/loginResponse.dart';
import 'package:univapp/env.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class UserData{

  Future<DataResponse> checkLogin(String _token) async{

      

    DataResponse dataResponse=DataResponse();
    try{
      var url = Uri.parse(host+'/api/v1/user');
      final http.Response response =await http.post(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+_token},
          body: { });

      print(response.body);
      const JsonDecoder decoder = JsonDecoder();
      var item = decoder.convert(response.body);

      if (response.statusCode == 200) {
        var data=item['data'];

        LoginResponse user=LoginResponse();
        
        user.username=data['username'];
        user.token=data['token'];       

        dataResponse.data=user;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

   Future<DataResponse> login(String email,String password) async{
    DataResponse dataResponse=DataResponse();
    try{
     
      Map<String, dynamic> userData = {
        'username': email,
        'password': password,
      };

      String jsonData = json.encode(userData);
      var url = Uri.parse(host + '/login');
      final http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', 
        },
        body: jsonData, 
      );

      print(response.body);

      
      const JsonDecoder decoder = JsonDecoder();
      var item = decoder.convert(response.body);


      if (response.statusCode == 200) {
        var data=item;

        LoginResponse user=LoginResponse();
        
        user.username=data['username'];
        user.token=data['token'];       

        dataResponse.data=user;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];

    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }


  Future<DataResponse> logout(String _token) async{
    DataResponse dataResponse=DataResponse();
    try{
      var url = Uri.parse(host+'/api/v1/logout');
      final http.Response response =await http.post(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+_token },
          body: { });

      print(response.body);
      const JsonDecoder decoder = JsonDecoder();
      var item = decoder.convert(response.body);

      dataResponse.status=response.statusCode == 200;
      dataResponse.message=item['message'];

    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }

    return dataResponse;
  }


  Future<DataResponse> index(String token) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/v1/user/index');
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        List<User> items=List.generate(0, (index) => new User());
        List list=item['data'];

        list.forEach((element) {
          User user=new User();
          user.id=element['id'].toString();
          user.name=element['name'].toString();
          user.email=element['email'].toString();
          user.hiringDate=element['hiring_date'].toString();
          user.roleId=element['role_id'].toString();

          items.add(user);
        });

        dataResponse.data=items;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> store(String _token,String name,String email,String password,String passwordConfirm,String hiringDate,String roleId) async{
    DataResponse dataResponse=DataResponse();

    try{
      var url = Uri.parse(host+'/api/v1/user/store');
      final http.Response response =await http.post(url,
          headers: { 'Accept' : 'application/json' ,'Authorization' : 'Bearer '+_token},
          body: {'name': name,'email': email, 'password': password , 'password_confirm': passwordConfirm, 'hiring_date' : hiringDate, 'role_id' : roleId });

      print(response.body);
      const JsonDecoder decoder = JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        var data=item['data'];

        User user=new User();
        user.id=data['id'].toString();
        user.name=data['name'].toString();
        user.email=data['email'].toString();
        user.hiringDate=data['hiring_date'].toString();
        user.roleId=data['role_id'].toString();

        dataResponse.data=user;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }

    return dataResponse;
  }




  Future<DataResponse> update(String token,User user,String password,String passwordConfirm) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/v1/user/update');
      var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;

      request.fields['id']=user.id;
      request.fields['name']=user.name;
      request.fields['email']=user.email;
      if (password!=''){
        request.fields['password']=password;
        request.fields['password_confirm']=passwordConfirm;
      }
      request.fields['hiring_date']=user.hiringDate;
      request.fields['role_id']=user.roleId;
      request.fields['_method']="PUT";


      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var result = String.fromCharCodes(responseData);

      print(result);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(result);

      if (response.statusCode == 200) {
        var data=item['data'];

        User user=new User();
        user.id=data['id'].toString();
        user.name=data['name'].toString();
        user.email=data['email'].toString();
        user.hiringDate=data['hiring_date'].toString();
        user.roleId=data['role_id'].toString();

        dataResponse.data=user;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];

    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> delete(String token,String id) async{
    DataResponse dataResponse=new DataResponse();
    try {
      var url = Uri.parse(host+'/api/v1/user/destroy');
      final http.Response response =await http.delete(url,
          headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
          body: { 'id' : id }
      );

      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      print(item);

      dataResponse.status=response.statusCode == 200;
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }

    return dataResponse;
  }

  Future<DataResponse> restore(String token,String id) async{
    DataResponse dataResponse=DataResponse();
    try{
      var url = Uri.parse(host+'/api/v1/user/restore');
      final http.Response response =await http.post(url,
          headers: { 'Accept' : 'application/json' ,'Authorization' : 'Bearer '+token},
          body: {'id': id});

      print(response.body);
      const JsonDecoder decoder = JsonDecoder();
      var item = decoder.convert(response.body);

      if (response.statusCode == 200) {
        var data=item['data'];

        User user=User();
        user.id=data['id'].toString();
        user.name=data['name'].toString();
        user.email=data['email'].toString();
        user.roleId=data["role_id"].toString();
        user.token=item['token'].toString();

        dataResponse.data=user;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

}