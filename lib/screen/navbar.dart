import 'package:flutter/material.dart';
import 'package:sidang/screen/daftar_seminar.dart';
import 'package:sidang/screen/daftar_sidang.dart';
import 'package:sidang/screen/detail_seminar.dart';
import 'package:sidang/screen/list.dart';
import 'package:sidang/service/shared_preferences.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key});

  Future<void> _navigateToListScreen(BuildContext context) async {
    String? authToken = await getAuthToken();
    if (authToken != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListScreen(authToken: authToken),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No auth token found, please login first')),
      );
    }
  }

  Future<void> _navigateToDetailSeminar(BuildContext context) async {
    Map<String, String?> ids = await getIds();
    String? thesisId = ids['thesisId'];
    String? seminarId = ids['seminarId'];
    
    if (thesisId != null && seminarId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailSeminar(
            authToken: 'authToken', 
            thesisId: thesisId,
            seminarId: seminarId,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ThesisId or SeminarId not found')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: 100,
            child: const Text(
              'M E N U',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('List Tugas Akhir'),
            onTap: () => _navigateToListScreen(context),
          ),
          ListTile(
            leading: const Icon(Icons.note_alt_outlined),
            title: const Text('Daftar Seminar Hasil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DaftarSeminar(thesisId: 'thesisId',)),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notes_sharp),
            title: const Text('Detail Seminar Hasil'),
            onTap: () => _navigateToDetailSeminar(context),
          ),
          ListTile(
            leading: const Icon(Icons.queue_outlined),
            title: const Text('Daftar Sidang Tugas Akhir'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DaftarSidang(thesisId: 'thesisId',)),
              );
            },
          ),
        ],
      ),
    );
  }
}
