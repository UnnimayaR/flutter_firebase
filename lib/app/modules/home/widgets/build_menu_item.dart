import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/data/models/menu_item.dart';
import 'package:flutter_firebase/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

Widget buildMenuItem(Dish item) {
  return GetBuilder<HomeController>(
    builder: (controller) => Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Icon(
                          Icons.circle,
                          size: 12,
                          color: item.isVeg ? Colors.green : Colors.red,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        item.price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        item.calories.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                controller.addedToCart.remove(item);

                                controller.updateCart();
                              },
                              color: Colors.green,
                              iconSize: 20,
                            ),
                            Text((controller.addedToCart
                                    .where((e) => e.id == item.id)
                                    .length)
                                .toString()),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () async {
                                controller.addedToCart.add(item);

                                controller.updateCart();
                              },
                              color: Colors.green,
                              iconSize: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: Icon(Icons.restaurant_menu),
                  );
                },
              ),
            ),
          ],
        )),
  );
}
