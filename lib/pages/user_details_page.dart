import 'package:flutter/material.dart';
import 'package:flutter_task/provider/user_provider.dart';
import 'package:provider/provider.dart';


class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().getUser();
  }

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emaiLController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
        ),
        child: context.watch<UserProvider>().userModel == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        margin: const EdgeInsets.only(top: 40),
                        child: Image.network(
                          provider.userModel!.avatarURL,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    _buildNameTextField(
                        name: 'Name',
                        controller: nameController..text = provider.userModel!.firstName),
                    _buildNameTextField(
                        name: 'Surname',
                        controller: surnameController..text = provider.userModel!.lastName),
                    _buildNameTextField(
                        name: 'Email address',
                        controller: emaiLController..text = provider.userModel!.email),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        provider.userModel!.dateTime.isNotEmpty
                            ? Text('Update Date: \n ${provider.userModel!.dateTime}')
                            : SizedBox.shrink(),
                        ElevatedButton.icon(
                            onPressed: () {
                              context.read<UserProvider>().updateUser(
                                  {'name': nameController.text, 'email': emaiLController.text});
                            },
                            icon: const Icon(Icons.save),
                            label: context.watch<UserProvider>().updateUserLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Save')),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

//TODO: String textFieldText for now
  Widget _buildNameTextField({required String name, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
