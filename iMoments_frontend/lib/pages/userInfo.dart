import 'dart:io';

var storage_userName = "admin";
var storage_password = "admin";
var imgPath = null;

class Global{
  static var httpGetInfoAddress = "http://1.15.86.128:8080/info";
  static var httpUpdateAddress = "http://1.15.86.128:8080/update";
  static File image = new File("images/bigHead.png");
  static var token = '';
  static var url = 'https://www.imoments.com.cn:8080/';
}