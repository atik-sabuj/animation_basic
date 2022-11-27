import 'package:animation_basic/home_page.dart';
import 'package:flutter/material.dart';

class LinearAnimationPage extends StatelessWidget {
  static const String routeName = '/linear';
  const LinearAnimationPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Linear Animation'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            },
            icon: const Icon(Icons.screen_rotation),
             // icon: const Text('Home')
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder(
              curve: Curves.easeInOut,
              duration: const Duration(seconds: 20),
              tween: Tween<double>(begin: 1, end: 100),
              builder: (context, value, child)=>
                  Text(value.toString(), style: TextStyle(fontSize: value),),
            ),
            TweenAnimationBuilder(
              curve: Curves.easeInOut,
              duration: const Duration(seconds: 10),
              tween: TextStyleTween(begin: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                letterSpacing: 1.0,
              ),
                end: const TextStyle(
                  fontSize: 34,
                  color: Colors.grey,
                  letterSpacing: 5.0,
                ),),
              builder: (context, value, child)=>
                  Text('Flutter Animation', style: value,),
            ),
          ],
        ),
      ),
    );
  }
}
