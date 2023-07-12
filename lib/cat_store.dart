import 'package:cat_tinder/network_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'model/cat.dart';

class CatStore {

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static List<Cat?> likedCats = [];
  static List<Cat?> dislikedCats = [];
  static Cat? currentCat;
  final _nm = GetIt.instance.get<NetworkManager>();

  Future<void> addLikedCatFirebase() async {
    await firebaseFirestore.collection('LikedCats').add(currentCat!.toJson());
  }

  Future<void> addDisLikedCatFirebase() async {
    await firebaseFirestore
        .collection('DisLikedCats')
        .add(currentCat!.toJson());
  }

  Future<void> getAllLikedCats() async {
    likedCats = [];
    await firebaseFirestore.collection("LikedCats").get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        Cat cat = Cat.fromJson(result.data());
        likedCats.add(cat);
      }
    });
  }

  Future<void> getAllDisLikedCats() async {
    dislikedCats = [];
    await firebaseFirestore
        .collection("DisLikedCats")
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        Cat cat = Cat.fromJson(result.data());
        dislikedCats.add(cat);
      }
    });
  }

  addLikedCat() {
    likedCats.add(currentCat);
    addLikedCatFirebase();
  }

  addDisLikedCat() {
    dislikedCats.add(currentCat);
    addDisLikedCatFirebase();
  }

  Future<Cat?> chooseCurrentCat() async {
    Cat? newCat;
    do {
      newCat = await _nm.getRandomPic();
    } while (ignoreOldCats(newCat) == true);
    currentCat = newCat;
    return currentCat;
  }

  bool ignoreOldCats(Cat? newCat) {
    bool old = false;
    for (var cat in likedCats) {
      if (newCat!.id == cat!.id) {
        old = true;
      }
    }
    for (var cat in dislikedCats) {
      if (newCat!.id == cat!.id) {
        old = true;
      }
    }
    return old;
  }

  Cat? getCurrentCat() {
    return currentCat;
  }
}
