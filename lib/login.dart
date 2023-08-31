import 'dart:convert';
import 'package:ecommerce/home.dart';
import 'package:ecommerce/session_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  void login() async {
    Map<String, String> jsonData = {
      "username": _username.text,
      "password": _password.text
    };

    Map<String, String> requestBody = {
      "operation": "login",
      "json": jsonEncode(jsonData),
    };

    var res = await http.post(
      Uri.parse("${SessionStorage.url}users.php"),
      body: requestBody,
    );

    if (res.body != "0") {
      var resBody = jsonDecode(res.body);
      SessionStorage.name = resBody["user_fullname"];
      SessionStorage.email = resBody["user_email"];
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Invalid username or password"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _username,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Username",
              ),
              validator: (value) {
                return value == null || value.isEmpty ? "This field is required" : null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              obscureText: _isObscure,
              controller: _password,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                ),
                border: const OutlineInputBorder(),
                labelText: "Password",
              ),
              validator: (value) {
                return value == null || value.isEmpty ? "This field is required" : null;
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 47,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    login();
                  }
                },
                child: const Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
