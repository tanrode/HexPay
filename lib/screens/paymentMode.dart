import 'package:flutter/material.dart';
import '../models/user.dart';
import '../screens/paymentAlt.dart';

class PaymentMode extends StatelessWidget {
  final String merchantUpiId;
  final String custUpiId;
  final User user;
  PaymentMode(this.merchantUpiId,this.custUpiId,this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment Mode',style: TextStyle(fontSize:25)),centerTitle: true,backgroundColor: Colors.orange[300],),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
          InkWell(child: Card(
            color: Colors.orange[100],
                      elevation: 4,
                      margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.credit_card),
                SizedBox(width: 10),
                Text('Purchase on Credit',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
              ],
            ),
          ),
            onTap: (){

            },
          ),
          SizedBox(height: 15),
          InkWell(child: Card(
            color: Colors.orange[100],
                      elevation: 4,
                      margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.monetization_on),
                SizedBox(width: 10),
                Text('Pay Now',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
              ],
            ),
          ),
            onTap: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
                return PaymentAlt(merchantUpiId, custUpiId,user);
              }));
            },
          ),
        ]),
    );
  }
}