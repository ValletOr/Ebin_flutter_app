import 'package:enplus_market/providers/user_provider.dart';
import 'package:enplus_market/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'commonAppBar.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isLoading = false; //TODO add spinner while is loading (its for exiting);

  void logout() async {
    setState(() {
      _isLoading = true;
    });

    final apiService = ApiService();

    try {
      await apiService.logout();

      if (mounted) {
        context.go('/');
      }

    } catch (e) {
      String _err = "Logout error: $e";
      print(_err);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_err, style: const TextStyle(fontSize: 24)),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CommonAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //====================================Page content here===========================

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage( // TODO: Узнать про отсутствие аватарки в апи.
                                "https://media.tenor.com/9ps0i3-ykcAAAAAM/shocked-shocked-guy.gif"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "ФИО",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        context.read<UserProvider>().userData!.lastName.isNotEmpty ? Text(context.read<UserProvider>().userData!.lastName) : const SizedBox.shrink(),
                        context.read<UserProvider>().userData!.name.isNotEmpty ? Text(context.read<UserProvider>().userData!.name) : const SizedBox.shrink(),
                        context.read<UserProvider>().userData!.middleName != null ? Text(context.read<UserProvider>().userData!.middleName!) : const SizedBox.shrink(),
                      ],
                    ),
                    const Divider(height: 30.0),
                    const Text(
                      "Предприятие",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    context.read<UserProvider>().userData!.company != null ? Text(context.read<UserProvider>().userData!.company!.name) : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  logout();
                                },
                                child: const Row(
                                  children: [
                                    Text("Выйти"),
                                    Icon(
                                      Icons.close,
                                      size: 18,
                                    ),
                                  ],
                                )),
                          ]),
                    ),
                  ],
                ),

                //====================================Page content ends here===========================
              ],
            ),
          ),
        ),
      ),
    );
  }
}
