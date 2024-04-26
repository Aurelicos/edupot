import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleButton extends StatefulWidget {
  final double size;
  final Color color;
  final bool disabled;
  final bool show;
  final void Function(bool selected) onPressed;

  const CircleButton({
    super.key,
    this.size = 32,
    this.color = Colors.white,
    this.disabled = false,
    this.show = false,
    required this.onPressed,
  });

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _isTapped = widget.show;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.disabled) {
          setState(() {
            _isTapped = !_isTapped;
          });
          widget.onPressed(_isTapped);
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset(
              "assets/icons/circle_big.svg",
              width: widget.size - 1,
              height: widget.size - 1,
              colorFilter: ColorFilter.mode(widget.color, BlendMode.srcIn),
            ),
          ),
          Positioned(
            left: -1,
            top: -1,
            child: AnimatedOpacity(
              opacity: _isTapped ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: SvgPicture.asset(
                "assets/icons/check.svg",
                width: widget.size,
                height: widget.size,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
