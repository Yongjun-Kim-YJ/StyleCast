import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String baseUrl = "https://api.openweathermap.org/data/2.5";
  final String apiKey = "c708530f302b4fde10c6ddb3bbfdbdaa";


  Future<Map<String, dynamic>> getWeather(String city) async {
    final response = await http.get(
      Uri.parse("$baseUrl/weather?q=$city&appid=$apiKey&units=imperial"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, dynamic>> getHourlyForecast(double lat, double lon) async {
  final url = "$baseUrl/onecall?lat=$lat&lon=$lon&exclude=minutely,daily,current,alerts&appid=$apiKey&units=imperial";
  final response = await http.get(Uri.parse(url));

  print('URL: $url');  // Log the full request URL
  print('Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');  // This will show you the error message from the API

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load hourly forecast data: ${response.body}');
  }
}

}
