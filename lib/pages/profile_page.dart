import 'package:enplus_market/providers/user_provider.dart';
import 'package:enplus_market/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../components/common_appbar.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isLoading = false;

  Future<void> _performLogout() async {
    final apiService = ApiService();

    try {
      await apiService.logout();
    } catch (e) {
      String _err = "Logout error: $e";
      print(_err);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_err, style: const TextStyle(fontSize: 24)),
        ),
      );
    }
  }

  void logout() async {
    setState(() {
      _isLoading = true;
    });

    await _performLogout();

    if (mounted) {
      context.go('/');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CommonAppBar(),
        body: Stack(
          children: [
            SingleChildScrollView(
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(100),
                              child: FadeInImage.assetNetwork(
                                placeholder: "assets/img/placeholder.png",
                                //context.read<UserProvider>().userData!
                                image: "https://www.rainforest-alliance.org/wp-content/uploads/2021/06/capybara-square-1.jpg.optimal.jpg",
                                //TODO Узнать какого хрена в апи не передаётся аватарка пользователя
                                fit: BoxFit.fill,
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
                        Text(nameConstructor(true, true, true)),
                        const Divider(height: 30.0),
                        const Text(
                          "Предприятие",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        context.read<UserProvider>().userData!.company != null
                            ? Text(context
                                .read<UserProvider>()
                                .userData!
                                .company!
                                .name)
                            : const SizedBox.shrink(),
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
            if (_isLoading)
              Center(
                child: SpinKitThreeBounce(
                  color: Theme.of(context).primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String nameConstructor(bool lastname, bool firstname, bool middlename){
    String out = "";

    if (lastname){
      out = "$out${context.read<UserProvider>().userData!.lastName} ";
    }
    if (firstname){
      out = "$out${context.read<UserProvider>().userData!.name} ";
    }
    if (middlename){
      out = "$out${context.read<UserProvider>().userData!.middleName!} ";
    }

    return out.trim();
  }

}
