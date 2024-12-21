import 'package:flutter/material.dart';

class WheelList extends StatefulWidget {
  final void Function(int index) onItemChanged;
  final int initialItem;
  final int childCount;
  final int step;
  final bool dontStartFromZero;
  const WheelList({
    super.key,
    required this.onItemChanged,
    required this.childCount,
    this.initialItem = 0,
    this.step = 1,
    this.dontStartFromZero = false,
  });

  @override
  State<WheelList> createState() => _WheelListState();
}

class _WheelListState extends State<WheelList> {
  late FixedExtentScrollController _controller;
  late int _centerIndex;

  @override
  void initState() {
    super.initState();
    int initialIndex = widget.initialItem ~/ widget.step;
    if (widget.dontStartFromZero) {
      initialIndex -= 1;
    }
    _controller = FixedExtentScrollController(initialItem: initialIndex);
    _centerIndex = initialIndex;
  }

  @override
  void didUpdateWidget(covariant WheelList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialItem != oldWidget.initialItem) {
      _controller.animateToItem(widget.initialItem,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      _centerIndex = widget.initialItem;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 175,
          child: ListWheelScrollView.useDelegate(
            onSelectedItemChanged: (index) {
              setState(() {
                widget.onItemChanged(
                    (widget.dontStartFromZero ? (index + 1) : index) *
                        widget.step);
                _centerIndex = index;
              });
            },
            controller: _controller,
            itemExtent: 65,
            perspective: 0.005,
            diameterRatio: 2,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: widget.childCount,
              builder: (context, index) {
                return buildNumbers(
                    index == _centerIndex,
                    (widget.dontStartFromZero ? (index + 1) : index) *
                        widget.step);
              },
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff272943),
                    const Color(0xff272943).withOpacity(0.01),
                    const Color(0xff272943),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 0.5, 1],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNumbers(bool isCenterItem, int hours) {
    final isLastItem = hours == widget.childCount * widget.step;
    if (widget.step > 1 && widget.dontStartFromZero && isLastItem) {
      hours -= 1;
    }

    final textStyle = TextStyle(
      fontSize: isCenterItem ? 50 : 40,
      color: Colors.white,
    );

    final padding = isCenterItem
        ? const EdgeInsets.symmetric(vertical: 0)
        : const EdgeInsets.symmetric(vertical: 10);

    return Center(
      child: Opacity(
        opacity: isCenterItem ? 1.0 : 0.5,
        child: Padding(
          padding: padding,
          child: Text(
            hours.toString().length == 1 ? "0$hours" : hours.toString(),
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
