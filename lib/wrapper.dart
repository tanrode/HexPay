import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/user.dart';
import './screens/businessHomePage.dart';
import './screens/homePage.dart';
import './screens/authScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  String _userToken='';
  String _phone='';
  String _email='';
  String _fName='';
  String _lName='';
  String _upiId='';
  String _dob='';
  bool _isShop;
  bool _isCustomer;
  String _shopName='';
  static String url = 'https://omi123.pythonanywhere.com';
  static String endPointRegisterUser='/api/user/register_customer';
  static String endPointLogin='/api/user/login';
  static String endPointRegisterBusiness='/api/user/register_shop';
  bool _isLoading=false;

  Future submitUserDetails(String mobile,String email,String fName,String lName,String userUpi,String password,String dob,bool isLogin,BuildContext ctx) async
  {
    String tokenUrl = url+endPointRegisterUser;
    try{
      setState(() {
            _isLoading=true;
          });
          print(tokenUrl);
          http.Response resp;
          resp = await http.post(
            tokenUrl,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              'phone' : mobile,
              'email' : email,
              'first_name' : fName,
              'last_name' : lName,
              'upi_id' : userUpi,
              'password' : password,
              'dob' : dob,
            }),
          ).then((value){
            setState(() {
              _isLoading=false;
              _userToken=json.decode(value.body)['token'];
              _phone=json.decode(value.body)['phone'];
              _email=json.decode(value.body)['email'];
              _fName=json.decode(value.body)['first_name'];
              _lName=json.decode(value.body)['last_name'];
              _upiId=json.decode(value.body)['upi_id'];
              _dob=json.decode(value.body)['dob'];
              _isShop=json.decode(value.body)['is_shop'];
              _isCustomer=json.decode(value.body)['is_customer'];
            });
            print(json.decode(value.body));
            //print(_userToken);
            //print(_userName);
            return resp;
      });
    }
    on PlatformException catch(err){
      var msg= isLogin ? 'Login Unsuccessful, please check your credentials' : 'Sign up unsuccessful, please check your credentials';
      setState(() {
        _isLoading=false;
      });
      //To show snackbar to the user
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(msg+''),backgroundColor: Colors.red,));
    }
    catch(err)
    {
      print(err);
      setState(() {
        _isLoading=false;
      });
    }
  }

  Future loginUser(String mobile,String password,bool isLogin,BuildContext ctx) async
  {
    print(mobile);
    print(password);
    String tokenUrl = url+endPointLogin;
    try{
      setState(() {
            _isLoading=true;
          });
          print(tokenUrl);
          http.Response resp;
          resp = await http.post(
            tokenUrl,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              'username' : mobile,
              'password' : password,
            }),
          ).then((value){
            setState(() {
              _isLoading=false;
              _userToken=json.decode(value.body)['token'];
              _phone=json.decode(value.body)['phone'];
              _email=json.decode(value.body)['email'];
              _fName=json.decode(value.body)['first_name'];
              _lName=json.decode(value.body)['last_name'];
              _upiId=json.decode(value.body)['upi_id'];
              _dob=json.decode(value.body)['dob'];
              _isShop=json.decode(value.body)['is_shop'];
              _isCustomer=json.decode(value.body)['is_customer'];
            });
            print(json.decode(value.body));
            //print(_userToken);
            //print(_userName);
            return resp;
      });
    }
    on PlatformException catch(err){
      var msg= isLogin ? 'Login Unsuccessful, please check your credentials' : 'Sign up unsuccessful, please check your credentials';
      setState(() {
        _isLoading=false;
      });
      //To show snackbar to the user
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(msg+''),backgroundColor: Colors.red,));
    }
    catch(err)
    {
      print(err);
      setState(() {
        _isLoading=false;
      });
    }
  }

  Future registerBusiness(String fName,String lName,String email,String upiId,String password,String shopName,String gstNumber,String landmark,String city,String pincode,String typeOfBusiness,String phone,File image,bool isLogin,BuildContext ctx) async
  {
    String tokenUrl = url+endPointRegisterBusiness;
    try{
      setState(() {
            _isLoading=true;
          });
          print(tokenUrl);
          http.Response resp;
          resp = await http.post(
            tokenUrl,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({
              'first_name':	fName,
              'last_name'	: lName,
              'email'	: email,
              'upi_id' :	upiId,
              'password' :	password,
              'shop_name'	: shopName,
              'gst_number' :	gstNumber,
              'landmark' :	landmark,
              'city' :	city,
              'pin_code'	: pincode,
              'type_of_business' :	typeOfBusiness,
              'phone'	: phone,
              'image' : image.path,
            }),
          ).then((value){
            setState(() {
              _isLoading=false;
              _userToken=json.decode(value.body)['token'];
              _phone=json.decode(value.body)['phone'];
              _email=json.decode(value.body)['email'];
              _fName=json.decode(value.body)['first_name'];
              _lName=json.decode(value.body)['last_name'];
              _upiId=json.decode(value.body)['upi_id'];
              _isShop=json.decode(value.body)['is_shop'];
              _isCustomer=json.decode(value.body)['is_customer'];
              _shopName=json.decode(value.body)['shop_name'];
            });
            print(json.decode(value.body));
            //print(_userToken);
            //print(_userName);
            return resp;
      });
    }
    on PlatformException catch(err){
      var msg= isLogin ? 'Login Unsuccessful, please check your credentials' : 'Sign up unsuccessful, please check your credentials';
      setState(() {
        _isLoading=false;
      });
      //To show snackbar to the user
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(msg+''),backgroundColor: Colors.red,));
    }
    catch(err)
    {
      print(err);
      setState(() {
        _isLoading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: _userToken=='' || _userToken==null ? AuthScreen(submitUserDetails,loginUser,registerBusiness,_isLoading) : (_isCustomer ? HomePage(User(dob: _dob, email: _email, fName: _fName, lName: _lName, mobile: _phone, upiId: _upiId, token: _userToken)) : BusinessHomePage(token: _userToken,shopName:_shopName)),
    );
  }
}