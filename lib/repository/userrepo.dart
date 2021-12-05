import 'package:schoolmanagement/Bloc/userbloc.dart';

class UserRepo{

 static Future<User> authenticate(String mobile, String pass) async {
  return await Future.delayed(Duration(seconds: 3))
      .then((value){
        if (mobile == "2" && pass =="1"){
           Map<String, dynamic> _res ={"id":1, "name": "victor", "password": "12353",};
           return User.fromJson(_res);
        }
        throw Exception ('Mobile/password was wrong');
      });
}

}