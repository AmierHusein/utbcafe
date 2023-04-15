import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utb_cafe/screen/detail_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../provider/my_provider.dart';
import '../widgets/food_modle.dart';

class Vendor1 extends StatefulWidget {
  const Vendor1({Key? key}) : super(key: key);

  @override
  State<Vendor1> createState() => _Vendor1State();
}

class _Vendor1State extends State<Vendor1> {

  // List<FoodModle> singleFoodList = [];

  Widget buttonContainers ({required String imageUrl, required int price, required String name,}){
    return Container(
            height: 270,
            width: 250,
            decoration: BoxDecoration(
              color: const Color(0xff3a3a3e),
              borderRadius: BorderRadius.circular(20)
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(imageUrl),
              ),
               ListTile(
                leading: SizedBox(
                  width: 100,
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                   trailing: Text(
                  "\$ $price",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  )
                ), 
              )
            ],
          ),
          );
  }

  @override
  Widget build(BuildContext context) {
    //  MyProvider provider = Provider.of<MyProvider>(context);
    // //List
    // provider.getFoodList();
    // singleFoodList = provider.throwFoodModleList;

    return Scaffold(
      body: Consumer<MyProvider>(
      builder: (context, provider, _){
          provider.getFoodList();
          List<FoodModle> singleFoodList = provider.throwFoodModleList;


          return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // flex: 2,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 510,
            child:
            GridView.count(
              padding: const EdgeInsets.all(10),
            shrinkWrap: false,
            primary: false,
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: singleFoodList
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                image: e.image,
                                name: e.name,
                                price: e.price,
                              ),
                            ),
                  );
                },
                child: buttonContainers(
                imageUrl: e.image, 
                price: e.price, 
                name: e.name,
                ),
              ),
            ).toList()
            )
          )
        ]
        );
        }
      )
    );
      } 
      
      
      
      

          //   children: [
          //   buttonContainers(
          //     image: 'images/nasikatok1.jpeg', 
          //     price: 1, 
          //     name: 'Nasi Katok'
          //     ),
          //   buttonContainers(
          //     image: 'images/nasikatok2.jpeg', 
          //     price: 2, 
          //     name: 'Nasi Katok'
          //     ),
          //   buttonContainers(
          //     image: 'images/nasikatok3.jpeg', 
          //     price: 3, 
          //     name: 'Nasi Katok'
          //     ),
          //   buttonContainers(
          //     image: 'images/nasikatok3.jpeg', 
          //     price: 3, 
          //     name: 'Nasi Katok'
          //     ),
          //   buttonContainers(
          //     image: 'images/nasikatok3.jpeg', 
          //     price: 3, 
          //     name: 'Nasi Katok'
          //     ),
          //   buttonContainers(
          //     image: 'images/nasikatok3.jpeg', 
          //     price: 3, 
          //     name: 'Nasi Katok'
          //     ),
          // ],
          // ))
          // ],
       
       
//             );
//     //       )
//     //     ] 
//     //   )
//     // );
//   }
}