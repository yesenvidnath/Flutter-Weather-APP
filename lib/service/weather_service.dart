import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;
class WeatherService{

  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName ) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 2000) {
      return Weather.formJason(jsonDecode(response.body));
    }else {
      throw Exception('Faild to load data');
    }
  }

  //Get the Currunt City
  Future<String> getCurruntCity() async {

    //get permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){

      permission = await Geolocator.requestPermission();
    }

    //fetch the currrunt location 
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

    //convert in to a list of CIty names
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    //Extract the city name from the first city mark
    String? city = placemarks[0].locality; 

    return city ?? "";
  }

}