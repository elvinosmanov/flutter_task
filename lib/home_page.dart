import 'package:flutter/material.dart';
import 'package:flutter_task/models/user.dart';
import 'package:flutter_task/pages/login_page.dart';
import 'package:flutter_task/provider/home_provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().pageAddListener();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
        actions: [
          ElevatedButton.icon(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero))),
              onPressed: () {},
              icon: const Icon(Icons.app_registration_rounded),
              label: const Text('Register')),
          ElevatedButton.icon(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.zero))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const LoginPage(),
                  ),
                );
              },
              icon: const Icon(Icons.login),
              label: const Text('Login')),
        ],
      ),
      body: PagedListView<int, UserModel>(
        pagingController: provider.pagingController,
        builderDelegate: PagedChildBuilderDelegate<UserModel>(
            itemBuilder: (context, item, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 120.0),
                  child: ListTile(
                    title: Text('${item.firstName} ${item.lastName}'),
                    leading: Image.network(item.avatarURL),
                  ),
                )),
      ),
    );
  }

  @override
  void dispose() {
    context.read<HomeProvider>().pageRemoveListener();
    super.dispose();
  }
}

class OutlineButtonFb1 extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const OutlineButtonFb1({required this.text, required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff2749FD);

    const double borderRadius = 40;

    return OutlinedButton(
      onPressed: () {},
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          "Sign Out",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: primaryColor),
        ),
        Icon(Icons.arrow_forward, color: primaryColor)
      ]),
      style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide(color: primaryColor, width: 1.4)),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20, horizontal: 50)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius))))),
    );
  }
}
