import 'package:flutter/material.dart';
import 'package:socail/values/app_assets.dart';

import '../../../blocs/app_state_bloc.dart';
import '../../../providers/bloc_provider.dart';
import '../../../utils/uidata.dart';
import 'list_posts_page.dart';
import 'list_posts_paging_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // ListPostsRxDartBloc? get bloc =>
  //     BlocProvider.of<ListPostsRxDartBloc>(context);
  AppStateBloc? get appStateBloc => BlocProvider.of<AppStateBloc>(context);
  int _index = 0;
  final List<Widget> _children = [
    const ListPostsPage(),
    const ListPostsPagingRepo(),
    const ListPostsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index, // this will be set when a new tab is tapped
        iconSize: 36,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppAssets.iconHome)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppAssets.iconNoti)),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(AppAssets.iconProfile)),
            label: 'Profile',
          )
        ],
      ),
      body: _children[_index],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }
}
