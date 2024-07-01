import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidang/model/profile.dart';
import 'package:sidang/screen/profile.dart';
import 'package:sidang/service/api.dart';
import 'package:sidang/model/seminar.dart';
import 'package:sidang/model/detail.dart';

class DetailSeminar extends StatefulWidget {
  final String authToken;
  final String thesisId;
  final String seminarId;

  const DetailSeminar({
    super.key,
    required this.authToken,
    required this.thesisId,
    required this.seminarId,
  });

  @override
  State<StatefulWidget> createState() => _DetailSeminarState();
}

class _DetailSeminarState extends State<DetailSeminar> {
  late Future<Seminar> _seminarFuture;
  late Future<Thesis> _thesisFuture;
  late Future<Profile?> _profileFuture;
  String? userName;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _seminarFuture = _fetchSeminar();
    _thesisFuture = _fetchThesis();
    _profileFuture = _fetchProfile();
  }

  Future<Seminar> _fetchSeminar() async {
    try {
      List<Seminar> seminars =
          await ApiService().fetchThesisSeminar(widget.authToken, widget.thesisId, widget.seminarId);
      if (seminars.isNotEmpty) {
        return seminars[0];
      } else {
        throw Exception('No seminar found');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching seminar: $e';
      });
      throw Exception('Error fetching seminar: $e');
    }
  }

  Future<Thesis> _fetchThesis() async {
    try {
      return await ApiService().fetchThesisDetail(widget.authToken, widget.thesisId);
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching thesis: $e';
      });
      throw Exception('Error fetching thesis: $e');
    }
  }

  Future<Profile?> _fetchProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? authToken = widget.authToken; 

    if (userId != null) {
      try {
        Profile profile = await ApiService().fetchProfile(authToken);
        return profile;
      } catch (e) {
        setState(() {
          errorMessage = 'Error fetching profile: $e';
        });
        print('Error fetching profile: $e');
        return null;
      }
    } else {
      setState(() {
        errorMessage = 'UserID or authToken not found';
      });
      print('UserID or authToken not found');
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Detail Seminar Hasil'),
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
        child: errorMessage != null
            ? Center(
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              )
            : FutureBuilder(
                future: Future.wait([_seminarFuture, _thesisFuture, _profileFuture]),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final seminar = snapshot.data![0] as Seminar;
                    final thesis = snapshot.data![1] as Thesis;
                    final profile = snapshot.data![2] as Profile;
                    userName = profile.name;
                    return ListView(
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
                                  thesis.title,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Nama: $userName',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tanggal:  ${DateFormat('dd MMMM yyyy').format(seminar.seminarAt)}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tempat: ${seminar.roomId}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Dosen Penguji 1: ${seminar.reviewers.isNotEmpty ? seminar.reviewers[0].reviewerId : 'N/A'}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Dosen Penguji 2: ${seminar.reviewers.length > 1 ? seminar.reviewers[1].reviewerId : 'N/A'}',
                                  style: const TextStyle(
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
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Rekomendasi',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  seminar.recommendation.toString(),
                                  style: const TextStyle(
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
                          child: Column(
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
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 375,
                                child: ListView.builder(
                                  itemCount: seminar.audiences.length,
                                  itemBuilder: (context, index) {
                                    final audience = seminar.audiences[index];
                                    return ListTile(
                                      title: Text(audience.toString()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
      )
    );
  }
}
