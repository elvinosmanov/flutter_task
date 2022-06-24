import 'package:flutter/material.dart';
import 'package:flutter_task/models/user.dart';
import 'package:flutter_task/pages/login_page.dart';
import 'package:flutter_task/pages/user_details_page.dart';
import 'package:flutter_task/provider/home_provider.dart';
import 'package:flutter_task/provider/user_provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('token');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
                (route) => false);
          },
        ),
        actions: [
          ElevatedButton.icon(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(borderRadius: BorderRadius.zero))),
              onPressed: () {
                context.read<UserProvider>().userModel = null;
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const UserDetailsPage(),
                  ),
                );
              },
              icon: const Icon(Icons.person),
              label: const Text('Me')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PagedListView<int, UserModel>(
          pagingController: provider.pagingController,
          builderDelegate: PagedChildBuilderDelegate<UserModel>(
              itemBuilder: (context, item, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Card(
                    elevation: 4,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: Image.network(
                              item.avatarURL,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${item.firstName} ${item.lastName}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Email: ${item.email}'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ))),
        ),
      ),
    );
  }

  @override
  void dispose() {
    context.read<HomeProvider>().pageRemoveListener();
    super.dispose();
  }
}
