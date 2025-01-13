import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/data/models/menu_item.dart';
import 'package:flutter_firebase/app/modules/home/widgets/build_menu_item.dart';
import 'package:get/get.dart';

Widget buildMenuItems(List<Dish> menuItems) {
  return Obx(() => SingleChildScrollView(
        child: Column(
          children: menuItems
              .where((item) => true) // Add category filtering logic here
              .map((item) => buildMenuItem(item))
              .toList(),
        ),
      ));
}
