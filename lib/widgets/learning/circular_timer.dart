import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';

class CircularTimer extends StatefulWidget {
  final int remainingTime;
  final int totalTime;

  const CircularTimer({
    super.key,
    required this.remainingTime,
    required this.totalTime,
  });

  @override
  State<CircularTimer> createState() => _CircularTimerState();
}

class _CircularTimerState extends State<CircularTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.totalTime),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _animation.value;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 45,
          height: 45,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 4,
            backgroundColor: EduPotColorTheme.greyBorder,
            valueColor: const AlwaysStoppedAnimation<Color>(
                EduPotColorTheme.projectBlue),
          ),
        ),
        Text(
          '${(widget.totalTime * progress).round()}',
          style: EduPotDarkTextTheme.smallHeadline.copyWith(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
