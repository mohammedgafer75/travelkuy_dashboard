import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:travelkuy_dashboard/controller/auth_controller.dart';

class Customers extends StatelessWidget {
  const Customers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('المشتركين'),
      ),
      body: GetX<AuthController>(
        autoRemove: false,
        builder: (logic) {
          return SizedBox(
            height: data.size.height,
            width: data.size.width,
            child: Stack(children: [
              logic.users.isEmpty
                  ? const Center(
                      child: Text('لا يوجد بيانات'),
                    )
                  : ListView.builder(
                      itemCount: logic.users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            elevation: 5,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Text('${logic.users[index].name}'),
                              leading: CircleAvatar(
                                child: Text('${index + 1}',
                                    style:
                                        const TextStyle(color: Colors.white)),
                                backgroundColor: Colors.blueAccent,
                              ),
                              subtitle:
                                  Text('Number: ${logic.users[index].number}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                                  IconButton(
                                    onPressed: () {
                                      logic.deleteCustomer(
                                          logic.users[index].id!);
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ));
                      },
                    ),
            ]),
          );
        },
      ),
    );
  }
}
