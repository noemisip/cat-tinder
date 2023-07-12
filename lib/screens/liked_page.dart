import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:cat_tinder/assets/constants.dart';
import 'package:cat_tinder/cat_store.dart';
import 'package:cat_tinder/widgets/header.dart';

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
  const CatList({Key? key, required this.liked}) : super(key: key);

  final bool liked;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: (liked == true)
                  ? CatStore.likedCats.isEmpty
                      ? Container()
                      : Image.network(CatStore.likedCats[index]!.url!,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width - 40,
                          height: 200)
                  : CatStore.dislikedCats.isEmpty
                      ? Container()
                      : Image.network(CatStore.dislikedCats[index]!.url!,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width - 40,
                          height: 200)),
        );
      },
      itemCount: (liked == true)
          ? CatStore.likedCats.length
          : CatStore.dislikedCats.length,
    );
  }
}
