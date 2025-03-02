import 'package:flutter/material.dart';
import 'package:graph_ql/screen/home_page.dart';
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
        home: HomePage(),
      ),
    );
  }
}
