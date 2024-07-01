import 'package:flutter/material.dart';
import 'package:sidang/service/api.dart';
import 'package:sidang/model/login.dart';
import 'package:sidang/screen/list.dart';
import 'package:sidang/service/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    Login? login = await _apiService.login(
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (login != null) {
      await saveAuthToken(login.token);
      _showAlertDialog('Login successful', true, login.token);
    } else {
      _showAlertDialog('Login failed', false, null);
    }
  }

  void _showAlertDialog(String message, bool success, String? authToken) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).pop(true);
          if (success && authToken != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ListScreen(authToken: authToken),
              ),
            );
          }
        });

        return AlertDialog(
          title: Text(success ? 'Success' : 'Error'),
          content: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.green[800],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Container(
                height: 320,
                width: 325,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    Image.asset(
                      'images/unand.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: _emailController,
                        style: const TextStyle(fontSize: 12),
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: _passwordController,
                        style: const TextStyle(fontSize: 12),
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      GestureDetector(
                        onTap: _login,
                        child: Container(
                          alignment: Alignment.center,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.green[500],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 15,),
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
