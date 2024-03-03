import 'package:flutter/material.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/hexagon.dart';

class SearchDropdown extends StatefulWidget {
  final void Function(int) onChange;
  final List<SearchDropdownItem> items;
  final List<String> itemList;
  final SearchDropdownStyle dropdownStyle;
  final SearchDropdownButtonStyle dropdownButtonStyle;
  final Icon? icon;
  final bool hideIcon;
  final bool leadingIcon;
  final LinearGradient? gradient;

  const SearchDropdown({
    super.key,
    this.hideIcon = false,
    required this.items,
    required this.onChange,
    required this.itemList,
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
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  final TextEditingController _searchController = TextEditingController();
  List<SearchDropdownItem> _filteredItems = [];

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
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final searchText = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = widget.items.where((item) {
        final itemText =
            widget.itemList[widget.items.indexOf(item)].toLowerCase();
        return itemText.contains(searchText);
      }).toList();
    });

    if (_isOpen) {
      _overlayEntry.remove();
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry);
    }
  }

  @override
  Widget build(BuildContext context) {
    var style = widget.dropdownButtonStyle;
    return CompositedTransformTarget(
      link: _layerLink,
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
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Hexagon(title: "SP", height: 24, width: 24),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: TextFormField(
                  controller: _searchController,
                  style: EduPotDarkTextTheme.headline2(1),
                  onTap: _toggleDropdown,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 5),
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
                          child: RawScrollbar(
                            thumbVisibility: true,
                            thumbColor: widget.dropdownStyle.scrollbarColor ??
                                Colors.grey,
                            controller: _scrollController,
                            child: ListView.builder(
                              padding: widget.dropdownStyle.padding ??
                                  EdgeInsets.zero,
                              shrinkWrap: true,
                              controller: _scrollController,
                              itemCount: _filteredItems.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _currentIndex = widget.items
                                          .indexOf(_filteredItems[index]);
                                      widget.onChange(_currentIndex);
                                      _toggleDropdown();
                                      _searchController.text =
                                          _filteredItems[index].id;
                                    });
                                  },
                                  child: _filteredItems[index],
                                );
                              },
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
    super.dispose();
  }
}

class SearchDropdownItem extends StatelessWidget {
  final Widget child;
  final String id;

  const SearchDropdownItem({
    super.key,
    required this.child,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
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
