import 'package:flutter/material.dart';

class StaggeredAnimationExample extends StatefulWidget {
  const StaggeredAnimationExample({Key? key}) : super(key: key);

  @override
  State<StaggeredAnimationExample> createState() =>
      _StaggeredAnimationExampleState();
}

class _StaggeredAnimationExampleState extends State<StaggeredAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> widthAnim;
  late Animation<double> heightAnim;
  late Animation<double> radiusAnim;
  late Animation<Color?> colorAnim;
  late Animation<double> opacityAnim;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    widthAnim = Tween<double>(begin: 100, end: 300).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.2, curve: Curves.easeInOut),
      ),
    );
    heightAnim = Tween<double>(begin: 100, end: 300).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 0.4, curve: Curves.easeInOut),
      ),
    );
    radiusAnim = Tween<double>(begin: 0, end: 30).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 0.6, curve: Curves.easeInOut),
      ),
    );
    colorAnim = ColorTween(begin: Colors.grey, end: Colors.blueGrey).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.6, 0.8, curve: Curves.easeInOut),
      ),
    );
    opacityAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.8, 1.0, curve: Curves.easeInOut),
      ),
    );
    _controller.addListener(() {
      setState(() {

      });
      print(_controller.value);
    });

    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.forward();
          setState(() {

          });
        },
        child: const Text('Press'),
      ),
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: widthAnim.value,
          height: heightAnim.value,
          decoration: BoxDecoration(
            color: colorAnim.value,
            borderRadius: BorderRadius.circular(radiusAnim.value)
          ),
          child: Opacity(
            opacity: opacityAnim.value,
            child: const Text('Hello Flutter', style: TextStyle(fontSize: 20, color: Colors.white),),
          ),
        ),
      ),
    );
  }
}
