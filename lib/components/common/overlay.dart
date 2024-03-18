import 'dart:math';

import 'package:flutter/material.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/multi_select_dropdown.dart';
import 'package:flutter_svg/svg.dart';

class OverlayContent extends StatefulWidget {
  final void Function() toggleDropdown;
  final Gradient? gradient;
  final String? placeholder;
  final FocusNode? focusNode;
  final List<MultiSelectDropdownItem> items;
  final LayerLink layerLink;
  final Animation<double> expandAnimation;
  final RenderBox renderBox;
  final List<Item> selectedItems;
  final void Function(String) onSelectedId;
  const OverlayContent({
    super.key,
    this.gradient,
    this.placeholder,
    this.focusNode,
    required this.selectedItems,
    required this.onSelectedId,
    required this.renderBox,
    required this.expandAnimation,
    required this.layerLink,
    required this.items,
    required this.toggleDropdown,
  });

  @override
  State<OverlayContent> createState() => _OverlayContentState();
}

class _OverlayContentState extends State<OverlayContent> {
  List<bool?> selected = [];
  List<MultiSelectDropdownItem> _filteredItems = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.selectedItems.isNotEmpty) {
      selected = List.filled(widget.items.length, false);
      for (var i = 0; i < widget.items.length; i++) {
        for (var j = 0; j < widget.selectedItems.length; j++) {
          if (widget.items[i].id == widget.selectedItems[j].id) {
            selected[i] = true;
          }
        }
      }
    } else {
      selected = List.filled(widget.items.length, false);
    }
    _searchController.addListener(_onSearchChanged);
    _filteredItems = widget.items;
  }

  void _onSearchChanged() {
    final searchText = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = widget.items.where((item) {
        final itemText = item.name.toLowerCase();
        return itemText.contains(searchText);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = widget.renderBox.size;
    var offset = widget.renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;

    double dynamicHeight = min(
        (_filteredItems.isNotEmpty && _filteredItems.length <= 3
                ? _filteredItems.length + 1
                : 3) *
            50,
        150.0);

    double availableHeight =
        MediaQuery.of(context).size.height - topOffset - 15;
    double overlayHeight = min(dynamicHeight, availableHeight);

    return FocusScope(
      child: GestureDetector(
        onTap: widget.toggleDropdown,
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: size.width,
                child: CompositedTransformFollower(
                  offset: Offset(0, size.height + 5),
                  link: widget.layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: 0,
                    color: EduPotColorTheme.primaryDark,
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: widget.expandAnimation,
                      child: Container(
                        height: overlayHeight,
                        decoration: BoxDecoration(
                          gradient: widget.gradient,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Scrollbar(
                          child: ListView.builder(
                            itemCount: _filteredItems.isEmpty
                                ? 1
                                : _filteredItems.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  if (i == 0)
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: SvgPicture.asset(
                                            "assets/icons/search.svg",
                                            height: 18,
                                            width: 18,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: TextFormField(
                                              controller: _searchController,
                                              focusNode: widget.focusNode,
                                              style:
                                                  EduPotDarkTextTheme.headline2(
                                                      1),
                                              onTap: () {},
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 5),
                                                hintText: widget.placeholder,
                                                hintStyle: EduPotDarkTextTheme
                                                    .headline2(1),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (_filteredItems.isNotEmpty)
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selected[i] = !selected[i]!;
                                          widget.onSelectedId(
                                              _filteredItems[i].id);
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: selected[i],
                                            onChanged: (bool? value) {
                                              setState(() {
                                                selected[i] = !selected[i]!;
                                                widget.onSelectedId(
                                                    _filteredItems[i].id);
                                              });
                                            },
                                          ),
                                          _filteredItems[i],
                                        ],
                                      ),
                                    ),
                                ],
                              );
                            },
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
}
