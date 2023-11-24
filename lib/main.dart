// ignore_for_file: must_be_immutable, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:slide_action/slide_action.dart';
// import cuperino activity indicator
import 'package:flutter/cupertino.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),

        // make it dark mode by default
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

// flutter statful widget called Home
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    // create a shop page where you can buy stuff. used card design and a listview
    return Scaffold(
      
        body: ListView(padding: const EdgeInsets.all(8), children: [
      ShopItem(
        title: "Tomato Seeds",
        description: "Plant them in soil to grow your own tomato plant. \nOne plant / seed pack.",
        assetUrl: "assets/tomato.png",
      ),
      ShopItem(
        title: "Premium Soil Pack",
        assetUrl: "assets/premium.png",

        description: "Provides the most amount of nutrition for the allowing the fastest development of your plant.",
      ),
      ShopItem(
        title: "Standard Soil Pack",
        assetUrl: "assets/soil.png",

        description: "Provides sufficient nutrition for your plant. Replace when the soil has been exhausted.",
      ),
    ]));
  }
}

class ShopItem extends StatelessWidget {
  ShopItem({
    super.key,
    this.title = "Soil pack",
    this.description = "A pack of soil for your plant",
    this.assetUrl = "https://placekitten.com/200/300",
  });

  String title;
  String description;
  String assetUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        
        mainAxisSize: MainAxisSize.min,
        children: [
          // image from placekitten
          Center(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              // make the image have rouneded corners
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(assetUrl),
              ),
            ),
          )),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text(
              title,
              textAlign: TextAlign.start,
            ),
            subtitle: Text(description),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('Learn More'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Buy'),
                  onPressed: () {/* ... */},
                  // make it more visible
                  //  make it filled
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// flutter state called _HomeState
class _HomeState extends State<Home> {
  bool isLoadingWater = false;

  var navbarSelectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const NavigationDestination(
            // icon: Icon(Icons.settings),
            label: 'Shop',
            // shop icon
            icon: Icon(Icons.shopping_bag),
          ),
          const NavigationDestination(
            // icon: Icon(Icons.person),
            label: 'Forum',
            // forum icon
            icon: Icon(Icons.forum),
          ),
          const NavigationDestination(
            // icon: Icon(Icons.person),
            label: 'Guides',
            // guides icon
            icon: Icon(Icons.book),
          ),
        ],
        selectedIndex: navbarSelectedIndex,
        onDestinationSelected: (index) => setState(() {
          navbarSelectedIndex = index;
        }),
      ),
      appBar: AppBar(
        title: navbarSelectedIndex == 0
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Jeff The Tomato",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            Row(
              children: [
                const Text(
                  "GreenBox Online",
              style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
                // a green cirlce
                Padding(
                  padding: const EdgeInsets.only(top: 3.7),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(left: 5.0),
                      width: 10.0,
                      height: 10.0,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
              )
            : Text("Shop"),
      ),
      body: [
        SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(
                    labelPadding: const EdgeInsets.all(2.0),
                    avatar: const CircleAvatar(
                    // backgroundColor: Colors.white70,
                    child: Text("1"),
                  ),
                    label: const Text(
                    " Warning",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  // backgroundColor: Colors.red,
                  elevation: 6.0,
                  shadowColor: Colors.grey[60],
                    padding: const EdgeInsets.all(10.0),
                ),
              ),
              Text(
                'Humidity over time',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.green),
              ),
              Text(
                'OK!',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.green),
              ),
              SizedBox(
                height: 200,
                child: LineChartSample2(
                  // generate spots in a way that the first number increases and the second is a random number
                  spots: List.generate(
                    12,
                    (index) {
                      var rng = Random();
                      double randomNumber = 3 + rng.nextDouble() * (5 - 3);

                      return FlSpot(
                        index.toDouble(),
                        // completly random number between 0 and 5 as double
                        randomNumber,
                      );
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Divider(),
              ),
              Text(
                'Soil quality',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.red),
              ),
              Text(
                'ISSUES!',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red),
              ),
              SizedBox(
                height: 200,
                child: LineChartSample2(
                    gradient: const [Colors.orange, Colors.red],
                  // generate spots in a way that the first number increases and the second is a random number
                  spots: const [
                    FlSpot(0, 4.8),
                    FlSpot(1, 4.7),
                    FlSpot(2, 4.5),
                    FlSpot(3, 4.1),
                    FlSpot(4, 3.8),
                    FlSpot(5, 3.8),
                    FlSpot(6, 3.2),
                    FlSpot(7, 2.3),
                    FlSpot(8, 2.3),
                    FlSpot(9, 2.3),
                    FlSpot(10, 2.1),
                    FlSpot(11, 2.0),
                  ],
                ),
              ),
              // add a button with the text "learn more" with a filled style

              // add a listtile with a leading icon of a little ? and a title of "What does this mean?"
                const ListTile(
                leading: Icon(Icons.help_outline),
                title: Text(
                    'You should by new soil and replace the old soil. If not your plant will die in a terrible way. You can replace the soil by purchaising new soil pack from us.'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Put your action here
                  },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // This is the background color
                  onPrimary: Colors.white, // This is the color of the text
                ),
                  child: const Text('Head to shop'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Divider(),
              ),
              Text(
                'Seed growth',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 200,
                child: LineChartSample2(
                  // generate spots in a way that the first number increases and the second is a random number
                  spots: List.generate(
                    12,
                    (index) {
                      var rng = Random();
                      double randomNumber = 3 + rng.nextDouble() * (5 - 3);

                      return FlSpot(
                        index.toDouble(),
                        // completly random number between 0 and 5 as double
                        randomNumber,
                      );
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Divider(),
              ),
              Text(
                'Temp over time',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 200,
                child: LineChartSample2(
                  spots: const [
                    FlSpot(0, 5),
                    FlSpot(2.6, 2),
                    FlSpot(4.9, 5),
                    FlSpot(6.8, 3.1),
                    FlSpot(8, 4),
                    FlSpot(9.5, 3),
                    FlSpot(11, 4),
                  ],
                ),
              ),
              Text(
                'Slide to water',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SlideAction(
                  stretchThumb: true,
                  trackBuilder: (context, state) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Swipe to water!",
                        ),
                      ),
                    );
                  },
                  thumbBuilder: (context, state) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        // use theme data color
                        // color: Colors,
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: isLoadingWater
                            ? const CupertinoActivityIndicator(
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                              ),
                      ),
                    );
                  },
                  action: () async {
                    debugPrint("Hello World");
                    setState(() {
                      isLoadingWater = true;
                    });
                    await Future.delayed(
                      const Duration(seconds: 2),
                      () => {
                        setState(() {
                          isLoadingWater = false;
                        })
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
        ),
        const ShopPage()
      ][navbarSelectedIndex],
     
    );
  }
}

class LineChartSample2 extends StatefulWidget {
  // const LineChartSample2({super.key});
  // LineChartSample2({Key? key, required this.spots}) : super(key: key);
  LineChartSample2({Key? key, required this.spots, this.gradient = const [Colors.lightGreen, Colors.green]}) : super(key: key);
  List<Color> gradient;
  List<FlSpot> spots;
  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('10:00', style: style);
        break;
      case 5:
        text = const Text('10:30', style: style);
        break;
      case 8:
        text = const Text('11:00', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    text = const Text('', style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    if (value.toInt() % 2 == 0) {
      text = "${value.toInt() * 10}%";
    } else {
      text = "";
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.shade800,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey.shade800,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: widget.spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: widget.gradient,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: widget.gradient.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
