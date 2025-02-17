
import 'package:anuplal/app/screen/MyOrdersScreen/my_orders.dart';
import 'package:anuplal/app/screen/TermsAndCondition/terms_condition.dart';
import 'package:anuplal/app/screen/account/crop_doctor.dart';
import 'package:anuplal/app/screen/dashboard/dashboard_screen.dart';
import 'package:anuplal/app/screen/onboard/location_pick_screen.dart';
import 'package:anuplal/app/screen/onboard/otp_verify_screen.dart';
import 'package:anuplal/app/screen/profile/profile_screen.dart';
import 'package:anuplal/app/screen/store/category_all_product_screen.dart';
import 'package:anuplal/app/screen/store/product_details_screen.dart';
import 'package:get/get.dart';

import '../app/PrivacyPolicy/privacy_policy.dart';
import '../app/screen/AboutUs/about_us.dart';
import '../app/screen/account/Contact_Us.dart';
import '../app/screen/account/cart_screen.dart';

import '../app/screen/account/notification.dart';
import '../app/screen/onboard/login_screen.dart';
import '../app/screen/onboard/sign_up_screen.dart';
import '../app/screen/onboard/splash_screen.dart';



class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String otpVerification = '/otp-verification';
  static const String dashboard = '/dashboard';
  static const String locationPick = '/location-pick';
  static const String categoryProducts = '/category-products';
  static const String productDetail = '/product-detail';
  static const String profile = '/profile';
  static const String cropDoctor = '/crop-doctor';
  static const String cart= '/cart';
  static const String myOrders= '/myOrders';
  static const String ContactUs= '/ContactUs';
  static const String Notification= '/notification';
  static const String aboutUs= '/AboutUs';
  static const String termsAndCondition= '/termsAndCondition';
  static const String privacyPolicy= '/privacyPolicy';
  static const String  Signup= '/Signup';




  /// Routes ==================>
  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getLoginRoute() => login;
  static String getOtpVerificationRoute(String? phoneNo,) => '$otpVerification?phoneNo=$phoneNo';
  static String getDashboardRoute() => dashboard;
  static String getLocationPickRoute() => locationPick;
  static String getCategoryProductRoute() => categoryProducts;
  static String getProductDetailRoute() => productDetail;
  static String getProfileRoute() => profile;
  static String getCropDoctorRoute() => cropDoctor;
  static String getCartRoute() => cart;
  static String getmyOrdersRoute() => myOrders;
  static String getContactUsRoute() => ContactUs;
  static String getNotificationRoute() => Notification;
  static String getSignUpRoute() => Signup;



  /// Pages ==================>
  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: login, page: () =>  LoginScreen()),
    GetPage(name: otpVerification, page: () =>  OtpVerificationScreen(phoneNo :Get.parameters['phoneNo'])),
    GetPage(name: dashboard, page: () =>  const DashboardScreen(pageIndex: 0)),
    GetPage(name: locationPick, page: () =>  LocationPickScreen()),

    GetPage(name: categoryProducts, page: () =>  CategoryAllProductScreen(),),
    GetPage(name: myOrders, page: () =>  MyOrders(),),
    GetPage(name: productDetail, page: () =>  ProductDetailsScreen()),
    GetPage(name: profile, page: () =>  ProfileScreen()),
    GetPage(name: cropDoctor, page: () =>  CropDoctorScreen()),
    GetPage(name: cart, page: () => CartScreen()),
    GetPage(name: ContactUs, page: () => ContactUsScreen()),
    GetPage(name: Notification, page: () => NotificationScreen()),
    GetPage(name: aboutUs, page: () => AboutUs()),
    GetPage(name: termsAndCondition, page: () => TermsCondition()),
    GetPage(name: Signup, page: () =>  SignUpScreen ()),
    GetPage(name: privacyPolicy, page: () =>  const PrivacyPolicy()),



  ];
}