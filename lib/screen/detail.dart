import 'package:flutter/material.dart';
import 'package:sidang/model/detail.dart';
import 'package:sidang/screen/detail_seminar.dart';
import 'package:sidang/screen/daftar_seminar.dart';
import 'package:sidang/screen/daftar_sidang.dart';
import 'package:sidang/screen/profile.dart';
import 'package:sidang/service/api.dart';
import 'package:intl/intl.dart';

class Detail extends StatefulWidget {
  final String authToken;
  final String thesisId;

  const Detail({super.key, required this.thesisId, required this.authToken});

  @override
  State<StatefulWidget> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Future<Thesis> _thesisFuture;

  @override
  void initState() {
    super.initState();
    _thesisFuture = _fetchThesis();
  }

  Future<Thesis> _fetchThesis() async {
    try {
      final thesis = await ApiService().fetchThesisDetail(widget.authToken, widget.thesisId);
      return thesis;
    } catch (e) {
      throw Exception('Error fetching thesis: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Detail Tugas Akhir'),
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
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<Thesis>(
          future: _thesisFuture,
          builder: (context, AsyncSnapshot<Thesis> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final thesis = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              thesis.status == 1 ? 'Bimbingan' : 'Gagal',
                              style: TextStyle(
                                color: thesis.status == 1 ? Colors.green : Colors.red,
                              ),
                            ),
                            const SizedBox(height: 16),
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
                                color: Colors.blue[200],
                              ),
                              child: Text(
                                thesis.topicId, 
                                style: TextStyle(
                                  color: Colors.blue[800],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Dosen Pembimbing: ${thesis.supervisors.map((supervisor) => supervisor.lecturerId).join(', ')}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tanggal Mulai: ${DateFormat('dd MMMM yyyy').format(thesis.startAt)}', 
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (thesis.seminars.isNotEmpty) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => DetailSeminar(
                                          authToken: widget.authToken,
                                          thesisId: widget.thesisId,
                                          seminarId: thesis.seminars.first.id,)), 
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Error'),
                                            content: const Text('Seminar belum terdaftar untuk tugas akhir ini.'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: const Text('Detail Seminar'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DaftarSeminar(
                                          thesisId: widget.thesisId,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Daftar Seminar'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => DaftarSidang(
                                        thesisId: widget.thesisId,
                                      )), 
                                    );
                                  },
                                  child: const Text('Daftar Sidang'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
