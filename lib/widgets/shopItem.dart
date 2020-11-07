import 'package:flutter/material.dart';
import '../screens/paymentMode.dart';
import '../models/shop.dart';
import '../models/user.dart';

class ShopItem extends StatelessWidget {
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
  final User user;

  ShopItem(
      {
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
        @required this.upi,  
        @required this.user,
      });

  void selectShop(BuildContext context)
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return PaymentMode(upi,user.upiId,user);
    }));
  }

  // String get categoryText
  // {
  //   switch(category)
  //   {
  //     case Category.Restaurant:
  //       return 'Restaurant';
  //     case Category.Clothing:
  //       return 'Clothing';
  //     case Category.General:
  //       return 'General';
  //     case Category.Grocery:
  //       return 'Grocery';
  //     case Category.Medical:
  //       return 'Medical';
  //     case Category.Others:
  //       return 'Others';
  //     default:
  //       return 'N.A';    
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectShop(context),
      child: Container(
        height: 80,
        child: Card(
          elevation: 4,
          margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.network(shopImg,
                        height: 110, width: double.infinity, fit: BoxFit.fill),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.black54,
                        width: 140,
                        child: Text(shopName,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                            softWrap: true,
                            overflow: TextOverflow.fade,),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: 2),
                      Text('Category: '),
                      Text(category,style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 2),
                      Text('Owner: '),
                      Text(fName,style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 2),
                      Text('Contact: '),
                      Text(ph,style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.start ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}