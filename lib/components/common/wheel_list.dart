import 'package:flutter/material.dart';

class WheelList extends StatefulWidget {
  final void Function(int index) onItemChanged;
  final int initialItem;
  final int childCount;
  const WheelList({
    super.key,
    required this.onItemChanged,
    required this.childCount,
    this.initialItem = 0,
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
    _controller = FixedExtentScrollController(initialItem: widget.initialItem);
    _centerIndex = widget.initialItem;
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
                widget.onItemChanged(index);
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
                return buildNumbers(index == _centerIndex, index);
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
