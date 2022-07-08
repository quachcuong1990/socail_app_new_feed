import 'package:flutter/material.dart';
import 'package:socail/modules/categories/models/duongdan.dart';

import '../../../providers/bloc_provider.dart';
import '../../categories/blocs/list_categories_rxdart_bloc.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  // ListCategoriesRxDartBloc? get blocCategories => BlocProvider.of<ListCategoriesRxDartBloc>(context);
  final dataBloc = ListCategoriesRxDartBloc();

  @override
  void initState() {
    super.initState();
    dataBloc.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DuongDan?>(
        // stream: dataBloc!.categoriesStream,
          builder: (context,snapshot){
          final duongdan = snapshot.data;
          if(snapshot.hasData){
            return Center(
                child: Text(duongdan!.linkHome??''));
          }
          return const CircularProgressIndicator(
          );
          }
          ),
    );
  }
}
