import 'package:get/get.dart';

import 'package:char_project/app/modules/Home/bindings/home_binding.dart';
import 'package:char_project/app/modules/Home/views/home_view.dart';
import 'package:char_project/app/modules/chat_screen/bindings/chat_screen_binding.dart';
import 'package:char_project/app/modules/chat_screen/views/chat_screen_view.dart';
import 'package:char_project/app/modules/login_page/bindings/login_page_binding.dart';
import 'package:char_project/app/modules/login_page/views/login_page_view.dart';
import 'package:char_project/app/modules/sign_up/bindings/sign_up_binding.dart';
import 'package:char_project/app/modules/sign_up/views/sign_up_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_SCREEN,
      page: () => ChatScreenView(),
      binding: ChatScreenBinding(),
    ),
  ];
}
