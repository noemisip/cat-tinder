import 'package:cat_tinder/firebase_options.dart';
import 'package:cat_tinder/network_manager.dart';
import 'package:cat_tinder/screens/main_screen.dart';
import 'package:cat_tinder/state_management/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'assets/constants.dart';
import 'cat_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  GetIt.I.registerSingleton(NetworkManager());
  GetIt.I.registerSingleton(CatStore());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CatBloc>(
      create: (context) => CatBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: MyStrings.appName,
        home: MainScreen(),
      ),
    );
  }
}
