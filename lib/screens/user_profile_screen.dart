import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/models/controllers/user_controller.dart';

import '../constant/constants.dart';

class UsersProfileScreen extends StatefulWidget {
  final int? userId;
  const UsersProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UsersProfileScreen> createState() => _UsersProfileScreenState();
}

class _UsersProfileScreenState extends State<UsersProfileScreen> {
  final UsersController usersController = Get.put(UsersController());

  @override
  void initState() {
    usersController.fetchUsers(widget.userId ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('User Detail')),
        body: ListView(
          children: [
            Obx(() {
              if (usersController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final user = usersController.users.value;
              return Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 110,
                        width: 110,
                        child: Card(
                          elevation: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.green.shade100),
                                child: const Icon(
                                  Icons.person_3,
                                  color: Colors.green,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(user.name.toString(), style: namestyle),
                      Text(
                        user.email.toString(),
                        style: subtitle,
                      ),
                      Text(
                        ' Username : ${user.username.toString()}',
                        style: subtitle,
                      ),
                      Text(
                        ' Phone : ${user.phone.toString()}',
                        style: subtitle,
                      ),
                      Text(
                        ' Website : ${user.website.toString()}',
                        style: subtitle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Address',
                        style: namestyle,
                      ),
                      Text(
                        ' Street : ${user.address!.street.toString()}',
                        style: subtitle,
                      ),
                      Text(
                        ' Suite : ${user.address!.suite.toString()}',
                        style: subtitle,
                      ),
                      Text(
                        ' City : ${user.address!.city.toString()}',
                        style: subtitle,
                      ),
                      Text(
                        ' Zipcode : ${user.address!.zipcode.toString()}',
                        style: subtitle,
                      ),
                      Text(
                        ' Geo_lat : ${user.address!.geo!.lat.toString()}',
                        style: subtitle,
                      ),
                      Text(
                        ' Geo_lng : ${user.address!.geo!.lng.toString()}',
                        style: subtitle,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Company',
                        style: namestyle,
                      ),
                      Text(
                        'Company Name : ${user.company!.name.toString()}',
                        style: subtitle,
                      ),
                      Text(
                        'CatchPharse : ${user.company!.catchPhrase.toString()}',
                        style: subtitle,
                      ),
                      Text(
                        'Bs : ${user.company!.bs.toString()}',
                        style: subtitle,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ));
            }),
          ],
        ));
  }
}
