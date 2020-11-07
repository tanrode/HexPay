import 'package:flutter/foundation.dart';

enum Category{
  Restaurant,
  Grocery,
  General,
  Medical,
  Clothing,
  Others,
}

class Shop
{
  final String fName;
  final String lName;
  final String email;
  final String upi;
  final String ph;
  final String password;
  final String shopName;
  final String gstNo;
  final String landmark;
  final String city;
  final String pinCode;
  final String category;
  final String shopImg;

  const Shop({
    @required this.landmark,
    @required this.category,
    @required this.city,
    @required this.email,
    @required this.fName,
    @required this.gstNo,
    @required this.lName,
    @required this.password,
    @required this.ph,
    @required this.pinCode,
    @required this.shopImg,
    @required this.shopName,
    @required this.upi
  });
  
}
