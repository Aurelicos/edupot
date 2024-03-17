import 'package:flutter/material.dart';

class OverlayClass extends StatefulWidget {
  final bool? val;
  final void Function(bool?) onChanged;
  const OverlayClass({super.key, required this.val, required this.onChanged});

  @override
  State<OverlayClass> createState() => _OverlayClassState();
}

class _OverlayClassState extends State<OverlayClass> {
  bool? _value;
  @override
  void initState() {
    super.initState();
    _value = widget.val;
  }

  @override
  void didUpdateWidget(covariant OverlayClass oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.val;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _value,
      onChanged: (bool? value) {
        setState(() {
          _value = value;
          widget.onChanged(value);
        });
      },
    );
  }
}
