import 'package:auto_route/auto_route.dart';
import 'package:edupot/components/onboarding/pages.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/utils/router/router.dart';
import 'package:edupot/widgets/main_button.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < onboardingPages.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildPageIndicator(int length, int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index
                ? Colors.white
                : Colors.white.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final pageViewHeight = height * 0.75;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 13, 14, 32),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 15),
                      height: height,
                      width: width - 40,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF272943),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: height - 50,
                      width: width,
                      decoration: const ShapeDecoration(
                        gradient: EduPotColorTheme.onboardingGradient,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: pageViewHeight,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: onboardingPages.length,
                          onPageChanged: (int page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 32),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 32),
                                    width: width * .75,
                                    height: height * .5,
                                    child: Image(
                                      image: AssetImage(
                                        onboardingPages[index]['image'],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    onboardingPages[index]['title'],
                                    style: EduPotDarkTextTheme.headline1,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    onboardingPages[index]['subtitle'],
                                    style: EduPotDarkTextTheme.headline2(0.6),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      _buildPageIndicator(onboardingPages.length, _currentPage),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 25),
                        child: Material(
                          type: MaterialType.transparency,
                          child: MainButton(
                            title: "Next",
                            onTap: _currentPage == onboardingPages.length - 1
                                ? () =>
                                    context.pushRoute(const TaskTrackerRoute())
                                : _nextPage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
