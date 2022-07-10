import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../route/route_name.dart';
import '../widgets/linear_gradient_widget.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            flexibleSpace: Stack(children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: user.imgUrl,
                ),
              ),
              Positioned(
                height: 100,
                bottom: 0,
                left: 0,
                right: 0,
                child: LinearGradientWidget(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        user.displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
            expandedHeight: 300,
            actions: [
              PopupMenuButton(itemBuilder: (context) => []),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(color: Colors.red, height: 250),
                Container(color: Colors.green, height: 250),
                Container(color: Colors.blue, height: 250),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void navigateToProfilePage(BuildContext context, User? user) {
  if (user != null) {
    Navigator.pushNamed(context, RouteName.profilePage, arguments: user);
  }
}
