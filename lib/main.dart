import 'package:flutter/material.dart';
import 'package:supabase_database/dash_list.dart';
import 'package:supabase_database/utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: Utils.supabaseUrl,
      anonKey: Utils.supabaseKey,
      authCallbackUrlHostname: 'login-callback', // optional
      debug: true // optional
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Database',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashList(),
    );
  }
}
