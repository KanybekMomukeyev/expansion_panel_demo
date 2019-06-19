import 'package:flutter/material.dart';
import 'package:expansion_bloc/sample_panels.dart';
import 'package:expansion_bloc/logic_bloc.dart';

Future<void> main() async {
  return runApp(BlocProvider<FavoriteBloc>(
    bloc: FavoriteBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SamplePanelsDemo(),
    );
  }
}
