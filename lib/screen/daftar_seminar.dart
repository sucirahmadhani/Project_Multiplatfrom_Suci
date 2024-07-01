import 'package:flutter/material.dart';
import 'package:sidang/screen/profile.dart';
import 'package:sidang/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaftarSeminar extends StatefulWidget {
  final String thesisId;
  const DaftarSeminar({super.key, required this.thesisId});

  @override
  State<StatefulWidget> createState() => _DaftarSeminarState();
}

class _DaftarSeminarState extends State<DaftarSeminar> {
  final TextEditingController _abstractController = TextEditingController();
  final TextEditingController _keywordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  void _registerSeminar() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('authToken');

      if (authToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to get auth token')),
        );
        return;
      }

      final success = await apiService.registerSeminar(widget.thesisId, {
        'abstract': _abstractController.text,
        'keyword': _keywordController.text,
      }, authToken);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Seminar registered successfully')),
        );
        Future.delayed(const Duration(milliseconds: 500), () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Seminar registered successfully'),
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
        });

        print('Seminar registered successfully');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to register seminar')),
        );
        print('Failed to register seminar');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Daftar Seminar Hasil'),
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _abstractController,
                      autocorrect: false,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: 'Abstrak',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                      ),
                      maxLines: null,
                      minLines: 10,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Abstrak tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _keywordController,
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Keyword',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.green),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Keyword tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: _registerSeminar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size(400, 50),
                        ),
                        child: const Text(
                          "Daftar",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
