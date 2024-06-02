import 'package:edupot/models/projects/project.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/search_list.dart';
import 'package:flutter/material.dart';

class SearchOverlayPage extends ModalRoute<void> {
  final List<dynamic> items;
  SearchOverlayPage({required this.items});
  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.4);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.045 - 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchList(
                placeholder: "Search",
                color: EduPotColorTheme.lightGray2,
                items: _createDropdownItems(),
                onChange: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  List<SearchListItem> _createDropdownItems() {
    return items
        .asMap()
        .entries
        .map(
          (item) => SearchListItem(
            id: item.value.id!,
            item: item.value,
            name:
                item.value is ProjectModel ? item.value.name : item.value.title,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                formatText(
                    item.value is ProjectModel
                        ? item.value.name
                        : item.value.title,
                    14),
                style: EduPotDarkTextTheme.headline2(1),
              ),
            ),
          ),
        )
        .toList();
  }
}
