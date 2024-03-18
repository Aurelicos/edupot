import 'package:edupot/components/common/overlay.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MultiSelectDropdown extends StatefulWidget {
  final void Function(List<Item>) onChange;
  final List<MultiSelectDropdownItem> items;
  final MultiSelectDropdownStyle dropdownStyle;
  final MultiSelectDropdownButtonStyle dropdownButtonStyle;
  final Icon? icon;
  final String? placeholder;
  final bool hideIcon;
  final bool leadingIcon;
  final LinearGradient? gradient;
  final String? initialSelection;

  const MultiSelectDropdown({
    super.key,
    this.hideIcon = false,
    this.placeholder,
    required this.items,
    required this.onChange,
    this.initialSelection,
    this.dropdownStyle = const MultiSelectDropdownStyle(),
    this.dropdownButtonStyle = const MultiSelectDropdownButtonStyle(),
    this.leadingIcon = false,
    this.icon,
    this.gradient,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  final TextEditingController _searchController = TextEditingController();
  List<MultiSelectDropdownItem> _filteredItems = [];
  final FocusNode _focusNode = FocusNode();
  bool initial = true;
  List<bool?> selected = [];
  List<Item> selectedItems = [];

  @override
  void initState() {
    super.initState();
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
    _filteredItems = widget.items;

    if (widget.initialSelection != null) {
      final initialItem = widget.items.firstWhere(
        (item) => item.id == widget.initialSelection,
      );
      _searchController.text = initialItem.name;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_filteredItems.isNotEmpty && !initial) {
        _toggleDropdown();
      }
    });
    selected = List.filled(widget.items.length, false);
  }

  @override
  Widget build(BuildContext context) {
    var style = widget.dropdownButtonStyle;
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: () {
          _focusNode.requestFocus();
          _searchController.text = "";
          _toggleDropdown();
          initial = false;
        },
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: style.borderRadius,
          ),
          child: Row(
            mainAxisAlignment:
                style.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SvgPicture.asset(
                  "assets/icons/assign.svg",
                  height: 18,
                  width: 18,
                ),
              ),
              selectedItems.isEmpty
                  ? Expanded(
                      child: Text(
                        widget.placeholder ?? "Select Tasks",
                        style: EduPotDarkTextTheme.headline2(1),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: selectedItems.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left: index > 0 ? 5 : 0),
                            child: Chip(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              label: Text(selectedItems[index].name),
                              onDeleted: () {
                                setState(() {
                                  selectedItems.removeAt(index);
                                });
                                widget.onChange(selectedItems);
                              },
                            ),
                          );
                        },
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

    return OverlayEntry(
        builder: (context) => OverlayContent(
              expandAnimation: _expandAnimation,
              layerLink: _layerLink,
              items: widget.items,
              toggleDropdown: () => _toggleDropdown(close: true),
              renderBox: renderBox,
              gradient: widget.gradient,
              focusNode: _focusNode,
              selectedItems: selectedItems,
              placeholder: "Find Items",
              onSelectedId: (String value) {
                widget.items.where((element) => element.id == value).forEach(
                  (element) {
                    if (selectedItems
                            .indexWhere((element) => element.id == value) >
                        -1) {
                      int index = selectedItems
                          .indexWhere((element) => element.id == value);
                      setState(() {
                        selectedItems.removeAt(index);
                      });
                      widget.onChange(selectedItems);
                    } else {
                      setState(() {
                        selectedItems.add(Item(element.id, element.name));
                      });
                      widget.onChange(selectedItems);
                    }
                  },
                );
              },
            ));
  }

  void _toggleDropdown({bool close = false}) {
    if (_isOpen || close) {
      _overlayEntry.remove();
      _animationController.reverse();
      setState(() => _isOpen = false);
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry);
      _animationController.forward();
      setState(() => _isOpen = true);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

class MultiSelectDropdownItem extends StatelessWidget {
  final Widget child;
  final String id;
  final String name;

  const MultiSelectDropdownItem({
    super.key,
    required this.child,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: child,
    );
  }
}

String formatText(String text, int length) {
  if (text.length > length) {
    return "${text.substring(0, length - 1)}...";
  }
  return text;
}

class MultiSelectDropdownButtonStyle {
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

  const MultiSelectDropdownButtonStyle({
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

class MultiSelectDropdownStyle {
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final Color? scrollbarColor;
  final ShapeBorder? shape;
  final Offset? offset;
  final double? width;

  const MultiSelectDropdownStyle({
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

class Item {
  final String id;
  final String name;

  Item(this.id, this.name);
}
