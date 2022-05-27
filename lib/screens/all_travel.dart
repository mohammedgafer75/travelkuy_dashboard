import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:travelkuy_dashboard/controller/all_travel_controller.dart';

import '../widgets/property.dart';

class AllTravel extends StatelessWidget {
  const AllTravel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جميع الرحلات'),
      ),
      body: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            color: Colors.white,
          ),
          // color: Color.fromRGBO(19, 26, 44, 1.0),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GetX<AllTravelController>(
              // autoRemove: false,
              init: AllTravelController(),
              builder: (controller) {
                if (controller.travels.isEmpty) {
                  return const Center(
                      child: Text('No Travels Founded'));
                } else {
                  return ListView.builder(
                    itemBuilder:
                        (BuildContext context, int index) {
                      return Hero(
                          tag: Image.network(
                            controller.travels[index]
                                .image!,
                            fit: BoxFit.fill,
                          ),
                          child: Property(
                              property: controller
                                  .travels[index]));
                    },
                    itemCount: controller.travels.length,
                  );
                }
              })),



    );
  }
}
