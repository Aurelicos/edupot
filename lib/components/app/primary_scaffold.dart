import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/navbar.dart';
import 'package:flutter/material.dart';

class PrimaryScaffold extends StatefulWidget {
  final Widget? child;
  const PrimaryScaffold({super.key, this.child});

  @override
  State<PrimaryScaffold> createState() => _PrimaryScaffoldState();
}

class _PrimaryScaffoldState extends State<PrimaryScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: EduPotColorTheme.primaryGradient,
        ),
        child: widget.child,
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
