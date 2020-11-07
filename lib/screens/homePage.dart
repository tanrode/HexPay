import 'package:flutter/material.dart';
import '../models/shop.dart';
import '../models/sideDrawer.dart';
import '../widgets/shopItem.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';


class HomePage extends StatefulWidget {
  final User user;
  HomePage(this.user);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final shopList = const[
    Shop(
      fName: 'Rakesh',
      lName: 'Verma',
      email: 'rv@hmail.com',
      password: '1234567',
      landmark: 'BEL',
      upi: 'omkar.masur@okicici',
      gstNo: '000123456789',
      shopName: 'BBQ Nation',
      category: 'Restaurant',
      city: 'Bangalore',
      pinCode: '560012',
      ph: '8889991112',
      shopImg: 'https://restaurantindia.s3.ap-south-1.amazonaws.com/s3fs-public/content12330.jpg',
    ),
    Shop(
      fName: 'Mukesh',
      lName: 'Verma',
      email: 'mv@hmail.com',
      password: '1234567',
      landmark: 'BEML',
      upi: 'v.tanmay13@okicici',
      gstNo: '000123456789',
      shopName: 'Pantaloons',
      category: 'Clothing',
      city: 'Bangalore',
      pinCode: '560021',
      ph: '4442226718',
      shopImg: 'https://im.whatshot.in/img/2019/Nov/fotojet-pantaloons-1574086822.jpg',
    ),
    Shop(
      fName: 'Jayesh',
      lName: 'Verma',
      email: 'jv@hmail.com',
      password: '1234567',
      landmark: 'HAL',
      upi: 'jayesh@okicici',
      gstNo: '000123456789',
      shopName: 'Shopper\'s Stop',
      category: 'Clothing',
      city: 'Bangalore',
      pinCode: '560016',
      ph: '7689994562',
      shopImg: 'https://images.financialexpress.com/2018/04/fe-Shoppers-stop.jpg',
    ),
    Shop(
      fName: 'Hitesh',
      lName: 'Verma',
      email: 'hv@hmail.com',
      password: '1234567',
      landmark: 'NAL',
      upi: 'hitesh@okhdfcbank',
      gstNo: '000123456789',
      shopName: 'Big Bazaar',
      category: 'Grocery',
      city: 'Bangalore',
      pinCode: '560056',
      ph: '9876856565',
      shopImg: 'https://gumlet.assettype.com/nationalherald/2020-03/856a1f7a-bcbe-4609-bfe9-300161413b61/big_bazaar_1571403097.jpg?w=1200&h=696',
    ),
    ];
  Future getShops() async
  {
    final shops = await http.get('https://omi123.pythonanywhere.com/api/user/get_shops');
    //final currUser = json.decode(users.body) as Map<String, dynamic>;
    print(json.decode(shops.body));
    dynamic currShop = json.decode(shops.body);
    // currShop.forEach((element) { 
    //   print(element);
    // });
    //print(currShop);
    // currUser.forEach((key, value) {
    //   if(value['uid'] == uid)
    //   {
    //     print(value['name']);
    //     return User(uid: uid,name: value['name'],phNo: value['phNo'],email: value['email'],password: value['password']);
    //     // return cUser;
    //     //return value;
    //   }
    // });
  }
  void initState()
  {
    getShops();
    super.initState();
  }
  String userResp='';
  List<Shop> instList=[];
  bool showList=false;

  void getList(String userResp)
  {
    setState(() {
      instList=shopList.where((e) => e.shopName.toUpperCase().startsWith(userResp.toUpperCase())).toList();
      userResp=='' ? showList=false: showList=true;
    });
    print(instList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27),),centerTitle: true,backgroundColor: Colors.orange[300],) ,
      drawer: SideDrawer(widget.user),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width*0.85,
                child: TextField(decoration: InputDecoration(labelText: 'Search for shops',),onChanged: (s){
                  userResp=s;
                  getList(userResp);
                } ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.7,
                child: instList.length==0 || userResp=='' ? Center(child: Text('No Shops found',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35))) : GridView.builder(
                        itemCount: instList.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 220,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            childAspectRatio: 1.75 / 2),
                        itemBuilder: (ctx,ind){
                          return ShopItem(landmark: instList[ind].landmark, lName: instList[ind].lName, email: instList[ind].email, password: instList[ind].password ,category: instList[ind].category, city: instList[ind].city, fName: instList[ind].fName , gstNo: instList[ind].gstNo , ph: instList[ind].ph , pinCode: instList[ind].pinCode , shopImg: instList[ind].shopImg , shopName: instList[ind].shopName , upi: instList[ind].upi,user: widget.user);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}