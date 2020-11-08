import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../models/businessSideDrawer.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:sms/sms.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BusinessHomePage extends StatefulWidget {
  BusinessHomePage({Key key, this.title,this.token,this.shopName}) : super(key: key);
  final String title;
  final String token;
  final String shopName;
  @override
  _BusinessHomePageState createState() => _BusinessHomePageState(token,shopName);
}

class _BusinessHomePageState extends State<BusinessHomePage> {
  final String token;
  final String shopName;
  _BusinessHomePageState(this.token,this.shopName);
  Map<String, double> datatime = new Map();
  Map<String, double> dataage = new Map();
  List<DataHolder> data;
  bool _loadChart = true;
  var amt=10000;
  var credit=200;
  final controller = PageController(
    initialPage: 0,
  );
  
  SmsReceiver receiver = new SmsReceiver();
  FlutterTts flutterTts = FlutterTts();
  String msg='';
  String sender='';
  List content=new List();
  String upi='';
  String username='';
  List<String> upiID=[];
  List<String> amount = [];
  String am = '';
  int x;
  listenSMS()
  {
    receiver.onSmsReceived.listen((SmsMessage s) {
      content=s.body.split(' ');
      upiID=content.where((e) => e.contains('@')).toList();
      amount = content.where((e) => e.contains('Rs')).toList();
      if(s.address.compareTo('ADICICIB')==0)
      {
        setState(() async {
          msg=s.body;
          sender=s.address;
          upi=content[content.length-1];
          username=upiID[0].split('@')[0];
          am = amount[0].substring(3);
          await flutterTts.speak('Payment recieved, from: ' + username + ',Amount: ' + am);
        });
      }

    });
  }
  fetchSMS() async
  {
    listenSMS();
  }
  String qrCodeResult;

  @override
  void initState() {
    fetchSMS();
    datatime.addAll({
      '10-12 noon': 3136,
      '12-2pm': 2241,
      '2-4pm': 1249,
      '4-6pm':2150,
      '6-8pm':6679,
      '8-10pm':4342
    });
    dataage.addAll({
      '<20': 2419,
      '20-30': 9612,
      '30-40': 4045,
      '40-50':2112,
      '>50':3150
    });
    super.initState();
    data = [
      DataHolder(
        month: 'Jan',
        amount: 10000,
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      DataHolder(
        month: 'Feb',
        amount: 9500,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      DataHolder(
        month: 'March',
        amount: 12311,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
    ];
  }

  List<Color> _colors = [
    Colors.teal,
    Colors.blueAccent,
    Colors.amberAccent,
    Colors.cyanAccent,
    Colors.lightGreenAccent,
    Colors.deepPurpleAccent
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.orange[300],
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: ()async{
                List<String> qrData;
                ScanResult codeScanner;
                codeScanner = await BarcodeScanner.scan(
                  options: ScanOptions(
                    useCamera: -1,
                  ),
                ).then((value){
                  setState(()async{
                    qrCodeResult = codeScanner.rawContent;
                    qrData = qrCodeResult.split(' ');
                    print(qrData);
                    http.Response resp;
                          resp = await http.post('https://omi123.pythonanywhere.com/api/transactions/make_transaction',
                            headers: <String,String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                              'Authorization': 'Token '+token,
                            },
                            body: json.encode({
                              'to': qrData[1],
                              'amount': double.parse(qrData[2]),
                              'transaction_id': qrData[3],
                            })
                          ).then((value){
                            print(value.body);
                    });
                  });
                }); //barcode scanner
                
                
                
                      print(data);
                //custUpiId+' '+merchantUpiId+' '+amount.toString()+' '+data.substring(data.lastIndexOf('=')+1)
              }),
        ],
      ),
      drawer: BusinessSideDrawer(token,shopName),
      body: Center(
        child: PageView(
          controller: controller,
          children: <Widget>[
            SingleChildScrollView(
                          child: Center(child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Welcome, ' + shopName,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  Text('Swipe left to view more analytics'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Total Sales\n$amt',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Total Credit\n$credit',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _loadChart ? PieChart(
                    dataMap: datatime,
                    colorList:
                    _colors, // if not declared, random colors will be chosen
                    animationDuration: Duration(milliseconds: 1500),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width /
                        2.5, //determines the size of the chart
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    showLegends: true,
                    legendPosition:
                    LegendPosition.right, //can be changed to top, left, bottom
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.disc, //can be changed to ChartType.ring
                  ) : SizedBox(
                    height: 110,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Timewise sales breakup',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _loadChart ? PieChart(
                    dataMap: dataage,
                    colorList:
                    _colors, // if not declared, random colors will be chosen
                    animationDuration: Duration(milliseconds: 1500),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width /
                        2.5, //determines the size of the chart
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    showLegends: true,
                    legendPosition:
                    LegendPosition.right, //can be changed to top, left, bottom
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.disc, //can be changed to ChartType.ring
                  ) : SizedBox(
                    height: 110,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Agewise sales breakup',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              ),
            ),
            //Center(child: MyBarChart(data)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 200,
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Card(
                    child: MyBarChart(data),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Monthly Sales',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}
class DataHolder {
  final String month;
  final double amount;
  final charts.Color barColor;

  DataHolder({
    @required this.amount,
    @required this.month,
    @required this.barColor,
  });
}
class MyBarChart extends StatelessWidget {
  final List<DataHolder> data;

  MyBarChart(this.data);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DataHolder, String>> series = [
      charts.Series(
          id: 'AppDownloads',
          data: data,
          domainFn: (DataHolder downloads, _) => downloads.month,
          measureFn: (DataHolder downloads, _) => downloads.amount,
          colorFn: (DataHolder downloads, _) => downloads.barColor)
    ];

    return charts.BarChart(
      series,
      animate: true,
      barGroupingType: charts.BarGroupingType.groupedStacked,
    );
  }
}