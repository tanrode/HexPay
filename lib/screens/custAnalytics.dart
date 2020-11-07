import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CustomerAnalytics extends StatelessWidget {
  final String fName;
  CustomerAnalytics(this.fName);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Analytics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustAnalytics(title: 'Analytics',fName: fName,),
    );
  }
}

class CustAnalytics extends StatefulWidget {
  CustAnalytics({Key key, this.title,this.fName}) : super(key: key);
  final String title;
  final String fName;
  @override
  _CustAnalyticsState createState() => _CustAnalyticsState(fName);
}

class _CustAnalyticsState extends State<CustAnalytics> {
  final String name;
  _CustAnalyticsState(this.name);
  Map<String, double> datacat = new Map();
  List<DataHolder> data;
  bool _loadChart = true;
  var amt=10000;
  var credit=200;
  var creditrating=93.5;
  final controller = PageController(
    initialPage: 0,
  );


  @override
  void initState() {
    datacat.addAll({
      'Grocery': 2419,
      'Fruits and vegetables':2300,
      'Food Orders': 9612,
      'Retail': 4045,
      'Laundry':2112,
      'Others':3150
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
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.orange[300],
      ),
      body: Center(
        child: PageView(
          controller: controller,
          children: <Widget>[
            Center(child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Welcome, ' + name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                Text('Swipe left to view more Analytics'),                
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
                  height: 50,
                ),
                _loadChart ? PieChart(
                  dataMap: datacat,
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
                  'Your Expenditure Breakdown',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
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
                      'Monthly Expenditure',
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