import 'package:clima_13_angella/screens/location_screen.dart';
import 'package:clima_13_angella/services/weather.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? lat, long;

  Future askLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted == false) {
      await Permission.location.request();
    }
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    if (context.mounted){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LocationScreen(locationWeather: weatherData)));
    }
  }

  @override
  void initState() {
    askLocationPermission();
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
                child: SpinKitRotatingCircle(
                  color: Colors.white,
                  size: 50.0,
                ),
              ));
  }
}
