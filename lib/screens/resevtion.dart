import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'dart:io';
import 'package:travelkuy_dashboard/controller/add_travel_controller.dart';
import 'package:travelkuy_dashboard/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'package:travelkuy_dashboard/widgets/snackbar.dart';

class Reservtion extends StatefulWidget {
  const Reservtion({Key? key}) : super(key: key);

  @override
  State<Reservtion> createState() => _ReservtionState();
}

class _ReservtionState extends State<Reservtion> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة رحلة'),
      ),
      resizeToAvoidBottomInset: false,
      body: form(context),
    );
  }
}

Widget form(context) {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;
  return GetBuilder<AddTravelController>(
    init: AddTravelController(),
    builder: (logic) {
      return Form(
        key: logic.formKey,
        child: Container(
            // height: height * 0.65,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(46),
                topRight: Radius.circular(46),
              ),
            ),
            child: ListView(
              padding: EdgeInsets.only(top: 5),
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GetBuilder<AddTravelController>(
                  id: 'image',
                  builder: (logic) {
                    return GestureDetector(
                      onTap: () {
                        logic.imageSelect();
                      },
                      child: Container(
                        height: height * 0.35,
                        width: width * 0.65,
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(46),
                        ),
                        child: logic.image == null
                            ? const Center(
                                child: Icon(Icons.add_a_photo_outlined))
                            : Image.file(
                                File(logic.image!.path),
                                fit: BoxFit.cover,
                              ),
                      ),
                    );
                  },
                ),
                Column(
                  children: [
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: logic.no,
                      validator: (value) {
                        return logic.validate(value!);
                      },
                      lable: 'رقم الرحلة',
                      icon: const Icon(Icons.add_location_outlined),
                      input: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: logic.from,
                      validator: (value) {
                        return logic.validateAddress(value!);
                      },
                      lable: 'من',
                      icon: const Icon(Icons.add_location_outlined),
                      input: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                        controller: logic.to,
                        validator: (value) {
                          return logic.validateAddress(value!);
                        },
                        lable: 'إلى',
                        icon: const Icon(Icons.add_location_outlined),
                        input: TextInputType.text),
                    const SizedBox(height: 20),
                    CustomTextField(
                        controller: logic.price,
                        validator: (value) {
                          return logic.validate(value!);
                        },
                        lable: 'السعر',
                        icon: const Icon(Icons.attach_money),
                        input: TextInputType.number),
                    const SizedBox(height: 20),
                    CustomTextField(
                        controller: logic.count,
                        validator: (value) {
                          return logic.validate(value!);
                        },
                        lable: 'عدد المقاعد',
                        icon: const Icon(Icons.numbers),
                        input: TextInputType.number),
                    // const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('زمن الرحلة:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        const SizedBox(
                          width: 10,
                        ),
                        GetBuilder<AddTravelController>(
                          id: 'time',
                          builder: (logic) {
                            return Text(DateFormat.jm().format(logic.time));
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'تاريخ الرحلة:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GetBuilder<AddTravelController>(
                          id: 'time',
                          builder: (logic) {
                            return Text(DateFormat.yMd().format(logic.time));
                          },
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        logic.getDatetime(context);
                      },
                      child: const Text(' تعديل التوقيت '),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            top: height / 65,
                            bottom: height / 65,
                            left: width / 10,
                            right: width / 10)),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(19, 26, 44, 1.0)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    side: const BorderSide())),
                      ),
                    ),
                    // CustomTextField(controller: logic.count, validator: (value){
                    //   return logic.validateAddress(value!);
                    // }, lable: 'زمن الرحلة'),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextButton(
                          onPressed: () async {
                            if (logic.ch == 0) {
                              showbar('error', 'subtitle', 'الرجاء اختيار صورة',
                                  false);
                            } else {
                              logic.addTravel();
                            }
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.only(
                                top: height / 55,
                                bottom: height / 55,
                                left: width / 10,
                                right: width / 10)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(19, 26, 44, 1.0)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    side: const BorderSide(
                                        color:
                                            Color.fromRGBO(19, 26, 44, 1.0)))),
                          ),
                          child: const Text(
                            'حفظ',
                            style: TextStyle(fontSize: 16),
                          )),
                    )
                  ],
                ),
              ],
            )),
      );
    },
  );
}
