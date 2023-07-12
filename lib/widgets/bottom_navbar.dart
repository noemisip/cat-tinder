import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cat_tinder/assets/constants.dart';

Widget myBottomNavBar(TabController controller ){
  return DefaultTabController(
    length: 3,
    initialIndex: 0,
    child: Container(
      height: 70,
      decoration: BoxDecoration(
        color: MyColors.mediumRose,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      child: TabBar(
        physics: const NeverScrollableScrollPhysics(),
        isScrollable: false,
        controller: controller,
        indicatorWeight: 0,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
          // insets: EdgeInsets.symmetric(horizontal: 0),
        ),
        tabs: [
          barItem(
            SvgPicture.asset("lib/assets/images/tab1.svg"),
            MyStrings.disliked,
          ),
          Container(
            child: barItem(
              SvgPicture.asset("lib/assets/images/tab2.svg"),
              MyStrings.home,
            ),
          ),
          Container(
            child: barItem(
              SvgPicture.asset("lib/assets/images/tab3.svg"),
              MyStrings.liked,
            ),
          ),
        ],
      ),
    ),
  );
}


Widget barItem(SvgPicture icon, String text) {
  return Tab(
    child: SizedBox(
      height: 50,
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 20,
              height: 20,
              child: icon),
          Text(
            text,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600
            ),
            maxLines: 1,
          ),
        ],
      ),
    ),
  );
}