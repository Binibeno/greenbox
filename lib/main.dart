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
      debugShowCheckedModeBanner: false,
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
          if (navbarSelectedIndex > 1) {
            navbarSelectedIndex = 1;
          }
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
                      " Action Needed",
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
                //  sizedbox
                const SizedBox(
                  height: 10,
                ),

               
                InfoBox(
                  isOK: false,
                  title: 'Soil Quality',
                  status: 'ISSUES!',
                  max: 6,
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
                // add a listtile with a leading icon of a little ? and a title of "What does this mean?"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Card(
                    child: const ListTile(
                      leading: Icon(Icons.help_outline),
                      title: Text(
                          'You should by new soil and replace the old soil. If not your plant will die in a terrible way. You can replace the soil by purchaising new soil pack from us.'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Put your action here
                      },
                      child: const Text('Learn more in our guides'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          navbarSelectedIndex = 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // This is the background color
                        onPrimary: Colors.white, // This is the color of the text
                      ),
                      child: const Text('Head to shop'),
                    ),
                  ],
                ),
                //sizedbox
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 8,
                ),

                InfoBox(
                  max: 6,
                  title: "Soil Moisture",
                  status: "NORMAL",
                  isOK: true,
                  spots: const [
                    FlSpot(0, 4.8),
                    FlSpot(1, 4.7),
                    FlSpot(2, 4.5),
                    FlSpot(3, 4.1),
                    FlSpot(4, 4.05),
                    FlSpot(5, 4.0),
                    FlSpot(6, 3.8),
                    FlSpot(7, 3.6),
                    FlSpot(8, 3.4),
                    FlSpot(9, 3.0),
                    FlSpot(10, 2.7),
                    FlSpot(11, 2.0),
                  ],
                ),
Padding(
                  padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 16.0),
                  child: SlideAction(
                    stretchThumb: true,
                    trackBuilder: (context, state) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color.fromRGBO(38, 35, 41, 1),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Swipe to water your crop!",
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
                          color: Color.fromRGBO(75, 67, 88, 1),
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
                ),
                // sizedbox 8

                InfoBox(
                  title: "Box Humidity",
                  status: "NORMAL",
                  isOK: true,
                  max: 6,
                  textGenerator: (value) {
                    return ["48%", "50%", "52%", "54%", "56%", "58%", "60%"][value.toInt()];
                  },
                  // random generated spots
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
                  labelPrefix: "%",
                ),
                const SizedBox(
                  height: 8,
                ),
                InfoBox(
                  textGenerator: (value) {
                    return ["18°C", "20°C", "22°C", "24°C", "26°C", "28°C"][value.toInt()];
                  },
                  max: 4,
                  spots: const [
                    FlSpot(0, 2.1),
                    FlSpot(2.6, 3),
                    FlSpot(4.9, 3.2),
                    FlSpot(6.8, 2.4),
                    FlSpot(8, 2.2),
                    FlSpot(9.5, 2.3),
                    FlSpot(11, 2.1),
                  ],
                  title: "Box Temperature",
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

class InfoBox extends StatefulWidget {
  InfoBox({
    super.key,
    this.title = "Box Temperature",
    this.status = "NORMAL",
    this.isOK = true,
    this.max = 4,
    this.textGenerator,
    this.spots = const [
      FlSpot(0, 2.1),
      FlSpot(2.6, 3),
      FlSpot(4.9, 3.2),
      FlSpot(6.8, 3.4),
      FlSpot(8, 3.7),
      FlSpot(9.5, 3.8),
      FlSpot(11, 3.8),
    ],
    this.labelPrefix = "°C",
  });
  String title;
  String status;
  bool isOK;
  // spots
  List<FlSpot> spots;

  int max;
  // textgenerator function
  Function(double)? textGenerator;
  // prefix
  String labelPrefix;
  @override
  State<InfoBox> createState() => _InfoBoxState();
}

class _InfoBoxState extends State<InfoBox> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: widget.isOK ? Colors.green : Colors.red),
              ),
              Text(
                widget.status,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: widget.isOK ? Colors.green : Colors.red),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width - 70,
          child: Center(
            child: LineChartSample2(
                labelPrefix: widget.labelPrefix,
                max: widget.max.toDouble(),
                textGenerator: widget.textGenerator,
                spots: widget.spots,
                gradient: widget.isOK ? [Colors.lightGreen, Colors.green] : [Colors.orange, Colors.red]
            ),
          ),
        ),
      ]),
    );
  }
}

class LineChartSample2 extends StatefulWidget {
  // const LineChartSample2({super.key});
  // LineChartSample2({Key? key, required this.spots}) : super(key: key);
  LineChartSample2(
      {Key? key,
      this.showLabels = true,
      required this.spots,
      this.labelPrefix = "%",
      this.min = 0,
      this.max = 6,
      this.textGenerator,
      this.gradient = const [Colors.lightGreen, Colors.green]})
      : super(key: key);
  List<Color> gradient;
  Function(double)? textGenerator;
  double min = 0;
  double max = 6;

  String labelPrefix = "%";
  List<FlSpot> spots;
  bool showLabels = true;
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

    if (widget.textGenerator != null) {
      text = widget.textGenerator!(value);
    } else {
      if (value.toInt() % 2 == 0) {
        text = "${value.toInt() * 10}${widget.labelPrefix}";
      } else {
        text = "";
      }
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
        show: widget.showLabels,
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
      minY: widget.min,
      maxY: widget.max,
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
