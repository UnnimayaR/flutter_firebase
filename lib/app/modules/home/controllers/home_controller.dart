import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/data/data_sources/loca_data_sources.dart';
import 'package:flutter_firebase/app/data/models/menu_item.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  var saladsAndSoups = <Dish>[].obs;
  var fromTheBarnyard = <Dish>[].obs;
  var fromTheSea = <Dish>[].obs;
  var addedToCart = <Dish>[].obs;
  var cartItems = <Dish>[];
  var isLoading = true.obs;
  var selectTabIndex = 0.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TabController? tabController;
  @override
  void onInit() {
    super.onInit();
    fetchMenuItems();
    fetchCart();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  updateCart() async {
    await LocalDataSource.setMenuItems(addedToCart);

    List<Dish> items = await LocalDataSource.getMenuItems();
    // cartItems = cartItems.toSet().toList();
    for (var element in items) {
      element.qty = items.where((e) => e.id == element.id).length;
      cartItems.addIf(
          cartItems.where((e) => e.id == element.id).isEmpty, element);
      log('mmmmmmmmmmmmmmmm ${cartItems.length}');
    }
    update();
  }

  placeOrder() async {
    await LocalDataSource.setMenuItems(<Dish>[]);
    addedToCart.clear();
    cartItems.clear();
    update();
    Get.back();
  }

  fetchCart() async {
    cartItems = await LocalDataSource.getMenuItems();

    log(cartItems.length.toString());
    update();
  }

  Future<void> fetchMenuItems() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('https://faheemkodi.github.io/mock-menu-api/menu.json'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body.toString());
        final categories = data['categories']
            .map((categoryJson) => Category.fromJson(categoryJson))
            .toList();
        for (var category in categories) {
          if (category.name == 'Salads and Soup') {
            saladsAndSoups.addAll(category.dishes);
          } else if (category.name == 'From The Barnyard') {
            fromTheBarnyard.addAll(category.dishes);
          } else if (category.name == 'From the Sea') {
            fromTheSea.addAll(category.dishes);
          }
        }
        saladsAndSoups.where((item) => item.isVeg == true).toList();
        update();
        //   final data = json.decode(response.body);
        //   log(data.toString());

        // menuItems.value =
        //     categories.map((item) => Dish.fromJson(item)).toList();
      }
    } catch (e) {
      print('Error fetching menu items: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
