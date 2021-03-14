import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http_login_app/model/loginmodel.dart';

class APIService{
Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
  String url = "https://reqres.in/api/login";
  final response  = await http.post(url,body: loginRequestModel.toJson());
  if(response.statusCode == 200 || response.statusCode ==400){
    //400 invalid user name
    return LoginResponseModel.fromJson(json.decode(response.body));
  }else{
    throw Exception("Failed to load Data");
  }

}
}