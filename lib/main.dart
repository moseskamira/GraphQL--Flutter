import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'data/network/service/graphql_config.dart';
import 'my_app.dart';

void main() async {
  await initHiveForFlutter();
  final client = GraphQLConfig.valueNotifierClient();
  runApp(MyApp(valueNotifierClient: client));
}
