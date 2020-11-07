import 'package:flutter/material.dart';
import '../screens/businessTransactionHistory.dart';
// import 'package:business/Screens/home.dart';
// import 'package:business/Screens/credit_transactions.dart';
// import 'package:business/Screens/pendingTransactions.dart';

class BusinessSideDrawer extends StatelessWidget {
  final String token;
  final String shopName;
  BusinessSideDrawer(this.token,this.shopName);
  void getPending(BuildContext ctx)
  {
    // Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
    //   return PendingCreditTransactionPage(token);
    // }));
  }

  void getUndo(BuildContext ctx)
  {
    // Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_){
    //   return TabsScreen();
    // }));
  }

  void getHistory(BuildContext ctx)
  {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
     return TransactionPage(token);
    }));
  }

  void getCredit(BuildContext ctx)
  {
    //  Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
    //    return CreditTransactionPage(token);
    //  }));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left:5),
            width: double.infinity,
            height: 90,
            color: Colors.orange[300],
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Welcome,',style: TextStyle(fontSize:22,color: Colors.black87,fontWeight: FontWeight.w700),),
                Text(shopName,style: TextStyle(fontSize:22,color: Colors.black87,fontWeight: FontWeight.w700),),
              ],
            ),),
          SizedBox(height: 20),
          ListTile(
            onTap: () => getPending(context),
            leading: Icon(Icons.show_chart,size: 24,), title: Text('Pending Requests',style: TextStyle(fontFamily: 'RobotoCondensed',fontSize:22,fontWeight: FontWeight.bold),),
          ),
          ListTile(
            onTap: () => getUndo(context),
            leading: Icon(Icons.show_chart,size: 24,), title: Text('Undo Transaction',style: TextStyle(fontFamily: 'RobotoCondensed',fontSize:22,fontWeight: FontWeight.bold),),
          ),
          ListTile(
            onTap: () => getHistory(context),
            leading: Icon(Icons.attach_money,size: 24,), title: Text('Transaction History',style: TextStyle(fontFamily: 'RobotoCondensed',fontSize:22,fontWeight: FontWeight.bold),),
          ),
          ListTile(
            onTap: () => getCredit(context),
            leading: Icon(Icons.credit_card,size: 24,), title: Text('Transactions on Credit',style: TextStyle(fontFamily: 'RobotoCondensed',fontSize:22,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}