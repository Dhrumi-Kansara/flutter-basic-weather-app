import '../services/location.dart'; 
import '../services/networking.dart';

const String apiKey = '344a533a2f539e48d32570e5ca9b07a2';
const String openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(cityName) async {

    String url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url: url);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getWeatherData() async {

    Location location = Location();

    await location.getCurrentLocation();

    String url = '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url: url);

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getBackground(int condition) {
    String rainBackground="rain.jpg"; 

    if (condition < 300) {
      return rainBackground;
    } else if (condition < 400) {
      return rainBackground;
    } else if (condition < 600) {
      return rainBackground;
    } else if (condition < 700) {
      return 'snow.jpg';
    } else if (condition < 800) {
      return 'fog.jpg';
    } else if (condition == 800) {
      return 'sunny.jpg';
    } else if (condition <= 804) {
      return 'cloudy';
    } else {
      return 'background5.jpg';
    }
  }


  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
