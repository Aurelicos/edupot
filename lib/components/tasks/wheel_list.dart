import 'package:flutter/material.dart';

class WheelList extends StatefulWidget {
  final void Function(int index) onItemChanged;
  const WheelList({super.key, required this.onItemChanged});

  @override
  State<WheelList> createState() => _WheelListState();
}

class _WheelListState extends State<WheelList> {
  late FixedExtentScrollController _controller;
  int _centerIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 100, // Adjust as needed
          height: 175, // Adjust based on your design
          child: ListWheelScrollView.useDelegate(
            onSelectedItemChanged: (index) {
              setState(() {
                widget.onItemChanged(index);
                _centerIndex = index;
              });
            },
            controller: _controller,
            itemExtent: 65, // Adjust as needed
            perspective: 0.005,
            diameterRatio: 2,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 24, // Adjust based on your needs
              builder: (context, index) {
                return buildNumbers(index == _centerIndex, index);
              },
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              // Gradient overlay
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
            hours.toString(),
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
