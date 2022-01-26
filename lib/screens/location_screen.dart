import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../services/weather.dart';
import '../screens/city_screen.dart';

WeatherModel weatherModel = WeatherModel();

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temprature = 0;
  String weatherIcon = "";
  String message = "";
  String backgroundImg = "";

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temprature = 0;
        weatherIcon = "Error";
        message = "Unable to Load weather Data";
        backgroundImg = "background5.jpg";
      } else {
        double temp = weatherData['main']['temp'];
        temprature = temp.toInt();
        int condition = weatherData['weather'][0]['id'];
        weatherIcon = weatherModel.getWeatherIcon(condition);
        message = weatherModel.getMessage(temprature);
        String cityName = weatherData['name'];
        message = '$message in $cityName';
        backgroundImg = weatherModel.getBackground(condition);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/$backgroundImg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        var weatherData = await weatherModel.getWeatherData();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: kIconSize,
                        color: kIconColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        // print(typedName);
                        if(typedName!=null) {
                          var weatherData = await weatherModel.getCityWeather(typedName);
                          // print(weatherData);
                          updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: kIconSize,
                        color: kIconColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: kPaddingLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$temprature°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: kPaddingAll,
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: kMessageTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
