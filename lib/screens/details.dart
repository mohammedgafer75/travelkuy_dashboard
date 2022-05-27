import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:travelkuy_dashboard/controller/all_travel_controller.dart';
import 'package:travelkuy_dashboard/screens/all_travel.dart';
import 'package:travelkuy_dashboard/screens/home_screen.dart';
import 'package:travelkuy_dashboard/widgets/loading.dart';
import 'package:travelkuy_dashboard/widgets/snackbar.dart';
class Details extends StatelessWidget {
  const Details(
      {Key? key,

      })
      : super(key: key);





  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
        body: GetBuilder<AllTravelController>(
        builder: (logic) {
      return ListView(
      children: [

        Stack(
          children: [
            Hero(
              tag: Image.network(logic.travel.image!),
              child: Stack(
                children: [
                  SizedBox(
                    height: data.size.height * 0.5,
                    child: Image.network(
                      logic.travel.image!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: data.size.height * 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: data.size.height * 0.50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.07, vertical: height * .07),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        // Container(
                        //   height: data.size.height / 12,
                        //   width: data.size.width / 8,
                        //   decoration: const BoxDecoration(
                        //     color: Colors.white,
                        //     shape: BoxShape.circle,
                        //   ),
                        //   child: Center(
                        //     child: Icon(
                        //       Icons.favorite,
                        //       color: Colors.red[700],
                        //       size: 30,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: Container(),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .07,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      width: width * 0.5,
                      height: height * 0.06,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: Center(
                        child: Text(
                          "من ${logic.travel.from!} "  "الى ${logic.travel.to!} " ,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 0,
                      bottom: 16,
                    ),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // const Spacer(),
                              Text(

                                // ignore: prefer_adjacent_string_concatenation
                                '${logic.travel.price}'"  جنيه",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),

                              ),
                            ])
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          
          // alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(15),
          child: Container(
            // height: data.size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(30),
              //   topRight: Radius.circular(30),
              // ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "من ${logic.travel.from} ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GetBuilder<AllTravelController>(
                        id: 'from',
                        builder: (logic) {
                          return IconButton(onPressed: (){

                             logic.changeFrom(logic.travel.id!);
                            }, icon: const Icon(Icons.edit),
                            color: Colors.yellow[700],
                            highlightColor: Colors.blueAccent,
                            splashColor: Colors.blueAccent,
                            splashRadius: 10,
                          );
                          },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "الى ${logic.travel.to} ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GetBuilder<AllTravelController>(
                        id: 'to', 
                        builder: (logic) {
                          return IconButton(onPressed: (){
                            logic.changeTo(logic.travel.id!);
                            }, icon: const Icon(Icons.edit,),
                            color: Colors.yellow[700],
                            highlightColor: Colors.blueAccent,
                            splashColor: Colors.blueAccent,
                            splashRadius: 10,);
                          },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${logic.travel.price} ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GetBuilder<AllTravelController>(
                        id: 'price',
                        builder: (logic) {
                          return IconButton(onPressed: (){
                            logic.changePrice(logic.travel.id!);
                            }, icon: const Icon(Icons.edit),
                            color: Colors.yellow[700],
                            highlightColor: Colors.blueAccent,
                            splashColor: Colors.blueAccent,
                            splashRadius: 10,);
                          },
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.only(
                              top: height / 70,
                              bottom: height / 70,
                              left: width / 10,
                              right: width / 10)),
                          backgroundColor:
                          MaterialStateProperty.all(Colors.red),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  side: const BorderSide(
                                      color: Colors.red)))),
                      onPressed: (){
                        Get.dialog(
                            AlertDialog(
                              content: const Text('هل تريد حذف الرحلة'),
                              actions: [
                                TextButton(onPressed: () async {
                                  try{
                                    showdilog();
                                    FirebaseFirestore.instance.collection('Travel').doc(logic.travel.id!).delete();
                                    Get.back();
                                    showbar(' حذف الرحلة', '', 'تم حذف الرحلة', true);
                                    Get.offAll(()=> const HomeScreen());
                                  }catch (e){
                                    showbar('حذف الرحلة', '', 'يوجد خطأ', false);
                                    Get.back();
                                  }
                                }, child: const Text('تاكيد')),
                                TextButton(onPressed: (){
                                  Get.back();
                                }, child: const Text('رجوع'))
                              ],
                            ));
                      },
                      child: const Text(
                        'حذف',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );},
        ));
  }

  Widget buildFeature(IconData iconData, String text) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(19, 26, 44, 1.0),
          borderRadius: BorderRadius.circular(10)
          //shape: BoxShape.rectangle,
          ),
      //color: Color.fromRGBO(19, 26, 44, 1.0),
      child: Column(
        children: [
          Icon(
            iconData,
            color: Colors.amber,
            size: 28,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildPhotos(List images) {
    List<Widget> list = [];
    list.add(const SizedBox(
      width: 24,
    ));
    for (var i = 0; i < images.length; i++) {
      list.add(buildPhoto(images[i]));
    }
    return list;
  }

  Widget buildPhoto(String url) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        margin: const EdgeInsets.only(right: 24),
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage(url),
          //   fit: BoxFit.cover,
          // ),
          shape: BoxShape.circle,
        ),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: url,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress),
          ),
          errorWidget: (context, url, error) => (const Icon(Icons.error)),
          width: 1000,
        ),
      ),
    );
  }
}
