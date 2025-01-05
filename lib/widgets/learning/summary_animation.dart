import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SummaryAnimation extends StatefulWidget {
  final double percentage;

  const SummaryAnimation({
    super.key,
    required this.percentage,
  });

  @override
  State<SummaryAnimation> createState() => _SummaryAnimationState();
}

class _SummaryAnimationState extends State<SummaryAnimation>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _progressAnimation = Tween<double>(begin: 0, end: widget.percentage)
        .animate(
            CurvedAnimation(parent: _progressController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _progressController.forward();

    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _floatingAnimation = Tween<double>(begin: -5, end: 5).animate(
        CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });

    _floatingController.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant SummaryAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.percentage != widget.percentage) {
      _progressAnimation = Tween<double>(begin: 0, end: widget.percentage)
          .animate(CurvedAnimation(
              parent: _progressController, curve: Curves.easeOut))
        ..addListener(() {
          setState(() {});
        });

      _progressController
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: child,
        );
      },
      child: CustomPaint(
        painter: _CirclePainter(progress: _progressAnimation.value),
        child: SizedBox(
          width: 150,
          height: 150,
          child: Center(
            child: Text(
              '${_progressAnimation.value.toInt()}%',
              style: EduPotDarkTextTheme.smallHeadline.copyWith(
                fontSize: 24,
                color: Color.lerp(
                  Colors.red,
                  Colors.greenAccent,
                  widget.percentage / 100,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double progress;

  _CirclePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 12;
    double radius = (min(size.width, size.height) / 2) - strokeWidth;

    Offset center = Offset(size.width / 2, size.height / 2);

    Paint backgroundPaint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    double startAngle = 3 * pi / 4;
    double sweepAngle = 270 * (pi / 180);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      backgroundPaint,
    );

    double progressRadians = (progress / 100) * sweepAngle;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      progressRadians,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
