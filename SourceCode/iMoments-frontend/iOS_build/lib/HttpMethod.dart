import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:imoments/userInfo.dart';
import 'userInfo.dart';
import 'package:dio/dio.dart';
/*自动登录*/
userLogin() async {
  imgPath = null;
  var url = Uri.parse(storage_url + 'login');

  var res = await http.post(url,
      body: '{"username":"$storage_userName","password":"$storage_password"}');

  var json = jsonDecode(res.body);
  storage_token = json["token"];

  print(storage_userName);
  print(storage_token);

  /*保存数据*/
  getUserId();
  save();

  return res.statusCode;
}

/*获取用户密码*/
Future<String> getUserPassword() async {
  var url = Uri.parse(storage_url + 'info?token=' + storage_token);
  var res = await http.get(url);

  var json = jsonDecode(res.body);

  String userPassword = json.toString().split(" ").elementAt(1);

  return userPassword;
}

/*获取用户昵称*/
Future<String> getUserName() async {
  var url = Uri.parse(storage_url + 'info?token=' + storage_token);
  var res = await http.get(url);

  var json = jsonDecode(res.body);

  String userName = json.toString().split(" ").elementAt(3);

  return userName;
}

/*获取用户id*/
Future getUserId() async {
  // /*先从本地获取数据*/
  var url = storage_url + "info?token=" + storage_token;
  print(url);
  /*获取用户输入内容*/
  Dio dio = Dio();
  var response = await dio.get(url);
  var json = jsonDecode(response.data);
  storage_id = json["id"];

  /*将改变后数据保存在本地*/
  // save();
  /* 每个getUserId后已有save */
}

/*上传用户头像*/
postUserProfile(var imagePath, var token) async {
  FormData formData = FormData.fromMap({
    "file": await MultipartFile.fromFile(imagePath),
  });

  Dio dio = Dio();
  var response = await dio.post(
    storage_url + 'portrait?token=' + token,
    data: formData,
  );
  if (response.statusCode == 200) {
    return response.toString();
  }
}

Future getFavor() async {
  var url = storage_url + 'favor?token=$storage_token';
  Dio dio = Dio();
  var response = await dio.get(url);

  String list = response.data;
  tempStorage_fav = list.split('\n');
  tempStorage_fav.removeLast();
}

Future<bool> dioPost(var url) async {
  try {
    //404
    await Dio().post(url);
    return true;
  } on DioError catch (e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (e.response != null) {
      if(e.response.data['status'] == 'wrong token') {
        Fluttertoast.showToast(msg: "已在其他设备登录");
      }
    } else {
      // Something happened in setting up or sending the request that triggered an Error
      print(e.message);
      Fluttertoast.showToast(msg: "sending message error!");
    }

    return false;
  }
}

/*保存本地数据*/
Future save() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("storage_userName", storage_userName); //getUserName().toString());
  prefs.setString("storage_password", storage_password); //getUserPassword().toString());
  prefs.setString("storage_token", storage_token);
  prefs.setString("storage_id", storage_id);
  // prefs.setString("imgPath", imgPath);
}

/*读取本地数据*/
get() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.containsKey("storage_userName")) {
    storage_userName = prefs.getString("storage_userName").toString();
  } else {
    prefs.setString("storage_userName", storage_userName);
  }

  if(prefs.containsKey("storage_password")) {
    storage_password = prefs.getString("storage_password").toString();
  } else {
    prefs.setString("storage_password", storage_password);
  }

  if(prefs.containsKey("storage_token")) {
    storage_token = prefs.getString("storage_token").toString();
  } else {
    prefs.setString("storage_token", storage_token);
  }

  if(prefs.containsKey("storage_id")) {
    storage_token = prefs.getString("storage_id").toString();
  } else {
    prefs.setString("storage_id", storage_token);
  }
}

void removeInf() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("storage_password", "");
  secretThemeFlag = false;
  prefs.setBool("secretTheme", false);
  imgPath = null;
  storage_password = "";
  tempStorage_fav = [];
}
