//The login/Signup form 
//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/shop.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen(this.submitFn,this.loginUser,this.registerBusiness,this.isLoading);
  final void Function(String mobile,String email,String fName,String lName,String userUpi,String password,String dob,bool isLogin,BuildContext ctx) submitFn;
  final void Function (String mobile,String password,bool isLogin,BuildContext ctx) loginUser;
  final void Function (String fName,String lName,String email,String upiId,String password,String shopName,String gstNumber,String landmark,String city,String pincode,String typeOfBusiness,String phone,File image,bool isLogin,BuildContext ctx) registerBusiness;
  final bool isLoading;
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _firstName = '';
  String _lastName = '';
  String _userUPI = '';
  String _userDob = '';
  String _password = '';
  String _confirmPassword='';
  String mobile='';

  String _shopName = '';
  String _gstNumber = '';
  String _shopArea = '';
  String _shopCity = '';
  String _shopPinCode = '';
  String _shopType;
  bool isLogin = true;
  bool isUser=false;
  bool isBusiness=false;
  File _image;

  //for drop down list
  int _value=1;

  void _pickImageCamera()async
  {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera, imageQuality: 20);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _image = pickedImageFile;
    });
  }
  void _pickImageDevice()async
  {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery,imageQuality: 20);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _image = pickedImageFile;
    });
  }

  Future _launchURL() async {
  const url = 'https://omi123.pythonanywhere.com/reset';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  @override
  Widget build(BuildContext context) {
    Future<dynamic> _showImageOptions()
    {
      return showModalBottomSheet(context: context, builder: (context){
        return Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.orange[200],width: 4)),
            height: 120,
            child: Column(
              children:[
                SizedBox(height: 10),
                FlatButton.icon(onPressed: (){
                  _pickImageCamera();
                  Navigator.of(context).pop();
                  }, icon: Icon(Icons.camera_alt), label: Text('Click a picture')),
                FlatButton.icon(onPressed: (){
                  _pickImageDevice();
                  Navigator.of(context).pop();
                  }, icon: Icon(Icons.image), label: Text('Upload from device'))
              ],
            ),
        );
      });
    }

    return Scaffold(
          appBar: AppBar(title: Text('HexPay',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),centerTitle: true,backgroundColor: Colors.orange[300],),
          backgroundColor: Colors.white,
          body: Center(
      child: Card(
        color: Colors.grey[200],
        margin: EdgeInsets.all(5),
        child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    if(isBusiness)
                      CircleAvatar(child: _image==null ? Icon(Icons.person,color: Colors.black,size: 60,):null , radius: 40,backgroundColor: Colors.grey,backgroundImage: _image==null ? null : FileImage(_image),),
                    if(isBusiness)
                      FlatButton.icon(onPressed: (){
                        _showImageOptions();
                      }, icon: Icon(Icons.camera_alt), label: Text(isUser ? 'Add Profile Picture': isBusiness ? 'Add a picture of your shop':'')),
                    TextFormField(
                      key: Key('Registered Mobile Number'),
                      validator: (value) {
                        if (value.isEmpty ||
                            value.length < 10)
                          return 'Enter your valid Registered Mobile Number';
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: 'Registered Mobile Number'),
                      onChanged: (value) {
                        mobile=value;
                      },
                    ),
                    if(!isLogin)
                      TextFormField(
                          key: Key('First Name'),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Enter a valid first name';
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'First Name'),
                          onSaved: (value) {
                            _firstName = value;
                          }),
                    if(!isLogin)
                      TextFormField(
                          key: Key('Last Name'),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Enter a valid last name';
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Last Name'),
                          onSaved: (value) {
                            _lastName = value;
                          }),
                    if(isBusiness)
                      TextFormField(
                          key: Key('Shop Name'),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Enter a valid Shop name';
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Shop Name'),
                          onSaved: (value) {
                            _shopName = value;
                          }),
                    if(isBusiness)
                      TextFormField(
                          key: Key('GST Number'),
                          validator: (value) {
                            if (value.isEmpty || value.length!=15)
                              return 'Enter a valid GST Number';
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'GST Number'),
                          onSaved: (value) {
                            _gstNumber = value;
                          }),
                    if(isBusiness)
                      TextFormField(
                          key: Key('Area'),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Enter a valid Area/Landmark';
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Area/Landmark'),
                          onSaved: (value) {
                            _shopArea = value;
                          }),
                    if(isBusiness)
                      TextFormField(
                          key: Key('City'),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Enter a valid City';
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'City'),
                          onSaved: (value) {
                            _shopCity = value;
                          }),
                    if(isBusiness)
                      TextFormField(
                          key: Key('PIN Code'),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Enter a valid PIN Code';
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'PIN Code'),
                          onSaved: (value) {
                            _shopPinCode = value;
                          }),
                    if(isBusiness)
                      Row(
                        children: <Widget>[
                          Text('Type of Business: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                          SizedBox(width: 8),
                          DropdownButton(value: _value, items: [ DropdownMenuItem(child: Text('Restaurant'), value: 1, onTap: ()=> _shopType='Restaurant',), 
                          DropdownMenuItem(child: Text('Clothing'), value: 2, onTap: ()=> _shopType='Clothing'),
                          DropdownMenuItem(child: Text('Grocery'), value: 3, onTap: ()=> _shopType='Grocery'),
                          DropdownMenuItem(child: Text('Medical'), value: 4, onTap: ()=> _shopType='Medical'),
                          DropdownMenuItem(child: Text('General'), value: 5, onTap: ()=> _shopType='General'),
                          DropdownMenuItem(child: Text('Others'), value: 6, onTap: ()=> _shopType='Others')],
                          onChanged: (val){
                            setState(() {
                              _value=val;
                            });
                          }),
                        ],
                      ),
                    if(isUser)
                      TextFormField(
                          key: Key('dob'),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('-') || !(value.indexOf('-')==4) || !(value.lastIndexOf('-')==7) || value.length!=10)
                              return 'Invalid DOB.(Use \'-\' to separate the year,month & date)';
                            return null;
                          },
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
                          onSaved: (value) {
                            _userDob = value;
                          }),
                    if(!isLogin)
                      TextFormField(
                          key: Key('email'),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@') || !value.contains('.'))
                              return 'Enter a valid email address';
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Email address'),
                          onSaved: (value) {
                            _userEmail = value;
                          }),
                    if(!isLogin)
                      TextFormField(
                          key: Key('upiID'),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@'))
                              return 'Enter a valid UPI ID';
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'UPI ID'),
                          onSaved: (value) {
                            _userUPI = value;
                          }),
                    TextFormField(
                        key: Key('password'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 7)
                            return 'Password must be minimum 7 characters long';
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                        onChanged: (value) {
                          _password = value;
                        }),
                    if(!isLogin)
                      TextFormField(
                          key: Key('confirm password'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 7)
                              return 'Password must be minimum 7 characters long';
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Confirm Password'),
                          onChanged: (value) {
                            _confirmPassword = value;
                          }),
                    SizedBox(
                      height: 3,
                    ),
                    if(widget.isLoading)
                      CircularProgressIndicator(),
                    if(!widget.isLoading)
                      RaisedButton(
                          child: Text(isLogin ? 'Login' : 'Sign up',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            if(_image==null && isBusiness)
                            {
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please select a profile picture'),backgroundColor: Colors.red ));
                              return;
                            }
                            if(!isLogin && _password!=_confirmPassword)
                            {
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Entries in the Password and Confirm Password fields do not match.'),backgroundColor: Colors.red ));
                              return;
                            }
                            final validity = _formKey.currentState.validate();
                            FocusScope.of(context)
                                .unfocus(); // To pop the virtual keyboard
                            if (validity) _formKey.currentState.save();
                            if(isUser) widget.submitFn(mobile.trim(), _userEmail.trim(),_firstName.trim(),_lastName.trim(),_userUPI.trim(),_password.trim(),_userDob.trim(),isLogin,context);
                            if(isBusiness) widget.registerBusiness(_firstName,_lastName,_userEmail,_userUPI,_password,_shopName,_gstNumber,_shopArea,_shopCity,_shopPinCode,_shopType,mobile,_image,isLogin,context);
                            if(isLogin) widget.loginUser(mobile.trim(),_password.trim(),isLogin,context);
                          }),
                    if(!widget.isLoading)
                      isLogin ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  isUser=true;
                                  isBusiness=false;
                                  isLogin = !isLogin;
                                });
                              },
                              child: Text('New User?')),
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  isLogin = !isLogin;
                                  isUser=false;
                                  isBusiness=true;
                                });
                              },
                              child: Text('New Business?')),
                        ],
                      ): FlatButton(
                              onPressed: () {
                                setState(() {
                                  isLogin = !isLogin;
                                  isUser=false;
                                  isBusiness=false;
                                });
                              },
                              child: Text('Already have an account? Login')),
                    if(!widget.isLoading && isLogin)
                      FlatButton(
                          onPressed: ()async{
                            _launchURL();
                          },
                          child: Text('Forgot Password?')),
                  ],
                ))),
        ),
      ),
    );
  }
}