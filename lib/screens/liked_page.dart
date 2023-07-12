import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:cat_tinder/assets/constants.dart';
import 'package:cat_tinder/cat_store.dart';
import 'package:cat_tinder/widgets/header.dart';

import '../model/cat.dart';

Widget likedPage({required bool liked}) {

  final catStore = GetIt.instance.get<CatStore>();

  if (liked == true){
    catStore.getAllLikedCats();
  } else {
    catStore.getAllDisLikedCats();
  }
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [MyColors.lightRose, Colors.white],
        ),
      ),
      child: Column(
        children: [
          Header(title: liked ? MyStrings.likedCats : MyStrings.dislikedCats),
          Expanded(
            child: CatList(liked: liked),
          ),
          const SizedBox(height: 70)
        ],
      ),
    );
  }


class CatList extends StatelessWidget {
  CatList({Key? key, required this.liked}) : super(key: key);

  final bool liked;
  final catStore = GetIt.instance.get<CatStore>();

  @override
  Widget build(BuildContext context) {
     List<Cat?> likedCats = catStore.getLikedCats();
     List<Cat?> disLikedCats = catStore.getDislikedCats();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: (liked == true)
                  ? likedCats.isEmpty
                      ? Container()
                      : Image.network(likedCats[index]!.url!,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width - 40,
                          height: 200)
                  : disLikedCats.isEmpty
                      ? Container()
                      : Image.network(disLikedCats[index]!.url!,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width - 40,
                          height: 200)),
        );
      },
      itemCount: (liked == true)
          ? likedCats.length
          : disLikedCats.length,
    );
  }
}
