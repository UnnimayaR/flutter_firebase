import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/modules/home/widgets/build_menu_items.dart';
import 'package:flutter_firebase/app/modules/home/widgets/build_tab.dart';
import 'package:flutter_firebase/app/modules/home/widgets/drawer.dart';
import 'package:flutter_firebase/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawerEnableOpenDragGesture: true,
      drawer: buildDrawer(),
      appBar: AppBar(
        title: Text('Menu'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            controller.scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Get.toNamed(Routes.orderSummary);
                },
              ),
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: GetBuilder<HomeController>(
                      builder: (controller) => Text(
                            controller.cartItems.length.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.center,
                          )),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              labelPadding: EdgeInsets.all(8),
              controller: controller.tabController,

              unselectedLabelStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              unselectedLabelColor: Colors.grey[600],
              // indicatorSize: TabBarIndicatorSize.tab,
              onTap: (value) {
                controller.selectTabIndex.value = value;
              },
              indicator: MaterialIndicator(
                  topLeftRadius: 4,
                  topRightRadius: 4,
                  color: Colors.red,
                  tabPosition: TabPosition.bottom,
                  horizontalPadding: 0),
              tabs: [
                buildTab('Salads and Soup', 0, controller.selectTabIndex.value),
                buildTab(
                    'From The Barnyard', 1, controller.selectTabIndex.value),
                buildTab('From the Sea', 2, controller.selectTabIndex.value),
              ],
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(Get.context!).size.height,
                child:
                    TabBarView(controller: controller.tabController, children: [
                  buildMenuItems(controller.saladsAndSoups),
                  buildMenuItems(controller.fromTheBarnyard),
                  buildMenuItems(controller.fromTheSea),
                ]),
              ),
            ),
          ],
        );
      }),
    );
  }
}
