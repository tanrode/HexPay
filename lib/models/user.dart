import 'package:flutter/foundation.dart';

class User
{
  final String mobile;
  final String fName;
  final String lName;
  final String dob;
  final String email;
  final String upiId;
  final String token;

  const User({
    @required this.dob,
    @required this.email,
    @required this.fName,
    @required this.lName,
    @required this.mobile,
    @required this.upiId,
    @required this.token,
  });
}