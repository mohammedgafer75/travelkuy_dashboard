import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:travelkuy_dashboard/controller/all_res_controller.dart';
import '/style/theme.dart' as theme;

class AllReservtion extends StatelessWidget {
  const AllReservtion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحجوزات'),
      ),
      body: GetX<AllReservationController>(
        init: AllReservationController(),
        builder: (logic) {
    if (logic.reservaiton.isEmpty) {
    return const Center(
    child: Text('No Reservation Founded'));
    } else {
          return ListView.builder(
            itemCount: logic.reservaiton.length,
          itemBuilder:
          (BuildContext context, int index) {
    return
            Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),

              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.blueAccent,
                      theme.Colors.loginGradientEnd
                    ],
                    // begin: FractionalOffset(0.0, 0.0),
                    // end: FractionalOffset(1.0, 1.0),
                    // stops: [0.0, 1.0],
                    // tileMode: TileMode.clamp
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children:  [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('حجز باسم:   ${logic.reservaiton[index].name}', style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Text('عدد المقاعد:  ${logic.reservaiton[index].passNumber}', style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Text('مسار الرحلة:  ${logic.reservaiton[index].from}-${logic.reservaiton[index].to}', style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Text('السعر:  ${logic.reservaiton[index].price}', style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Text('الزمن:  ${logic.reservaiton[index].time}', style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:  Text('الهاتف:  ${logic.reservaiton[index].number}', style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                ),
              ),
            );}
          );
        }},
      ),
    );
  }
}
