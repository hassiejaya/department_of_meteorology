// ignore_for_file: avoid_print, non_constant_identifier_names, unused_field, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

int set1 = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _date_time = '';
  double _temp = 0;
  double _humidity = 0;
  double _wind_speed = 0;
  double _wind_direcrion = 0;
  String _light_intensity = '';
  double _solar_irradiation = 0;
  double _rainfall = 0;
  double rainheight = 30;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    DatabaseReference envParams = FirebaseDatabase.instance.ref('/envData');
    envParams.onValue.listen((DatabaseEvent event) {
      setState(() {
        print('value change detected');
      });
    });
  }

  void setData() {
    DatabaseReference envParams = FirebaseDatabase.instance.ref('/envData');
    envParams.onValue.listen((DatabaseEvent event) {
      final Map data = event.snapshot.value as Map;

      _date_time = data['date-time'];
      _temp = double.parse(data['temp']);
      _humidity = double.parse(data['humidity']);
      _wind_speed = double.parse(data['wind-speed']);
      _wind_direcrion = double.parse(data['wind-direction']);
      _light_intensity = data['light-intensity'];
      _solar_irradiation = double.parse(data['solar-irradiation']);
      _rainfall = double.parse(data['rainfall']);
      if (_rainfall < 30) {
        rainheight = 30;
      } else if (_rainfall > 250) {
        rainheight = 250;
      } else {
        rainheight = _rainfall;
      }

      // print('data set');

      //print(_date_time);
      //print(_temp);
      //print(_humidity);
      //print(_wind_speed);
      //print(_wind_direcrion);
      //print(_light_intensity);
      //print(_solar_irradiation);
      //print(_rainfall);
      if (set1 == 0) {
        setState(() {
          print("intial set state");
          set1++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //_incrementCounter();
    setData();

    DatabaseReference envParams = FirebaseDatabase.instance.ref('/envData');
    envParams.onChildChanged.listen((DatabaseEvent event) {
      setState(() {
        print('value change detected2');
      });
    });
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: const [
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.all(18),
                      width: 215,
                      height: 115,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromARGB(255, 177, 21, 238),
                              Color.fromARGB(255, 224, 105, 41),
                            ],
                          )),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text("last update on",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 10,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                )),
                          ),
                          Text(
                            _date_time,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 35,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                  Container(
                    margin: const EdgeInsets.all(18),
                    child: Text(
                      '$_temp °C',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 36,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(40, 20, 20, 0),
                        child: SleekCircularSlider(
                          appearance: CircularSliderAppearance(
                              infoProperties: InfoProperties(
                                  mainLabelStyle: const TextStyle(
                                color: Color.fromARGB(255, 65, 244, 247),
                                fontSize: 36,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                height: 1,
                              )),
                              customColors: CustomSliderColors(
                                  trackColor:
                                      const Color.fromARGB(255, 9, 255, 165),
                                  progressBarColors: [
                                    const Color.fromARGB(255, 0, 162, 236),
                                    const Color.fromARGB(255, 9, 255, 165)
                                  ]),
                              customWidths:
                                  CustomSliderWidths(progressBarWidth: 15)),
                          min: 0,
                          max: 100,
                          initialValue: _humidity,
                        ),
                      ),
                      const Text(
                        '    Humidity',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          height: 0.2,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 20, 20, 14),
                        padding: const EdgeInsets.fromLTRB(0, 47, 0, 0),
                        height: 140,
                        width: 140,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/sun2.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _solar_irradiation.toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 27,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                height: 2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              "W/m^2",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 13,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                height: 2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "Solar Irradiation",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          height: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(30, 30, 0, 20),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 0.1),
                      image: const DecorationImage(
                          image: AssetImage("assets/images/bulb.webp"),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                      height: 68,
                      width: 257,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromARGB(255, 239, 212, 67),
                              Color.fromARGB(255, 57, 210, 192),
                              //Color.fromARGB(255, 103, 58, 183),
                              Color.fromARGB(255, 33, 150, 243),
                            ],
                          )),
                      child: Column(
                        children: [
                          Text(
                            _light_intensity,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 36,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              height: 1.7,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text("Lux",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 15,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                )),
                          ),
                        ],
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Material(
                        shape: const CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        elevation: 4.0,
                        child: Container(
                          height: 250,
                          width: 250,
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Transform.rotate(
                            angle: (_wind_direcrion * (3.141 / 180) * 1),
                            child: Image.asset('assets/images/compass.jpg'),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                          "Wind Speed and Direction",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 23,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            height: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                          '${_wind_speed.toStringAsPrecision(3)} km/h $_wind_direcrion °',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 23,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            height: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25, 20, 0, 10),
                      child: Text(
                        'Rainfall',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          height: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(50, 0, 20, 0),
                        width: 35,
                        height: rainheight,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromARGB(255, 40, 2, 254),
                                Color.fromARGB(255, 7, 159, 235),
                              ],
                            )),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(7.0),
                              child: Text(_rainfall.toString(),
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 10,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                  )),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Text(
                        '$_rainfall mm',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 23,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          height: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ])
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
