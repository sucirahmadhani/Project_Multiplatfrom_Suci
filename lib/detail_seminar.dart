import 'package:flutter/material.dart';
import 'package:sidang/navbar.dart';

class DetailSeminar extends StatefulWidget {
  const DetailSeminar ({super.key});
  
  @override
  State<StatefulWidget> createState() => _DetailSeminarState();
}

class _DetailSeminarState extends State<DetailSeminar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Detail Seminar Hasil'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pembangunan Sistem Informasi xxx',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        height: 1.5,
                      ),
                    ), 
                    SizedBox(height: 8),
                    Text(
                      'Nama                        : Suci Rahmadhani',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tanggal                    : 12 April 2024',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tempat                     : Ruang Seminar DSI',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Dosen Penguji 1      : Rahmatika Pratama Santi, MT',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Dosen Penguji 2      : Hasdi Putra, MT',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rekomendasi',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Peserta Seminar',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Total: 20',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 375,
                    child: Expanded(
                      child: ListView(
                        children: const [
                          ListTile(
                            title: Text('Winda Adelia'),
                            subtitle: Text("2111521002"),
                          ),
                          ListTile(
                            title: Text('Winda Adelia'),
                            subtitle: Text("2111521002"),
                          ),
                          ListTile(
                            title: Text('Winda Adelia'),
                            subtitle: Text("2111521002"),
                          ),
                          ListTile(
                            title: Text('Winda Adelia'),
                            subtitle: Text("2111521002"),
                          ),
                          ListTile(
                            title: Text('Winda Adelia'),
                            subtitle: Text("2111521002"),
                          ),
                          ListTile(
                            title: Text('Winda Adelia'),
                            subtitle: Text("2111521002"),
                          ),
                          ListTile(
                            title: Text('Winda Adelia'),
                            subtitle: Text("2111521002"),
                          ),
                          ListTile(
                            title: Text('Winda Adelia'),
                            subtitle: Text("2111521002"),
                          ),
                          ListTile(
                            title: Text('Winda Adelia'),
                            subtitle: Text("2111521002"),
                          ),
                          ListTile(
                            title: Text('Winda Adelia'),
                            subtitle: Text("2111521002"),
                          ),
                          ListTile(
                            title: Text('Winda Adelia'),
                            subtitle: Text("2111521002"),
                          ),
                        ],
                      ), 
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}