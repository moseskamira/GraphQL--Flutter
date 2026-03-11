import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graph_ql/data/repositories/post_repository.dart';
import 'package:graph_ql/presentation/bloc/cubits/posts_cubit.dart';
import 'package:graph_ql/presentation/pages/home_page.dart';
import 'package:graph_ql/route/routes.dart';
import 'package:graph_ql/route/routes_names.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> valueNotifierClient;

  const MyApp({super.key, required this.valueNotifierClient});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: valueNotifierClient,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (_) => PostRepository(valueNotifierClient.value),
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (ctx) =>
                  PostsCubit(PostRepository(valueNotifierClient.value)),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: RoutesNames.homePage,
            onGenerateRoute: Routes.generateRoute,
            home: HomePage(),
          ),
        ),
      ),
    );
  }
}
