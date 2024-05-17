import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:velocity_x/velocity_x.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  int _counter = 0;
  late ShakeDetector detector;
  
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        _counter++;
      });
    },
    shakeThresholdGravity: 1.5,
    );
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            redBox(),
            const Text(
              '흔들어서 카운트를 올려보세요',
            ),
            Text(
                '$_counter',
                style: Theme.of(context).textTheme.displayLarge
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget redBox() => Container().box.color(Colors.red).
  size(20, 20).make();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state){

      case AppLifecycleState.detached:
        // TODO: Handle this case.
      case AppLifecycleState.resumed:
        detector.startListening();
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
      case AppLifecycleState.paused:
        detector.stopListening();
    }
  }
}