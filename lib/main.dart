import 'package:flutter/material.dart';
import 'package:flutter_task/auth_service.dart';
import 'package:flutter_task/home_page.dart';
import 'package:flutter_task/provider/home_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: const MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
// Center(
//             child: Container(
//           child: ElevatedButton(
//               onPressed: () {
//                 AuthService().loginUser('eve.holt@reqres.in', 'pisto2l');
//               },
//               child: const Text('Login')),
//         )),