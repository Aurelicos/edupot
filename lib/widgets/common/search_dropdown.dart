import 'package:flutter/material.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/hexagon.dart';
import 'package:flutter_svg/svg.dart';

class SearchDropdown extends StatefulWidget {
  final void Function(String) onChange;
  final List<SearchDropdownItem> items;
  final SearchDropdownStyle dropdownStyle;
  final SearchDropdownButtonStyle dropdownButtonStyle;
  final String? hexagonTitle;
  final Icon? icon;
  final String? placeholder;
  final bool hideIcon;
  final bool leadingIcon;
  final LinearGradient? gradient;
  final String? initialSelection;

  const SearchDropdown({
    super.key,
    this.hideIcon = false,
    this.placeholder,
    required this.items,
    required this.onChange,
    this.initialSelection,
    this.hexagonTitle,
    this.dropdownStyle = const SearchDropdownStyle(),
    this.dropdownButtonStyle = const SearchDropdownButtonStyle(),
    this.icon,
    this.leadingIcon = false,
    this.gradient,
  });

  @override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  final TextEditingController _searchController = TextEditingController();
  List<SearchDropdownItem> _filteredItems = [];
  final FocusNode _focusNode = FocusNode();
  bool initial = true;

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

    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_filteredItems.isNotEmpty && !initial) {
        _toggleDropdown();
      }
    });
  }

  void _onSearchChanged() {
    final searchText = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = widget.items.where((item) {
        final itemText = item.name.toLowerCase();
        return itemText.contains(searchText);
      }).toList();
    });

    if (_filteredItems.isNotEmpty) {
      if (!_isOpen) {
        _toggleDropdown();
      } else {
        _overlayEntry.remove();
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry);
      }
    } else if (_isOpen) {
      _toggleDropdown(close: true);
    }
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
          widget.onChange("");
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
              widget.hexagonTitle != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Hexagon(
                        title: widget.hexagonTitle!,
                        height: 24,
                        width: 24,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SvgPicture.asset(
                        "assets/icons/search.svg",
                        height: 18,
                        width: 18,
                      ),
                    ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextFormField(
                    focusNode: _focusNode,
                    controller: _searchController,
                    style: EduPotDarkTextTheme.headline2(1),
                    onTap: () {
                      _searchController.text = "";
                      widget.onChange("");
                      if (!_isOpen && _filteredItems.isNotEmpty) {
                        _toggleDropdown();
                      }
                      initial = false;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 5),
                      hintText: widget.placeholder,
                      hintStyle: EduPotDarkTextTheme.headline2(1),
                    ),
                  ),
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
                    color: EduPotColorTheme.primaryDark,
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
                          child: Padding(
                            padding:
                                widget.dropdownStyle.padding ?? EdgeInsets.zero,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                for (var i = 0;
                                    i < _filteredItems.length && i < 3;
                                    i++)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        final text = _filteredItems[i].name;
                                        widget.onChange(_filteredItems[i].id);
                                        _searchController.text = text;
                                        _toggleDropdown(close: true);
                                      });
                                      _focusNode.unfocus();
                                    },
                                    child: _filteredItems[i],
                                  ),
                                if (_filteredItems.length > 3)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (int i = 0; i < 3; i++)
                                        Container(
                                          margin: const EdgeInsets.only(
                                              right: 4, bottom: 15),
                                          width: 4,
                                          height: 4,
                                          decoration: ShapeDecoration(
                                            color: Colors.white
                                                .withValues(alpha: 0.4),
                                            shape: const OvalBorder(),
                                          ),
                                        )
                                    ],
                                  ),
                              ],
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

  void _toggleDropdown({bool close = false}) {
    if (_isOpen || close) {
      _overlayEntry.remove();
      _animationController.reverse();
      FocusManager.instance.primaryFocus?.unfocus();
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

class SearchDropdownItem extends StatelessWidget {
  final Widget child;
  final String id;
  final String name;

  const SearchDropdownItem({
    super.key,
    required this.child,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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

class SearchDropdownButtonStyle {
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

  const SearchDropdownButtonStyle({
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

class SearchDropdownStyle {
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final Color? scrollbarColor;
  final ShapeBorder? shape;
  final Offset? offset;
  final double? width;

  const SearchDropdownStyle({
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
