import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cat_tinder/assets/constants.dart';

class Header extends StatelessWidget {
  const Header({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top + 10),
        SvgPicture.asset("lib/assets/images/logo.svg"),
        SizedBox(height: title == null ? 0 : 10),
        Text(title ?? "",
            style: TextStyle(
                color: MyColors.darkRose,
                fontSize: 32,
                fontFamily: "Manrope",
                fontWeight: FontWeight.w800)),
      ],
    );
  }
}
