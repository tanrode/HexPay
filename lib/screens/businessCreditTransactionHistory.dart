import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import '../models/credit.dart';


List<Credit> transactions = List.generate(20, (index) {
  var random=new Random();
  String name = "upi@id";
  double amount = (random.nextInt(9) + 1) * 100.0;
  return Credit(
    credStatus: STATUS.accepted,
      custUpiId: name,
      amount: amount,
      createdMillis: DateTime.now()
          .add(Duration(
        days: -random.nextInt(7),
        hours: -random.nextInt(23),
        minutes: -random.nextInt(59),
      ))
          .millisecondsSinceEpoch);
})
//to be replaced with backend code

  ..sort((v1, v2) => v2.createdMillis - v1.createdMillis);

class BusinessCreditTransactionPage extends StatefulWidget {
  final String token;
  BusinessCreditTransactionPage(this.token);
  @override
  _BusinessCreditTransactionPageState createState() => _BusinessCreditTransactionPageState(token);
}

class _BusinessCreditTransactionPageState extends State<BusinessCreditTransactionPage> {
  final String token;
  _BusinessCreditTransactionPageState(this.token);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Theme.of(context).brightness,
        title: Text(
          "Credits Approved & Due",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange[300],
      ),
      body: buildListView(),
    );
  }
  ListView buildListView() {
    String prevDay;
    String today = DateFormat("EEE, MMM d, y").format(DateTime.now());
    String yesterday = DateFormat("EEE, MMM d, y").format(DateTime.now().add(Duration(days: -1)));
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        Credit transaction = transactions[index];
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
              showHeader
                  ? Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  dateString,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  : Offstage(),
              if(transaction.credStatus==STATUS.accepted)
              buildItem(index, context, date, transaction),
            ],
          );
        }
    );
  }
  Widget buildItem(int index,
      BuildContext context, DateTime date, Credit transaction) {
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
  Card buildItemInfo(Credit transaction, BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.redAccent, Colors.red]
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  transaction.custUpiId,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            Container(
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