import 'package:clima_13_angella/services/weather.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.locationWeather});
  @override
  State<LocationScreen> createState() => _LocationScreenState();
  final dynamic locationWeather;
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;

  @override
  void initState() {
    updateUI(widget.locationWeather);
    super.initState();
  }
  void updateUI( weatherData)
  {
   setState(() {
     //checking if location!=null before we use weatherData in our widget
     if(weatherData==null)
         {temperature=0;
           weatherIcon="Error" ;
           weatherMessage="Unable to get weatherData" ;
           cityName="";
           return;
         }
     temperature = ((weatherData["main"]["temp"]-32)/18000).toInt();
     var condition = weatherData["weather"][0]["id"];
     weatherIcon = weather.getWeatherIcon(condition);
     cityName = weatherData["name"];
     weatherMessage = weather.getMessage(temperature);
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      var weatherData =await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      color: Colors.white,
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const CityScreen();
                      }));
                      if(typedName!=null)
                        {
                          var weatherData = await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                    },
                    child: const Icon(
                      color: Colors.white,
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



