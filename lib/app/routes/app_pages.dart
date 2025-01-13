import 'package:flutter_firebase/app/modules/auth/views/verify_otp_screen.dart';
import 'package:flutter_firebase/app/modules/home/bindings/home_bindings.dart';
import 'package:flutter_firebase/app/modules/auth/views/auth_screen.dart';
import 'package:flutter_firebase/app/modules/home/views/order_summary.dart';
import 'package:get/get.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.auth;

  static final routes = [
    GetPage(
      name: _Paths.auth,
      page: () => AuthScreen(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.orderSummary,
      page: () => OrderSummaryPage(),
    ),
    GetPage(
      name: _Paths.verify,
      page: () => VerifyOTPScreen(),
    ),
  ];
}
