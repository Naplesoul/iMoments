import 'dart:io';
import './poet/AcrosticGenerator.dart';

var storage_userName = "";
var storage_id = "";
var storage_password = "";
var storage_token = "";
var tempStorage_fav = [];
var imgPath = null;
var currentTheme = 0;
bool secretThemeFlag = false;
AcrosticGenerator AG = AcrosticGenerator();
File image = new File("images/bigHead.png");

// var storage_url = 'https://www.imoments.com.cn:8080/';
var storage_url = 'http://59.78.8.125:50008/';

var gallery_url = 'https://www.imoments.com.cn/';
// var gallery_url  = 'http://59.78.8.30:50009/';