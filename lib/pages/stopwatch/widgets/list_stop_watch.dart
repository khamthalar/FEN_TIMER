import 'package:fen_timer/pages/stopwatch/controllers/stop_watch_controller.dart';
import 'package:fen_timer/public/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class ListStopWatch extends StatefulWidget {
  const ListStopWatch({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ListStopWatchState();
}

class _ListStopWatchState extends State<ListStopWatch> {
  DateFormat format = DateFormat('HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StopWatchController>(
      builder: (_) => ListView.builder(
        controller: _.scrollController,
        padding: const EdgeInsets.all(.0),
        itemCount: _.dateTimes.length,
        itemBuilder: (context, index) {
          return index == _.dateTimes.length - 1
              ? Container()
              : Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Stopwatch: ${_.dateTimes.length - index - 1}',
                            style: TextStyle(
                              fontSize: width / 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            format.format(_.dateTimes[index]),
                            style: TextStyle(
                              fontSize: width / 28.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.alarm_add_sharp,
                        size: width / 16.0,
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}