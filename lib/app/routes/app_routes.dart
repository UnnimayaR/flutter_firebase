part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const auth = _Paths.auth;
  static const orderSummary = _Paths.orderSummary;
  static const verify = _Paths.verify;
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const auth = '/auth';
  static const orderSummary = '/orderSummary';
  static const verify = '/verify';
}
