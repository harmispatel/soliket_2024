import 'package:flutter/material.dart';

import '../../utils/common_colors.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        body: Center(
          child: Text("Profile"),
        ),
      ),
    );
  }
}
