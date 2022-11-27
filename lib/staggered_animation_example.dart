import 'package:animation_basic/home_page.dart';
import 'package:animation_basic/linear_animation_page.dart';
import 'package:flutter/material.dart';

class StaggeredAnimationExample extends StatefulWidget {
  static const String routeName = '/staggered_animation';
  const StaggeredAnimationExample({Key? key}) : super(key: key);

  @override
  State<StaggeredAnimationExample> createState() => _HomePageState();
}

class _HomePageState extends State<StaggeredAnimationExample>
    with
        TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _iconController;
  late Animation<double> _heightAnim;
  late Animation<double> _widthAnim;
  late Animation<double> _radiusAnim;
  late Animation<double> _opacityAnim;
  late Animation<Color?> _colorAnim;


  @override
  void initState() {
    _controller = AnimationController(vsync: this,
        duration: const Duration(seconds: 3));
    _iconController = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 400));
    _widthAnim = Tween<double>(begin: 100, end: 200)
        .animate(CurvedAnimation(parent: _controller,
      curve: Interval(0.0, 0.2, curve: Curves.easeInOut,),));
    _heightAnim = Tween<double>(begin: 100, end: 200)
        .animate(CurvedAnimation(parent: _controller,
      curve: Interval(0.2, 0.4, curve: Curves.easeInOut,),));
    _radiusAnim = Tween<double>(begin: 0, end: 16)
        .animate(CurvedAnimation(parent: _controller,
      curve: Interval(0.4, 0.6, curve: Curves.easeInOut,),));
    _colorAnim = ColorTween(begin: Colors.grey, end: Colors.blueGrey)
        .animate(CurvedAnimation(parent: _controller,
      curve: Interval(0.6, 0.8, curve: Curves.easeInOut,),));
    _opacityAnim = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller,
      curve: Interval(0.8, 1.0, curve: Curves.easeInOut,),));
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        _controller.reverse();
      }
      if(status == AnimationStatus.dismissed) {
        _iconController.reverse();
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
          _iconController.forward();
        },
        child: AnimatedIcon(
          progress: _iconController,
          icon: AnimatedIcons.play_pause,
        ),
      ),
      appBar: AppBar(
        title: const Text('Staggered Animation'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushReplacementNamed(context, LinearAnimationPage.routeName);
            },
            icon: const Icon(Icons.home),
            // icon: const Text('Home')
          )
        ],
      ),
      body: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder:(context, child) => Container(
              alignment: Alignment.center,
              width: _widthAnim.value,
              height: _heightAnim.value,
              decoration: BoxDecoration(
                color: _colorAnim.value,
                borderRadius: BorderRadius.circular(_radiusAnim.value),
              ),
              child: Opacity(
                opacity: _opacityAnim.value,
                child: const Text('Hello Atik'),
              ),
            ),
          )
      ),
    );
  }

  /*InkWell buildInkWell() {
    return InkWell(
      onTap: () {
        setState(() {
          isOn = !isOn;
          _position = isOn ? 75 : 0;
        });
      },
      child: Stack(
        children: [
          Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'OFF',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    'ON',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.elasticInOut,
            right: _position,
            child: Container(
              width: 75,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 4),
              ),
            ),
          )
        ],
      ),
    );
  }

  AnimatedAlign buildAnimatedAlign() {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 400),
      alignment: _alignmentGeometry,
      child: AnimatedContainer(
        curve: Curves.elasticInOut,
        duration: const Duration(milliseconds: 400),
        width: _width,
        height: 100,
        color: Colors.blue,
        alignment: Alignment.center,
        child: const Text(
          'Pencilbox Training Institute & Consultancy',
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }*/

  Column buildTweenAnimationSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder(
          curve: Curves.easeInOut,
          duration: const Duration(seconds: 10),
          tween: Tween<double>(begin: 1, end: 100),
          builder: (context, value, child) =>
              Text(
                value.toString(),
                style: TextStyle(fontSize: value),
              ),
        ),
        TweenAnimationBuilder(
          curve: Curves.easeInOut,
          duration: const Duration(seconds: 10),
          tween: TextStyleTween(
            begin: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              letterSpacing: 1.0,
            ),
            end: const TextStyle(
              fontSize: 34,
              color: Colors.green,
              letterSpacing: 5.0,
            ),
          ),
          builder: (context, value, child) =>
              Text(
                'Hello Flutter',
                style: value,
              ),
        ),
      ],
    );
  }
}
