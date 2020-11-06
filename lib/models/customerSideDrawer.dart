import 'package:flutter/material.dart';
import './user.dart';

class SideDrawer extends StatelessWidget {
  final User user;
  SideDrawer(this.user);
  void getAnalytics(BuildContext ctx)
  {
    // Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_){
    //   return TabsScreen();
    // }));
  }

  void getHistory(BuildContext ctx)
  {
    // Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_){
    //   return FiltersScreen();
    // }));
  }

  void getCredit(BuildContext ctx)
  {
    // Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_){
    //   return FiltersScreen();
    // }));
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
            onTap: () => getAnalytics(context),
            leading: Icon(Icons.show_chart,size: 24,), title: Text('Analytics',style: TextStyle(fontFamily: 'RobotoCondensed',fontSize:22,fontWeight: FontWeight.bold),),
          ),
          ListTile(
            onTap: () => getHistory(context),
            leading: Icon(Icons.attach_money,size: 24,), title: Text('Transaction History',style: TextStyle(fontFamily: 'RobotoCondensed',fontSize:22,fontWeight: FontWeight.bold),),
          ),
          ListTile(
            onTap: () => getCredit(context),
            leading: Icon(Icons.credit_card,size: 24,), title: Text('Purchases on Credit',style: TextStyle(fontFamily: 'RobotoCondensed',fontSize:22,fontWeight: FontWeight.bold),),
          ),
          FlatButton(
            color: Colors.black87,
            onPressed: () {
              
            },
            child: Text('Logout',style: TextStyle(color: Colors.white),)),
          FlatButton(
            onPressed: () {
              
            },
            child: Text('Change Password')),
        ],
      ),
    );
  }
}
