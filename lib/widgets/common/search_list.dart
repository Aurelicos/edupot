import 'package:flutter/material.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter_svg/svg.dart';

class SearchList extends StatefulWidget {
  final void Function(String) onChange;
  final List<SearchListItem> items;
  final SearchListStyle dropdownStyle;
  final SearchListButtonStyle dropdownButtonStyle;
  final Icon? icon;
  final String? placeholder;
  final bool hideIcon;
  final bool leadingIcon;
  final Color color;

  const SearchList({
    super.key,
    this.hideIcon = false,
    this.placeholder,
    required this.items,
    required this.onChange,
    required this.color,
    this.dropdownStyle = const SearchListStyle(),
    this.dropdownButtonStyle = const SearchListButtonStyle(),
    this.icon,
    this.leadingIcon = false,
  });

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _searchController = TextEditingController();
  List<SearchListItem> _filteredItems = [];
  final FocusNode _focusNode = FocusNode();
  bool initial = true;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(_onSearchChanged);
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
  Widget build(BuildContext context) {
    var style = widget.dropdownButtonStyle;
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: EduPotColorTheme.lightGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                  child: CompositedTransformTarget(
                    link: _layerLink,
                    child: InkWell(
                      onTap: () {
                        _focusNode.requestFocus();
                        _searchController.text = "";
                        widget.onChange("");
                        initial = false;
                      },
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: style.borderRadius,
                        ),
                        child: Row(
                          mainAxisAlignment: style.mainAxisAlignment ??
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
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
                                    initial = false;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.only(left: 5),
                                    hintText: widget.placeholder,
                                    hintStyle: EduPotDarkTextTheme.headline2(1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  "assets/icons/cross.svg",
                  width: 18,
                  height: 18,
                ),
              ),
            ],
          ),
          Image.asset(
            "assets/images/search_bar.png",
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
            child: Column(
              children: [
                const Text(
                  "Start your task search",
                  style: EduPotDarkTextTheme.smallHeadline,
                ),
                Text(
                  "Find the task you need to work on by searching for it",
                  textAlign: TextAlign.center,
                  style: EduPotDarkTextTheme.headline2(0.6),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

class SearchListItem extends StatelessWidget {
  final Widget child;
  final String id;
  final String name;

  const SearchListItem({
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

class SearchListButtonStyle {
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

  const SearchListButtonStyle({
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

class SearchListStyle {
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final Color? scrollbarColor;
  final ShapeBorder? shape;
  final Offset? offset;
  final double? width;

  const SearchListStyle({
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
