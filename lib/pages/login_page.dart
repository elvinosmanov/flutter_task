import 'package:flutter/material.dart';
import 'package:flutter_task/auth_service.dart';
import 'package:flutter_task/home_page.dart';
import 'package:flutter_task/models/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_response.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _handleSubmitted() async {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please fix the errors in red before submitting.')));
    } else {
      form.save();
      final apiResponse = await AuthService().loginUser(emailController.text, passwordController.text);
      if (apiResponse.apiError == null) {
        _saveAndRedirectToHome(apiResponse.data as ApiToken);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text((apiResponse.apiError as ApiError).error ?? 'Error occured!')));
      }
    }
  }

  void _saveAndRedirectToHome(ApiToken apiToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", apiToken.data!);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 40),
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 30),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () async {
                        _handleSubmitted();
                      },
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        //signup screen
                      },
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
