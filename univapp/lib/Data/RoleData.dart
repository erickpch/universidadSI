import 'dart:convert';


import 'package:univapp/Data/DataResponse.dart';
import 'package:univapp/Entities/Role.dart';
import 'package:univapp/env.dart';
import 'package:http/http.dart' as http;



class RoleData{

  Future<DataResponse> index(String token) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/v1/role/index');
      final http.Response response =await http.get(url,
        headers: { 'Accept' : 'application/json' , 'Authorization' : 'Bearer '+token },
      );

      print(response.body);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(response.body);
      if (response.statusCode == 200) {
        List<Role> items=List.generate(0, (index) => new Role());
        List list=item['data'];

        list.forEach((element) {
          Role role=new Role();
          role.id=element['id'].toString();
        role.name=element['name'].toString();

          items.add(role);
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

  Future<DataResponse> store(String token,Role role) async{
    DataResponse dataResponse=new DataResponse();
    try {

      var url = Uri.parse(host+'/api/v1/role/store');
      var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
      role.toMapStore().forEach((key, value) {
        request.fields[key]=value;
      });


      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var result = String.fromCharCodes(responseData);

      print(result);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(result);
      if (response.statusCode == 200) {

        var element=item['data'];

        Role role=new Role();
        role.id=element['id'].toString();
        role.name=element['name'].toString();


        dataResponse.data=role;
        dataResponse.status=true;
      }
      dataResponse.message=item['message'];
    }catch(error){
      print(error.toString());
      dataResponse.message=error.toString();
    }
    return dataResponse;
  }

  Future<DataResponse> update(String token,Role role) async{
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/v1/role/update');
            var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
      request.fields['id']=role.id;
      request.fields['name']=role.name;
      request.fields['_method']="PUT";


      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var result = String.fromCharCodes(responseData);

      print(result);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(result);

      if (response.statusCode == 200) {
        var element=item['data'];

        Role role=new Role();
        role.id=element['id'].toString();
        role.name=element['name'].toString();


        dataResponse.data=role;
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
      var url = Uri.parse(host+'/api/v1/role/destroy');
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
    DataResponse dataResponse=new DataResponse();

    try {
      var url = Uri.parse(host+'/api/v1/role/restore');
      var request = http.MultipartRequest("POST",url);
      request.headers['Accept']='application/json';
      request.headers['Authorization']='Bearer '+token;
      request.fields['id']=id;


      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var result = String.fromCharCodes(responseData);

      print(result);
      const JsonDecoder decoder = const JsonDecoder();
      var item = decoder.convert(result);

      if (response.statusCode == 200) {
        var element=item['data'];

        Role role=new Role();
        role.id=element['id'].toString();
        role.name=element['name'].toString();


        dataResponse.data=role;
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
