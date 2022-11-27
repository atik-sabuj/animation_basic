import 'package:animation_basic/staggered_animation_example.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName='/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with
    TickerProviderStateMixin{
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool isPlaying = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isPlaying = !isPlaying;
            if(isPlaying) {
              _controller.repeat();
            } else {
              _controller.stop();
            }
          });
        },
        child: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
      ),
      appBar: AppBar(
        title: const Text('Rotation Transition'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushReplacementNamed(context, StaggeredAnimationExample.routeName);
            },
            icon: const Icon(Icons.animation),
            // icon: const Text('Home')
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotationTransition(
              turns: _animation,
              child: FlutterLogo(
                size: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAnimatedSwitch extends StatefulWidget {
  final Function(bool) onChanged;

  const MyAnimatedSwitch({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<MyAnimatedSwitch> createState() => _AnimatedSwitchState();
}

class _AnimatedSwitchState extends State<MyAnimatedSwitch> {
  bool isOn = false;
  double _width = 100, _height = 100;
  Color _color = Colors.black;
  double _borderRadius = 0.0;
  double position = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isOn = !isOn;
          position = isOn ? 75 : 0;
          _color = isOn ? Colors.green : Colors.black;
        });
        widget.onChanged(isOn);
      },
      child: Stack(
        children: [
          Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 3)),
            child: Row(
              children: [
                Expanded(
                    child: const Text(
                      'OFF',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                    child: const Text(
                      'ON',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
          AnimatedPositioned(
            curve: Curves.elasticInOut,
            duration: const Duration(milliseconds: 500),
            right: position,
            child: Container(
              width: 75,
              height: 50,
              decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black, width: 3)),
            ),
          )
        ],
      ),
    );
  }
}
