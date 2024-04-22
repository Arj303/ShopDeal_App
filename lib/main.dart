import 'package:buyrent/providers/post_providers.dart';
import 'package:buyrent/providers/profile_providers.dart';
import 'package:buyrent/screens/authentication/profileInfo.dart';
import 'package:buyrent/screens/feed_pages/buypage.dart';
import 'package:buyrent/screens/feed_pages/postpage.dart';
import 'package:buyrent/screens/profile_pages/ProfilePage.dart';
import 'package:buyrent/screens/profile_pages/editprofile.dart';
import 'package:buyrent/screens/authentication/loginpage.dart';
import 'package:buyrent/screens/profile_pages/sellrent_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/home/feed_home.dart';
import 'firebase/firebase_options.dart';

import 'screens/authentication/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserController()),
          ChangeNotifierProvider(create: (context) => UserController1()),
        ], // Provide the Counter instance
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    ));
  }
}



