import 'package:animation_basic/linear_animation_page.dart';
import 'package:animation_basic/staggered_animation_example.dart';
import 'package:animation_basic/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      //home: const LinearAnimationPage(),
      //home: const HomePage(),
      //home: const StaggeredAnimationExample(),
      initialRoute: LinearAnimationPage.routeName,
      routes: {
        LinearAnimationPage.routeName:(context)=>LinearAnimationPage(),
        HomePage.routeName:(context)=>HomePage(),
        StaggeredAnimationExample.routeName:(context)=>StaggeredAnimationExample(),
      },

    );
  }
}



