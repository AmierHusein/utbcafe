import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/cart_modle.dart';
import '../widgets/food_modle.dart';

class MyProvider extends ChangeNotifier{
  List<FoodModle> foodModleList = [];
  late FoodModle foodModle;
  Reference storageRef = FirebaseStorage.instance.ref().child('product_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

  Future<void> getFoodList() async {
    List<FoodModle> newSingleFoodList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Foods').get();
    for (var element in querySnapshot.docs) {
      String? imageUrl;
    try {
      final metadata = await storageRef.getMetadata();
      imageUrl = await storageRef.getDownloadURL();
    } catch (e) {
      // object does not exist, do something like logging the error or using a default image URL
      print('Error: $e');
    }
        foodModle = FoodModle(
          name: element['name'],
          image: imageUrl ?? 'https://firebasestorage.googleapis.com/v0/b/utbcafe.appspot.com/o/product_images%2F1681557985311.jpg?alt=media&token=522a70bf-11df-453a-817f-928fe6b34bdb.jpg',
          price: element['price'].round(),
        );
        newSingleFoodList.add(foodModle);
      }

    foodModleList = newSingleFoodList;
    notifyListeners();
  }

  get throwFoodModleList {
    return foodModleList;
  }

  List<CartModle> cartList = [];
  List<CartModle> newCartList = [];
  late CartModle cartModle;
  void addToCart({
    required String image,
    required String name,
    required int price,
    required int quantity,
  }) {
    cartModle = CartModle(
      image: image,
      name: name,
      price: price,
      quantity: quantity,
    );
    newCartList.add(cartModle);
    cartList = newCartList;
  }

  get throwCartList {
    return cartList;
  }

  int totalprice() {
    int total = 0;
    for (var element in cartList) {
      total += element.price * element.quantity;
    }
    return total;
  }
 late int deleteIndex;
 void getDeleteIndex(int index){
     deleteIndex=index;
 }
 void delete(){
   cartList.removeAt(deleteIndex);
   notifyListeners();
 }
}