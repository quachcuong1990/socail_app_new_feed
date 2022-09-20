import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail/modules/posts/blocs/post_detail_bloc.dart';
import 'package:socail/modules/posts/models/post.dart';
import 'package:socail/modules/posts/pages/post_detail_page.dart';
import 'package:socail/pages/sign_up_page.dart';
import 'package:socail/providers/bloc_provider.dart';
import 'package:socail/route/route_name.dart';
import '../modules/authentication/pages/welcome_page.dart';
import '../modules/comment/blocs/comments_bloc.dart';
import '../modules/posts/pages/create_post_page.dart';
import '../modules/posts/pages/dashboard_page.dart';

class Routes {
  static Route authorizedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(
          settings,
          const DashboardPage(),
        );
      case RouteName.createPostPage:
        return _buildRouteDialog(
          settings,
          const CreatePostPage(),
        );
      case RouteName.postDetailPage:
        final post = settings.arguments;
        if(post is Post){
          return _buildRoute(settings,
              BlocProvider(
                bloc: PostDetailBloc(post.id!),
                child: BlocProvider(
                  bloc: CommentBloc(post.id!),
                  child: PostDetailPage(post: post,),
                ),
              )
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route unAuthorizedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(
          settings,
          const WelcomePage(),
        );
      case RouteName.signUpPage:
        return _buildRoute(
          settings,
          const SignUpPage(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Coming soon'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }

  static MaterialPageRoute _buildRouteDialog(
      RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      fullscreenDialog: true,
      builder: (BuildContext context) => builder,
    );
  }
}
