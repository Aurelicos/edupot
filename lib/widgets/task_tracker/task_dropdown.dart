import 'package:flutter/material.dart';

class TaskDropdown<T> extends StatefulWidget {
  final void Function(int) onChange;
  final List<TaskDropdownItem<T>> items;
  final TaskDropdownStyle dropdownStyle;
  final TaskDropdownButtonStyle dropdownButtonStyle;
  final Icon? icon;
  final bool hideIcon;
  final bool leadingIcon;
  final LinearGradient? gradient;
  final int? index;

  const TaskDropdown({
    super.key,
    this.hideIcon = false,
    required this.items,
    required this.onChange,
    this.dropdownStyle = const TaskDropdownStyle(),
    this.dropdownButtonStyle = const TaskDropdownButtonStyle(),
    this.icon,
    this.leadingIcon = false,
    this.gradient,
    this.index,
  });

  @override
  State<TaskDropdown> createState() => _TaskDropdownState();
}

class _TaskDropdownState<T> extends State<TaskDropdown<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = -1;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index ?? -1;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var style = widget.dropdownButtonStyle;
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        width: style.width,
        height: style.height,
        padding: style.padding,
        decoration: BoxDecoration(
          color: style.backgroundColor,
          gradient: widget.gradient,
          borderRadius: style.borderRadius,
        ),
        child: InkWell(
          onTap: _toggleDropdown,
          child: Row(
            mainAxisAlignment:
                style.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
            textDirection:
                widget.leadingIcon ? TextDirection.rtl : TextDirection.ltr,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                  ),
                  child: widget.items.isNotEmpty
                      ? (widget.items[_currentIndex == -1 ? 0 : _currentIndex])
                      : Container(),
                ),
              ),
              if (!widget.hideIcon)
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: RotationTransition(
                    turns: _rotateAnimation,
                    child: widget.icon ??
                        const RotatedBox(
                          quarterTurns: 3,
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject()! as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: widget.dropdownStyle.width ?? size.width,
                child: CompositedTransformFollower(
                  offset:
                      widget.dropdownStyle.offset ?? Offset(0, size.height + 5),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: widget.dropdownStyle.elevation ?? 0,
                    color: Colors.transparent,
                    shape: widget.dropdownStyle.shape,
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation,
                      child: ConstrainedBox(
                        constraints: widget.dropdownStyle.constraints ??
                            BoxConstraints(
                              maxHeight: (MediaQuery.of(context).size.height -
                                          topOffset -
                                          15)
                                      .isNegative
                                  ? 100
                                  : MediaQuery.of(context).size.height -
                                      topOffset -
                                      15,
                            ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: widget.gradient,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: RawScrollbar(
                            thumbVisibility: true,
                            thumbColor: widget.dropdownStyle.scrollbarColor ??
                                Colors.grey,
                            controller: _scrollController,
                            child: ListView(
                              padding: widget.dropdownStyle.padding ??
                                  EdgeInsets.zero,
                              shrinkWrap: true,
                              controller: _scrollController,
                              children:
                                  widget.items.asMap().entries.map((item) {
                                return InkWell(
                                  onTap: () {
                                    setState(() => _currentIndex = item.key);
                                    widget.onChange(item.key);
                                    _toggleDropdown();
                                  },
                                  child: item.value,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry.remove();
      setState(() => _isOpen = false);
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry);
      setState(() => _isOpen = true);
      _animationController.forward();
    }
  }
}

class TaskDropdownItem<T> extends StatelessWidget {
  final T? value;
  final Widget child;
  final Gradient? gradient;

  const TaskDropdownItem({
    super.key,
    this.value,
    required this.child,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ??
            const LinearGradient(
                colors: [Colors.transparent, Colors.transparent]),
      ),
      child: child,
    );
  }
}

class TaskDropdownButtonStyle {
  final MainAxisAlignment? mainAxisAlignment;
  final ShapeBorder? shape;
  final double elevation;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final Color? primaryColor;
  final LinearGradient? gradient;
  final BorderRadius? borderRadius;

  const TaskDropdownButtonStyle({
    this.mainAxisAlignment,
    this.backgroundColor,
    this.primaryColor,
    this.constraints,
    this.height,
    this.width,
    this.elevation = 0,
    this.padding,
    this.shape,
    this.gradient,
    this.borderRadius,
  });
}

class TaskDropdownStyle {
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final Color? scrollbarColor;
  final ShapeBorder? shape;
  final Offset? offset;
  final double? width;

  const TaskDropdownStyle({
    this.constraints,
    this.offset,
    this.width,
    this.elevation,
    this.shape,
    this.color,
    this.padding,
    this.scrollbarColor,
  });
}
