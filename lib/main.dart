import 'package:flutter/material.dart';
import 'package:graph_ql/service/graphql_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'my_app.dart';

void main() async {
  await initHiveForFlutter();
  final client = GraphQLService.initializeClient();

  runApp(MyApp(client: client));
}
