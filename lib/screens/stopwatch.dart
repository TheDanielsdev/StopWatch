import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Test extends ConsumerStatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  Teststate createState() => Teststate();
}

class Teststate extends ConsumerState<Test> {
  final isWaitingProvider = StateProvider(((ref) => false));
  // final startTimeProvider = StateProvider<double>(((ref) => 60));
  var start = 60;
  bool wait = false;
  @override
  Widget build(BuildContext context) {
    final isWaiting = ref.watch(isWaitingProvider);
    // final startTime = ref.watch(startTimeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'StopWatch',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
                animation: wait ? true : false,
                animationDuration: 1000,
                radius: 40,
                lineWidth: 10,
                percent: wait ? start / 100 : 1.0,
                progressColor: Colors.red,
                backgroundColor: Colors.white,
                reverse: true,
                arcType: ArcType.FULL,
                center: Text(
                  wait ? start.toString() : 'Done',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                )),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: isWaiting
                  ? null
                  : () {
                      startStopWatch();
                      setState(() {
                        wait = true;
                        start = 60;
                      });
                    },
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: wait ? Colors.blue.withOpacity(0.5) : Colors.blue),
                child: Center(
                  child: Text(
                    wait ? '---' : 'start',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void startStopWatch() {
    const oneSec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(oneSec, (timer) {
      if (start > 0) {
        setState(() {
          start--;
        });
      } else {
        setState(() {
          timer.cancel();
          wait = false;
        });
      }
    });
  }
}
