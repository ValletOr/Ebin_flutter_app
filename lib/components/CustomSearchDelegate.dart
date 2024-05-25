import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../models/ShortAppModel.dart';
import '../services/api_service.dart';

class CustomSearchDelegate extends SearchDelegate {

  final String? pathName;
  List<ShortAppModel> apps = [];

  CustomSearchDelegate({required this.pathName}) {
    fetchApps();
  }

  Future<void> fetchApps() async {
    final apiService = ApiService();
    final response = await apiService.getApps(0);

    if (response["objects"].isNotEmpty) {
      apps.addAll((response["objects"] as List)
          .map((item) => ShortAppModel.fromJson(item))
          .toList());
    }
  }

  @override
  String get searchFieldLabel => 'Поиск';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.orange),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: SvgPicture.asset(
          'assets/icons/close_01.svg',
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: SvgPicture.asset(
        'assets/icons/arrow_left_01.svg',
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ShortAppModel> matchQuery = [];
    for (var app in apps) {
      if (app.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(app);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          dense: true,
          leading: ClipRRect(
            child: Image.network(result.icon, width: 40, height: 40),
          ),
          title: Text(
            result.name,
            style: TextStyle(fontSize: 20.0),
          ),
          subtitle: Text(
            result.size,
            style: TextStyle(fontSize: 10),
          ),
          onTap: () {
            close(context, null);
            print(pathName);
            if (pathName == 'appCard')
            {
              context.pushReplacement('/main/appCard/${result.id}');
            }
            else {
              context.go('/main/appCard/${result.id}');
            }
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ShortAppModel> matchQuery = [];
    for (var app in apps) {
      if (app.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(app);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          dense: true,
          leading: ClipRRect(
            child: Image.network(result.icon, width: 40, height: 40),
          ),
          title: Text(
            result.name,
            style: TextStyle(fontSize: 20.0),
          ),
          subtitle: Text(
            result.size,
            style: TextStyle(fontSize: 10),
          ),
          onTap: () {
            close(context, null);
            print(pathName);
            if (pathName == 'appCard')
            {
              context.pushReplacement('/main/appCard/${result.id}');
            }
            else {
              context.go('/main/appCard/${result.id}');
            }

          },
        );
      },
    );
  }
}
