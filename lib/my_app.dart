import 'package:flutter/material.dart';
import 'package:graph_ql/ui/routes/routes.dart';
import 'package:graph_ql/ui/routes/routes_names.dart';
import 'package:graph_ql/ui/screen/home_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  const MyApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesNames.homePage,
        onGenerateRoute: Routes.generateRoute,
        home: HomePage(),
      ),
    );
  }
}
