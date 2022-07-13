import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail/route/route_name.dart';
import '../modules/authentication/pages/welcome_page.dart';
import '../modules/posts/blocs/list_posts_rxdart_bloc.dart';
import '../modules/posts/pages/create_post_page.dart';
import '../providers/bloc_provider.dart';
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
