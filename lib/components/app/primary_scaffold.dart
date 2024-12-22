import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/navbar.dart';
import 'package:flutter/material.dart';

class PrimaryScaffold extends StatelessWidget {
  final Widget? child;
  final void Function()? onPressed;
  final bool? navBar;
  final EdgeInsetsGeometry? buttonMargin;
  const PrimaryScaffold({
    super.key,
    this.child,
    this.onPressed,
    this.navBar,
    this.buttonMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: EduPotColorTheme.primaryGradient,
        ),
        child: child,
      ),
      bottomNavigationBar: navBar == null ? const Navbar() : null,
      floatingActionButton: onPressed != null
          ? Container(
              margin: buttonMargin,
              child: FloatingActionButton(
                onPressed: onPressed,
                backgroundColor: EduPotColorTheme.floatingButtonColor,
                foregroundColor: Colors.white,
                child: const Icon(Icons.add),
              ),
            )
          : null,
    );
  }
}
