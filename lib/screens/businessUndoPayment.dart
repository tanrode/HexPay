import 'package:flutter/material.dart';
import 'package:hexPay/screens/paymentAlt.dart';
import 'package:intl/intl.dart';
import '../models/user.dart';
import 'package:upi_flutter/upi_flutter.dart';
import 'dart:math';
import '../models/transaction.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// List<Transaction> transactions = List.generate(20, (index) {
//   var random=new Random();
//   String name = "upi@id";
//   double amount = (random.nextInt(9) + 1) * 100.0;
//   return Transaction(
//       custUpiId: name,
//       amount: amount,
//       createdMillis: DateTime.now()
//           .add(Duration(
//         days: -random.nextInt(7),
//         hours: -random.nextInt(23),
//         minutes: -random.nextInt(59),
//       ))
//           .millisecondsSinceEpoch);
// })
// //to be replaced with backend code
//   ..sort((v1, v2) => v2.createdMillis - v1.createdMillis);

class UndoPage extends StatefulWidget {
  final String token;
  UndoPage(this.token);
  @override
  _UndoPageState createState() => _UndoPageState(token);
}

class _UndoPageState extends State<UndoPage> {
  final String token;
  _UndoPageState(this.token);
  static var random=new Random();
  List<Transaction> transList=[Transaction(amount: 500.0,custUpiId: 'v.tanmay13@okicici',createdMillis: DateTime.now()
          .add(Duration(
        days: -random.nextInt(7),
        hours: -random.nextInt(23),
        minutes: -random.nextInt(59),
      ))
          .millisecondsSinceEpoch)];
  bool _isLoading=true;
  String data;
  Future _getTransactions()async
  {
    final transactions = await http.get('https://omi123.pythonanywhere.com/api/transactions/get_transactions', headers: <String,String>{
      'Authorization' : 'Token '+token,
    });
    final transactionsMap = json.decode(transactions.body) as Map<String,dynamic>;
    print(transactionsMap);
    print(transactionsMap['transactions']);
    for(int i=0;i<transactionsMap['transactions'].length;i++)
    {
      print(transactionsMap['transactions'][i]['by']['upi_id']);
      print(transactionsMap['transactions'][i]['amount']);
      print(transactionsMap['transactions'][i]['time']);
      //{status: successful, shops: [{phone: 1111111111, upi_id: omkar.masur@okicici, first_name: t, shop: {shop_name: trs, city: blr, pin_code: 560002, landmark: hal, type_of_business: Clothing}}, {phone: 7774446661, upi_id: sahil@okhdfcbank, first_name: Sahil, shop: {shop_name: Singh da dhaba, city: Bangalore, pin_code: 560002, landmark: SAP, type_of_business: Restaurant}}]}
      transList.add(Transaction(custUpiId: transactionsMap['transactions'][i]['by']['upi_id'],amount: double.parse((transactionsMap['transactions'][i]['amount']).toString()), createdMillis: DateTime.parse(transactionsMap['transactions'][i]['time']).millisecondsSinceEpoch));
    }
    setState(() {
      _isLoading=false;
    });
  }

  Future<String> _initiateTransaction(String app,double amt,String custUpi) async {
    UpiFlutter upi = new UpiFlutter(
      receiverUpiId: custUpi,
      receiverName: 'TestName',
      transactionRefId: 'TestingId',
      transactionNote: 'Test Transaction',
      amount: amt,
    );

    String response = await upi.startTransaction();

    return response;
  }

  void initState()
  {
    _getTransactions();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Theme.of(context).brightness,
        title: Text(
          "Select Transaction to Undo",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange[300],
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : buildListView(),
    );
  }
  ListView buildListView() {
    String prevDay;
    String today = DateFormat("EEE, MMM d, y").format(DateTime.now());
    String yesterday = DateFormat("EEE, MMM d, y").format(DateTime.now().add(Duration(days: -1)));
    return ListView.builder(
      itemCount: transList.length,
      itemBuilder: (context, index) {
        Transaction transaction = transList[index];
        DateTime date =
        DateTime.fromMillisecondsSinceEpoch(transaction.createdMillis);
        String dateString = DateFormat("EEE, MMM d, y").format(date);
        if (today == dateString) {
          dateString = "Today";
        } else if (yesterday == dateString) {
          dateString = "Yesteday";
        }
        bool showHeader = prevDay != dateString;
        prevDay = dateString;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            showHeader && dateString=='Today'
                ? Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                dateString,
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : Offstage(),
            if(dateString=='Today')
            buildItem(index, context, date, transaction),
          ],
        );
      },
    );
  }
  Widget buildItem(int index,
      BuildContext context, DateTime date, Transaction transaction) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(width: 20),
          buildLine(index, context),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            // color: Theme.of(context).accentColor,
            child: Text(
              DateFormat("hh:mm a").format(date),
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                // color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: buildItemInfo(transaction, context),
          ),
        ],
      ),
    );
  }
  Card buildItemInfo(Transaction transaction, BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors:[Colors.green, Colors.teal]),
        ),
        child: Row(
          children: <Widget>[
            new Expanded(
              flex: 1,
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Text(
                        transaction.custUpiId,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: FlatButton(onPressed: (){
                        final transactionRef = Random.secure().nextInt(1 << 32).toString();
                        print("Starting transaction with id $transactionRef");
                        _initiateTransaction('8105508136@ybl',transaction.amount,transaction.custUpiId).then((onValue)async{
                          setState(() {
                            data = onValue;
                          });
                        });
                      }, child: Text('Undo'),color: Colors.white,),
                    )
                  ]),
            ),
            new Expanded(
              flex: 1,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    //alignment: Alignment.topRight,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Text(
                      NumberFormat("Rs ###,###,####").format(transaction.amount),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Container buildLine(int index, BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: 2,
              color: Theme.of(context).accentColor,
            ),
          ),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor, shape: BoxShape.circle),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 2,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}