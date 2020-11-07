import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRgenerate extends StatelessWidget {
  final String transactionDetails;
  QRgenerate(this.transactionDetails);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Ask the Shopkeeper to scan this QR code if the SMS doesn\'t arrive',textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
          Center(child: QrImage(data: transactionDetails)),
        ],
      ),
    );
  }
}