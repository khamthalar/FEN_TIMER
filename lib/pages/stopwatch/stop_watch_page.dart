import 'package:fen_timer/pages/stopwatch/controllers/stop_watch_controller.dart';
import 'package:fen_timer/pages/stopwatch/widgets/list_stop_watch.dart';
import 'package:fen_timer/pages/stopwatch/widgets/stop_watch_controll.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fen_timer/public/constants.dart';
import 'package:get/get.dart';
class StopWatchPage extends StatefulWidget {
  const StopWatchPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  final stopWatchController = Get.put(StopWatchController());

  @override
  void initState() {
    super.initState();
    stopWatchController.dateTimes.add(DateTime(0, 0, 0));
    stopWatchController.updateTime(0, 0, 0);
  }

  @override
  void dispose() {
    stopWatchController.timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: width,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(flex: 2),
              StreamBuilder(
                stream: stopWatchController.currentTime.stream,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return _buildClock(
                        DateTime(0, 0, 0, 0, 0, 0), DateTime(0, 0, 0, 0, 0, 0));
                  }

                  return _buildClock(
                      snapshot.data, stopWatchController.dateTimes[0]);
                },
              ),
              const Spacer(flex: 1),
              SizedBox(
                height: height * .3,
                child: const ListStopWatch(),
              ),
              const Spacer(flex: 1),
              const StopWatchControll(),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClock(DateTime dateTime, DateTime dateTimePrevious) {
    return CircularPercentIndicator(
      radius: width * .825,
      lineWidth: 60.0,
      percent: stopWatchController.percent,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: kSecondaryLightColor,
      linearGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
        colors: [
          kPrimaryColor,
          kSecondaryColor,
        ],
        tileMode: TileMode.mirror,
      ),
      animationDuration: 1000,
      animateFromLastPercent: true,
      rotateLinearGradient: true,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      '${stopWatchController.formatTime(dateTime.hour)}:${stopWatchController.formatTime(dateTime.minute)}:${stopWatchController.formatTime(dateTime.second)}',
                  style: TextStyle(
                      color: kSecondaryDarkColor,
                      fontSize: width / 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                ),
                TextSpan(
                  text:
                      ':${stopWatchController.formatTime((dateTime.millisecond / 17).round())}',
                  style: TextStyle(
                      color: kAccentLightColor,
                      fontSize: width / 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      '${stopWatchController.formatTime(dateTimePrevious.hour)}:${stopWatchController.formatTime(dateTimePrevious.minute)}:${stopWatchController.formatTime(dateTimePrevious.second)}',
                  style: TextStyle(
                    color: kSecondaryDarkColor,
                    fontSize: width / 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text:
                      ':${stopWatchController.formatTime((dateTimePrevious.millisecond / 17).round())}',
                  style: TextStyle(
                    color: kSecondaryDarkColor,
                    fontSize: width / 26.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}