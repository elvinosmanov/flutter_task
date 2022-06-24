import 'package:flutter/material.dart';
import 'package:flutter_task/pages/home_page.dart';
import 'package:flutter_task/pages/login_page.dart';
import 'package:flutter_task/provider/user_provider.dart';
import 'package:flutter_task/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? token;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: navigationPage(),
      ),
    );
  }
}

navigationPage() {
  if (token != null) {
    return const HomePage();
  } else {
    return const LoginPage();
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