class Weather {
  final String condition;
  final String iconUrl;
  final double temperature;

  Weather({required this.condition, required this.iconUrl, required this.temperature});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      condition: json['current']['condition']['text'],
      iconUrl: 'https:${json['current']['condition']['icon']}',
      temperature: json['current']['temp_c'],
    );
  }
}
