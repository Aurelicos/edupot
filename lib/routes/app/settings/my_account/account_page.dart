import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edupot/components/app/primary_scaffold.dart';
import 'package:edupot/providers/user_provider.dart';
import 'package:edupot/utils/themes/theme.dart';
import 'package:edupot/widgets/common/main_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    return PrimaryScaffold(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Opacity(
                opacity: 0.2,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: const ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.72, 0.70),
                      end: Alignment(-0.72, -0.7),
                      colors: [Color(0xFFA5AFC4), Color(0xFF6D7B98)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.035),
                child: IconButton(
                  onPressed: () => context.maybePop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 32,
                  ),
                  color: Colors.white,
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.5 - 60,
                top: MediaQuery.of(context).size.height * 0.25 - 60,
                child: Image.asset(
                  "assets/images/user.png",
                  width: 120,
                  height: 120,
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Text(
            userProvider.user != null
                ? userProvider.user!.displayName ?? "John Doe"
                : "John Doe",
            style: EduPotDarkTextTheme.headline1,
          ),
          Text(
            "Joined ${formatDateTime(userProvider.user != null ? userProvider.user!.createdAt : Timestamp.now())}",
            style: EduPotDarkTextTheme.headline2(0.6),
          ),
          const SizedBox(height: 20),
          MainCard(
            "assets/icons/simple_user.svg",
            title: "Email",
            description:
                userProvider.user != null ? userProvider.user!.email : "email",
            gradient: EduPotColorTheme.darkGrayCardGradient,
            icon: false,
            onPressed: () {},
          ),
          MainCard(
            "assets/icons/notes.svg",
            title: "Name",
            description: userProvider.user != null
                ? userProvider.user!.displayName ?? "John Doe"
                : "email",
            gradient: EduPotColorTheme.darkGrayCardGradient,
            icon: false,
            onPressed: () {},
          )
        ],
      ),
    );
  }

  String formatDateTime(Timestamp dateTime) {
    final date = dateTime.toDate();
    final format = DateFormat("dd. MMM yyyy");
    return format.format(date);
  }
}
