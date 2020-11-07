import 'package:flutter/material.dart';
import '../screens/custAnalytics.dart';
import './user.dart';
import '../screens/customerTransactionPage.dart';
import '../screens/customerDuePage.dart';

class SideDrawer extends StatelessWidget {
  final User user;
  SideDrawer(this.user);
  void getDues(BuildContext ctx){
    Navigator.of(ctx).push(new MaterialPageRoute(builder: (ctx1){
      return CustomerDuePage(user.token);
    }));
  }

  void getAnalytics(BuildContext ctx)
  {
    Navigator.of(ctx).push(new MaterialPageRoute(builder: (ctx1){
      return CustomerAnalytics(user.fName);
    }));
  }

  void getHistory(BuildContext ctx)
  {
    Navigator.of(ctx).push(new MaterialPageRoute(builder: (ctx1){
      return CustomerTransactionPage(user.token);
    }));
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
                Text(user.fName,style: TextStyle(fontSize:22,color: Colors.black87,fontWeight: FontWeight.w700),),
              ],
            ),),
          SizedBox(height: 20),
          ListTile(
            onTap: () => getDues(context),
            leading: Icon(Icons.show_chart,size: 24,), title: Text('Clear Dues',style: TextStyle(fontFamily: 'RobotoCondensed',fontSize:22,fontWeight: FontWeight.bold),),
          ),
          ListTile(
            onTap: () => getAnalytics(context),
            leading: Icon(Icons.show_chart,size: 24,), title: Text('Analytics',style: TextStyle(fontFamily: 'RobotoCondensed',fontSize:22,fontWeight: FontWeight.bold),),
          ),
          ListTile(
            onTap: () => getHistory(context),
            leading: Icon(Icons.attach_money,size: 24,), title: Text('Transaction History',style: TextStyle(fontFamily: 'RobotoCondensed',fontSize:22,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}