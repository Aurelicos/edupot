import 'package:edupot/widgets/task_tracker/filtered_entry.dart';
import 'package:flutter/material.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:flutter_svg/svg.dart';

class SearchList extends StatefulWidget {
  final void Function(String) onChange;
  final List<SearchListItem> items;
  final String? placeholder;
  final Color color;

  const SearchList({
    super.key,
    this.placeholder,
    required this.items,
    required this.onChange,
    required this.color,
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
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(_onSearchChanged);
    prepareAnimations();
    expandController.forward();
  }

  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
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
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()..scale(1.0, animation.value, 1.0),
          alignment: Alignment.topCenter,
          child: child,
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: EduPotColorTheme.lightGray,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
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
                            height: 52,
                            decoration: BoxDecoration(
                              color: widget.color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        hintStyle:
                                            EduPotDarkTextTheme.headline2(1),
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
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/cross.svg",
                      width: 18,
                      height: 18,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _searchController.text.isEmpty
                  ? _buildPlaceholderList()
                  : _buildFilteredList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/images/search_bar.png",
          height: 150,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilteredList() {
    return ListView.builder(
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        widget.onChange(item.id);

        return FilteredEntry(
          onChange: () => widget.onChange(item.id),
          searchedText: _searchController.text.toLowerCase(),
          item: item.item,
          name: item.name,
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    expandController.dispose();
    super.dispose();
  }
}

class SearchListItem extends StatelessWidget {
  final Widget child;
  final String id;
  final String name;
  final dynamic item;

  const SearchListItem({
    super.key,
    required this.child,
    required this.id,
    required this.name,
    required this.item,
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
