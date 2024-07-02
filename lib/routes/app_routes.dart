import 'package:duara_ecommerce/features/authentication/screens/login/login.dart';
import 'package:duara_ecommerce/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:duara_ecommerce/features/authentication/screens/pswd_config/forgot_password.dart';
import 'package:duara_ecommerce/features/authentication/screens/signup/signup.dart';
import 'package:duara_ecommerce/features/authentication/screens/signup/verify_email.dart';
import 'package:duara_ecommerce/features/personalization/screens/addresses/addresses.dart';
import 'package:duara_ecommerce/features/personalization/screens/profile/profile.dart';
import 'package:duara_ecommerce/features/personalization/screens/settings/settings.dart';
import 'package:duara_ecommerce/features/shop/screens/cart/cart.dart';
import 'package:duara_ecommerce/features/shop/screens/checkout/checkout.dart';
import 'package:duara_ecommerce/features/shop/screens/home/home.dart';
import 'package:duara_ecommerce/features/shop/screens/orders/orders.dart';
import 'package:duara_ecommerce/features/shop/screens/p_reviews/p_reviews.dart';
import 'package:duara_ecommerce/features/shop/screens/store/store.dart';
import 'package:duara_ecommerce/features/shop/screens/wishlist/wishlist.dart';
import 'package:duara_ecommerce/routes/routes.dart';
import 'package:get/get.dart';

class CAppRoutes {
  static final pages = [
    GetPage(
      name: CRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: CRoutes.store,
      page: () => const CStoreScreen(),
    ),
    GetPage(
      name: CRoutes.wishList,
      page: () => const WishlistScreen(),
    ),
    GetPage(
      name: CRoutes.settings,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: CRoutes.productReviews,
      page: () => const ProductReviewsScreen(),
    ),
    GetPage(
      name: CRoutes.orders,
      page: () => const OrdersScreen(),
    ),
    GetPage(
      name: CRoutes.checkout,
      page: () => const CCheckoutScreen(),
    ),
    GetPage(
      name: CRoutes.cart,
      page: () => const CCartScreen(),
    ),
    GetPage(
      name: CRoutes.userProfile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: CRoutes.userAddress,
      page: () => const UserAddressesScreen(),
    ),
    GetPage(
      name: CRoutes.signup,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: CRoutes.verifyEmail,
      page: () => const VerifyEmailScreen(),
    ),
    GetPage(
      name: CRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: CRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: CRoutes.onBoarding,
      page: () => const OnboardingScreen(),
    ),
  ];
}
