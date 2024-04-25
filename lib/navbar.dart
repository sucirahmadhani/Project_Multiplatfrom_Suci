import 'package:flutter/material.dart';
import 'package:sidang/daftar_seminar.dart';
import 'package:sidang/daftar_sidang.dart';
import 'package:sidang/detail_seminar.dart';
import 'package:sidang/list.dart';


class NavBar extends StatelessWidget {
  const NavBar({super.key});
  
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
          ListTile (
            leading: const Icon(Icons.list_alt),
            title: const Text('List Tugas Akhir'),
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context)=> const List()),
              );
            },
          ),
          ListTile (
            leading: const Icon(Icons.note_alt_outlined),
            title: const Text('Daftar Seminar Hasil'),
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context)=> const DaftarSeminar()),
              );
            },
          ),
          ListTile (
            leading: const Icon(Icons.notes_sharp),
            title: const Text('Detail Seminar Hasil'),
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context)=> const DetailSeminar()),
              );
            },
          ),
          ListTile (
            leading: const Icon(Icons.queue_outlined),
            title: const Text('Daftar Sidang Tugas Akhir'),
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context)=> const DaftarSidang()),
              );
            },
          ),
        ]
      ),
    );

  }
}
