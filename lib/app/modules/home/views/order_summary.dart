import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/modules/home/widgets/cart_build_menu_item.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class OrderSummaryPage extends StatefulWidget {
  const OrderSummaryPage({super.key});

  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: const BackButton(color: Colors.black),
          title: const Text(
            'Order Summary',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: GetBuilder<HomeController>(builder: (controller) {
          double totalAmount = 0.0;
          for (var dish in controller.addedToCart) {
            double price = double.parse(dish.price.replaceAll(',', ''));
            totalAmount += price;
            totalAmount += dish.addons.fold(0.0, (sum, addon) {
              double addonPrice = double.parse(addon.price.replaceAll(',', ''));
              totalAmount = sum + addonPrice;
              return totalAmount;
            });
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: controller.cartItems.isEmpty
                ? Center(child: Text('Your cart is empty'))
                : Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B4332),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${controller.addedToCart.length} Dishes - ${controller.addedToCart.length} Items',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height / 2,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final item = controller.cartItems[index];
                            return cartBuildMenuItem(
                              name: item.name,
                              price: double.parse(item.price.toString()),
                              calories: item.calories,
                              quantity: controller.addedToCart
                                  .where((e) => e.id == item.id)
                                  .length,
                              onDecrease: () {
                                controller.addedToCart.remove(item);
                                controller.updateCart();
                              },
                              onIncrease: () {
                                controller.addedToCart.add(item);

                                controller.updateCart();
                              },
                              isVeg: item.isVeg,
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: controller.cartItems.length,
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'INR $totalAmount',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.defaultDialog(
                                title: 'Woohoo!',
                                titleStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textConfirm: 'Okay',
                                buttonColor: const Color(0xFF1B4332),
                                onConfirm: () {
                                  controller.placeOrder();
                                  Get.back();
                                },
                                content: Column(
                                  children: [
                                    const Text('Order Placed Successfully!',
                                        style: TextStyle(
                                          color: Color(0xFF1B4332),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B4332),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Place Order',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        }));
  }
}
