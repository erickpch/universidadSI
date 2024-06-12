import 'package:univapp/Data/DataResponse.dart';
import 'package:univapp/Data/RoleData.dart';
import 'package:univapp/Entities/Role.dart';
import 'package:univapp/Session/UserSession.dart';

class RoleBusiness{
  RoleData roleData=new RoleData();

  Future<DataResponse> index() async{
    DataResponse dataResponse=await roleData.index(UserSession.user.token);
    return dataResponse;
  }

  Future<DataResponse> store(name) async{
    Role role=new Role();
    role.name=name;

    DataResponse dataResponse=await roleData.store(UserSession.user.token,role);
    return dataResponse;
  }

  Future<DataResponse> update(Role role) async{
    DataResponse dataResponse=await roleData.update(UserSession.user.token,role);
    return dataResponse;
  }

  Future<DataResponse> delete(String id) async{
    return await roleData.delete(UserSession.user.token,id);
  }

  Future<DataResponse> restore(String id) async{
    DataResponse dataResponse=await roleData.restore(UserSession.user.token,id);
    return dataResponse;
  }


}