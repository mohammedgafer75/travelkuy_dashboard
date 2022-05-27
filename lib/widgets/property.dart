import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:travelkuy_dashboard/controller/all_travel_controller.dart';
import '../screens/details.dart';
import 'dart:ui' as ui;

class Property extends StatelessWidget {
  const Property({Key? key, required this.property}) : super(key: key);
  final dynamic property;

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return GetBuilder<AllTravelController>(
      builder: (logic) {
        return GestureDetector(
          onTap: () async {
            await logic.getTravelById(property.id);
            Get.to(()=> const Details());
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) =>
            //           Details(
            //             data: property,
            //           )),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(

              margin: EdgeInsets.only(bottom: data.size.width / 12),
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Container(
                height: data.size.height / 2.70,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(property.image),
                        fit: BoxFit.cover)),
                child: Container(
                  padding: const EdgeInsets.all(20),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                            "من ${property.from} " "الى ${property.to} ",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Column(
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Row(
                          //       children: [
                          //         const Icon(
                          //           Icons.location_on,
                          //           color: Colors.white,
                          //           size: 20,
                          //         ),
                          //         SizedBox(
                          //           width: width * .02,
                          //         ),
                          //         Text(
                          //           'location',
                          //           style: const TextStyle(
                          //             color: Colors.white,
                          //             fontSize: 15,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: data.size.height / 50,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Row(
                          //       children: [
                          //         const Icon(
                          //           Icons.zoom_out_map,
                          //           color: Colors.white,
                          //           size: 20,
                          //         ),
                          //         SizedBox(
                          //           width: width * .02,
                          //         ),
                          //         Text(
                          //           " sq/m",
                          //           style: const TextStyle(
                          //               color: Colors.white,
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // const Spacer(),
                                Text(

                                  // ignore: prefer_adjacent_string_concatenation
                                  '${property.price}'"  جنيه",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),
                              ])
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
