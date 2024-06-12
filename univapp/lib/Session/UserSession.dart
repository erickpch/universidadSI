import 'package:univapp/Entities/User.dart';

class UserSession{
  static final UserSession _instance = UserSession._internal();
  factory UserSession() => _instance;

  static User user=User();

  UserSession._internal() {
    // init things inside this
  }

  static UserSession get shared => _instance;

  static setSession(User user){
    UserSession.user=user;
  }
}