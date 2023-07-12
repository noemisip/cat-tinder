import 'package:cat_tinder/cat_store.dart';
import 'package:cat_tinder/state_management/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:cat_tinder/assets/constants.dart';
import 'package:cat_tinder/widgets/header.dart';
import 'main_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required bool loading}) : super(key: key);

  final catStore = GetIt.instance.get<CatStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [MyColors.lightRose, Colors.white],
          ),
        ),
        child:
          Column(
            children: [
              const Header(),
             Draggable(
                 feedback: CatElement(),
                 childWhenDragging: Container(height: 400),
                 child: CatElement(),
             onDragEnd: (drag){
                   if(drag.velocity.pixelsPerSecond.dx< 0){
                     catBloc.add(UpdateCat());
                     catStore.addDisLikedCat();
                   } else{
                     catBloc.add(UpdateCat());
                     catStore.addLikedCat();
                   }
             },),
              const SizedBox(height: 25),
              const TextLine()
            ],
          ),
        );
  }
}

class TextLine extends StatelessWidget {
  const TextLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Text(
        MyStrings.homeText,
        style: TextStyle(
            color: MyColors.grey,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CatElement extends StatelessWidget {
   CatElement({
    Key? key
  }) : super(key: key);

   final catStore = GetIt.instance.get<CatStore>();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Container(
        height: 400,
        width: MediaQuery.of(context).size.width - 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x269B9B9B),
              blurRadius: 8.0,
              spreadRadius: 4.0,
              offset: Offset(0.0, 2.0),
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: (catStore.getCurrentCat() != null) ? Image.network(catStore.getCurrentCat()!.url!,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width - 40,
                    height:
                    300
                ): const CupertinoActivityIndicator(),
              ),
            ),
             LikeLine(),
          ],
        ),
      ),
    );
  }
}

class LikeLine extends StatelessWidget {
   LikeLine({
    Key? key,
  }) : super(key: key);

   final catStore = GetIt.instance.get<CatStore>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              catBloc.add(UpdateCat());
              catStore.addLikedCat();
            },
            child: SizedBox(
                height: 60,
                child: SvgPicture.asset(
                    "lib/assets/images/like.svg")),
          ),
          const SizedBox(width: 20),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: (){
              catBloc.add(UpdateCat());
              catStore.addDisLikedCat();
            },
            child: SizedBox(
                height: 60,
                child: SvgPicture.asset(
                    "lib/assets/images/dislike.svg")),
          ),
        ],
      ),
    );
  }
}
