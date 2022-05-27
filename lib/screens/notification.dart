import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:travelkuy_dashboard/controller/all_res_controller.dart';
import 'package:travelkuy_dashboard/controller/auth_controller.dart';
import 'package:travelkuy_dashboard/widgets/custom_button.dart';
import '/style/theme.dart' as theme;

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الحجوزات'),
      ),
      body: GetX<AuthController>(
        init: AuthController(),
        builder: (logic) {
          if (logic.not.isEmpty) {
            return const Center(child: Text('لا توجد اشعارات'));
          } else {
            return ListView.builder(
                itemCount: logic.not.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'تم نفاذ المقاعد في الرحلة رقم :   ${logic.not[index].No}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomTextButton(
                                      lable: 'اضافة مقاعد',
                                      ontap: () {
                                        logic.addSets(logic.not[index].travelId!,
                                            logic.not[index].id!);
                                      },
                                      color: Colors.blueAccent)),
                                      Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomTextButton(
                                  lable: 'حذف',
                                  ontap: () {
                                    logic.deleteNotification(
                                        logic.not[index].id!);
                                  },
                                  color: Colors.blueAccent))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
