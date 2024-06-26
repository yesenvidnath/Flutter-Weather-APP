import 'package:flutter/material.dart';

class Weather {
  final String cityName;
  final double temprature;
  final String mainConditon;

  Weather({
    required this.cityName, 
    required this.temprature, 
    required this.mainConditon,
  });

  factory Weather.formJason(Map<String, dynamic> jason) {
    return Weather(
      cityName: jason['name'], 
      temprature: jason['main']['temp'].double(), 
      mainConditon: jason['weather'] [0] ['main'],
    );

  }
}
