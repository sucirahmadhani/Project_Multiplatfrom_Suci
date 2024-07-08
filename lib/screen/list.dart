import 'package:flutter/material.dart';
import 'package:sidang/model/theses.dart';
import 'package:sidang/model/weather.dart';
import 'package:sidang/screen/detail.dart';
import 'package:sidang/screen/profile.dart';
import 'package:sidang/service/api.dart';

class ListScreen extends StatefulWidget {
  final String authToken;

  const ListScreen({super.key, required this.authToken});

  @override
  State<StatefulWidget> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late Future<List<Theses>> _thesesList;
  late Future<Weather> _weatherData;

  @override
  void initState() {
    super.initState();
    _thesesList = ApiService().fetchTheses(widget.authToken);
     _weatherData = ApiService().fetchWeather('Padang');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Tugas Akhir'),
        centerTitle: true,
        backgroundColor: Colors.green[200],
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<Weather>(
            future: _weatherData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('No weather data available');
              } else {
                final weather = snapshot.data!;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(weather.iconUrl),
                    const SizedBox(width: 8),
                    Text('${weather.temperature}°C, ${weather.condition}'),
                  ],
                );
              }
            },
          ),
          Expanded(
            child: FutureBuilder<List<Theses>>(
              future: _thesesList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Theses thesis = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detail(authToken: widget.authToken, thesisId: thesis.id),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    thesis.title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: thesis.status == 0 ? Colors.red[200] : Colors.green[200],
                                    ),
                                    child: Text(
                                      thesis.status == 0 ? 'Gagal' : 'Bimbingan',
                                      style: TextStyle(
                                        color: thesis.status == 0 ? Colors.red[800] : Colors.green[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
