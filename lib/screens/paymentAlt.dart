import 'dart:math';
import './qrPage.dart';
import 'package:upi_flutter/upi_flutter.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentAlt extends StatefulWidget {
  final String merchantUpiId;
  final String custUpiId;
  final User user;
  PaymentAlt(this.merchantUpiId,this.custUpiId,this.user);
  @override
  _PaymentAltState createState() => _PaymentAltState(merchantUpiId,custUpiId);
}

class _PaymentAltState extends State<PaymentAlt> {
  final String merchantUpiId;
  final String custUpiId;
  _PaymentAltState(this.merchantUpiId,this.custUpiId);

  String _upiAddrError="";
  bool _isUpiEditable=true;
  double amount;
  final _upiAddressController = TextEditingController();
  final _amountController = TextEditingController();
  String data = 'Testing plugin';

  @override
  void initState() {
    super.initState();
    _amountController.text = (0.0).toStringAsFixed(2);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _upiAddressController.dispose();
    super.dispose();
  }

  Future<String> _initiateTransaction(String app) async {
    UpiFlutter upi = new UpiFlutter(
      receiverUpiId: merchantUpiId,
      receiverName: 'TestName',
      transactionRefId: 'TestingId',
      transactionNote: 'Test Transaction',
      amount: double.parse(_amountController.text),
    );

    String response = await upi.startTransaction();

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return data.contains('SUCCESS') ? QRgenerate(custUpiId+' '+merchantUpiId+' '+amount.toString()+' '+data.substring(data.lastIndexOf('=')+1)) : MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(appBar: AppBar(
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back), onPressed: ()=>Navigator.of(context).pop()),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.2
          ),
          Text('Payments',textAlign: TextAlign.center,),
        ],),
        centerTitle: true,
        backgroundColor: Colors.orange[300],  
      ),
      body: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 32),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'address@upi',
                      labelText: merchantUpiId,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_upiAddrError != null)
            Container(
              margin: EdgeInsets.only(top: 4, left: 12),
              child: Text(
                _upiAddrError,
                style: TextStyle(color: Colors.red),
              ),
            ),
          Container(
            margin: EdgeInsets.only(top: 32),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    readOnly: false,
                    enabled: _isUpiEditable,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Amount',
                    ),
                    onChanged: (amt){
                      setState(() {
                        amount= double.parse(amt);
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: IconButton(
                    icon: Icon(
                      _isUpiEditable ? Icons.check : Icons.edit,
                    ),
                    onPressed: () {
                      setState(() {
                        _isUpiEditable = !_isUpiEditable;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 128, bottom: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'UPI Payments',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                GestureDetector(
                onTap: (){
                  final transactionRef = Random.secure().nextInt(1 << 32).toString();
                  print("Starting transaction with id $transactionRef");
                  _initiateTransaction('8105508136@ybl').then((onValue)async{
                    setState((){
                      data = onValue;
                    });
                      // http.Response resp;
                      // resp = await http.post('https://omi123.pythonanywhere.com/api/transactions/make_transaction',
                      //   headers: <String,String>{
                      //     'Content-Type': 'application/json; charset=UTF-8',
                      //     'Authorisation': 'Token '+widget.user.token,
                      //   },
                      //   body: json.encode({
                      //     'to': merchantUpiId,
                      //     'amount': amount,
                      //     'transaction_id': data.substring(data.lastIndexOf('=')+1),
                      //   })
                      // ).then((value) => null);
                      //print(data);
                    });
                },
                child: Container(
                  width: 150,
                  height: 50,
                  color: Colors.grey,
                  child: Center(child: Text("Proceed To Pay")),
                ),
              ),
              // SizedBox(height: 10,),
              // Text(data,style: TextStyle(color: Colors.black,fontSize: 20),)
              ],
            ),
          )
        ],
      ),
    ),
      ),
    );
    
  }
}