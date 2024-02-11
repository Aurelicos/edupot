import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/navbar.dart';
import 'package:flutter/material.dart';

class PrimaryScaffold extends StatefulWidget {
  final Widget? child;
  final void Function()? onPressed;
  final bool? navBar;
  const PrimaryScaffold({
    super.key,
    this.child,
    this.onPressed,
    this.navBar,
  });

  @override
  State<PrimaryScaffold> createState() => _PrimaryScaffoldState();
}

class _PrimaryScaffoldState extends State<PrimaryScaffold> {
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
        child: widget.child,
      ),
      bottomNavigationBar: widget.navBar == null ? const Navbar() : null,
      floatingActionButton: widget.onPressed != null
          ? FloatingActionButton(
              onPressed: widget.onPressed,
              backgroundColor: EduPotColorTheme.floatingButtonColor,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
