import 'package:flutter/material.dart';
import 'package:graph_ql/core/model/post.dart';
import 'package:graph_ql/ui/routes/routes_names.dart';
import 'package:graph_ql/ui/screen/home_page.dart';
import 'package:graph_ql/ui/screen/post_details_page.dart';
import 'package:graph_ql/ui/screen/update_post_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.homePage:
        return MaterialPageRoute(builder: (BuildContext ctx) => HomePage());
      case RoutesNames.postDetails:
        Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>;
        String postId = args['postId'] as String;
        return MaterialPageRoute(
          builder: (BuildContext ctx) => PostDetailsPage(postId: postId),
        );

      case RoutesNames.updatePost:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        Post post = args['post'] as Post;
        return MaterialPageRoute(
          builder: (BuildContext ctx) => UpdatePostPage(
            post: post,
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          );
        });
    }
  }
}
