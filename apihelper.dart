import 'dart:convert';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xerosh/services/networking.dart';
import 'package:xerosh/services/token.dart';

import 'api.dart';

class ApiHelper {
  //---------------------- Sign up new user --------------------------------------
  static Future<dynamic> signUp(
    String fullName,
    String emaildId,
    String phoneNumber,
    String password,
  ) async {
    Map<String, String> body = {
      'full_name': fullName,
      'email': emaildId,
      'phone_number': phoneNumber,
      'password': password,
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken()
    };

    //var url = '${Api.kSignUpUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kSignUpUrl;

    debugPrint('Sign Up Url - $url');
    debugPrint('Sign Up Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Login User --------------------------------------
  static Future<dynamic> login(
      String emaildId, String password, String fcmToken) async {
    Map<String, String> body = {
      'email': emaildId,
      'password': password,
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'fcm_token': fcmToken,
      'device_type': Platform.isIOS ? 'IOS' : 'Android',
    };

    //var url = '${Api.kLoginUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kLoginUrl;
    debugPrint('Login Url - $url');
    debugPrint('Login Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Login User with phone number --------------------------------------
  static Future<dynamic> loginWithPhoneNumber(String phoneNumber) async {
    Map<String, String> body = {
      'phone_number': phoneNumber,
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken()
    
    };

    //var url =
      //  '${Api.kLoginWithPhoneNumberUrl}/?access_token=${await Token.getToken()}';
      var url = Api.kLoginWithPhoneNumberUrl;
    debugPrint('Login with phone number Url - $url');
    debugPrint('Login with phone number Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Verify OTP --------------------------------------
  static Future<dynamic> verifyOTP(String phoneNumber, String otp) async {
    Map<String, String> body = {
      'phone_number': phoneNumber,
      'otp': otp,
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken()
    
    };

    //var url = '${Api.kVerifyOTPUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kVerifyOTPUrl;
    debugPrint('Verify OTP Url - $url');
    debugPrint('Verify OTP Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Forgot Password --------------------------------------
  static Future<dynamic> forgotPassword(String emaildId) async {
    Map<String, String> body = {
      'email': emaildId,
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken()
    
    };

    //var url =
      //  '${Api.kForgotPasswordUrl}/?access_token=${await Token.getToken()}';
      var url = Api.kForgotPasswordUrl;
    debugPrint('Forgot password Url - $url');
    debugPrint('Forgot password Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Verify OTP from Forgot password --------------------------------------
  static Future<dynamic> verifyOTPFromForgotPassword(
      String email, String otp) async {
    Map<String, String> body = {
      'email': email,
      'otp': otp,
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken()
    
    };

    //var url =
        //'${Api.kVerifyOTPFromForgotPasswordUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kVerifyOTPFromForgotPasswordUrl;    
    debugPrint('Verify OTP Forgot Password Url - $url');
    debugPrint('Verify OTP Forgot Password Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Create new password --------------------------------------
  static Future<dynamic> createNewPassword(
      String emaildId, String password, String otp) async {
    Map<String, String> body = {
      'email': emaildId,
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'new_password': password,
      'otp': otp,
    };

    //var url =
        //'${Api.kCreateNewPasswordUrl}/?access_token=${await Token.getToken()}';
        var url =Api.kCreateNewPasswordUrl;
    debugPrint('Create new Password Url - $url');
    debugPrint('Create new Password Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Select Category ------------------------------
  static Future<dynamic> selectCategory(
      String settingValue, String settingType) async {
    //SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      //  'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'setting_type': settingType,
      'setting_value': settingValue,
    };

   // var url =
        //'${Api.kChangeSettingUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kChangeSettingUrl;    
    debugPrint('Change setting Url - $url');
    debugPrint('Chnage setting Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get age  list ------------------------------
  static Future<dynamic> getAgeList() async {
    Map<String, String> body = {
      'device_id': await FlutterUdid.udid,
      //'access_token': await Token.getToken()
    };

    //var url = '${Api.kGetAgeListUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kGetAgeListUrl;

    debugPrint('Get Age list Url - $url');
    debugPrint('Get age list Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Change Password --------------------------------------
  static Future<dynamic> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'customer_id': pref.getString('NSUD_userId').toString(),
      'password': pref.getString('NSUD_password').toString(),
      'current_password': currentPassword.toString(),
      'new_password': newPassword.toString(),
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken()
    
    };

    //var url =
        //'${Api.kChangePasswordUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kChangePasswordUrl;    
    debugPrint('Change password Url - $url');
    debugPrint('Change password Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get category list ------------------------------
  static Future<dynamic> getCategoryList(String categoryId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',

      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'parent': categoryId.isEmpty ? "" : categoryId,
    };
    //var url =
      //  '${Api.kGetCategoryListUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kGetCategoryListUrl;    
    debugPrint('Get category list Url - $url');
    debugPrint('Get category list Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get product list ------------------------------
  static Future<dynamic> getProductList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'customer_id': pref.getString('NSUD_userId').toString(),
      'password': pref.getString('NSUD_password').toString(),
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
    
    };
    //var url =
      //  '${Api.kGetProductListUrl}/?access_token=${await Token.getToken()}';
      var url = Api.kGetProductListUrl;
    debugPrint('Get product list Url - $url');
    debugPrint('Get product list Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get product detail ------------------------------
  static Future<dynamic> getProductDetail(
      String productId, String postalCode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),

      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',

      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'product_id': productId,
      'postalcode': postalCode,
    };
    //var url =
       // '${Api.kGetProductDetailUrl}/?access_token=${await Token.getToken()}';
       var url =  Api.kGetProductDetailUrl;
    debugPrint('Get product detail Url - $url');
    debugPrint('Get product detail Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Add to cart Password --------------------------------------
  static Future<dynamic> addToCart(
    String productId,
    String quantity,
    String ageId,
    String colorId,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),

      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',

      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'product_id': productId,
      'quantity': quantity,
      'age_id': ageId,
      'color_id': colorId.toString(),
    };

    //var url = '${Api.kAddToCartUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kAddToCartUrl;
    debugPrint('Add to cart Url - $url');
    debugPrint('Add to cart Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get Cart list ------------------------------
  static Future<dynamic> getCartList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',

      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
    };

    //var url = '${Api.kGetCartListUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kGetCartListUrl;
    debugPrint('Get cart list Url - $url');
    debugPrint('Get cart list Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Delete Cart ------------------------------
  static Future<dynamic> deleteCart(String cartId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),

      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',

      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'cart_id': cartId,
    };

    //var url = '${Api.kDeleteCartUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kDeleteCartUrl;
    debugPrint('Delete cart Url - $url');
    debugPrint('Delete cart Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Add to wishlist ------------------------------
  static Future<dynamic> addToWishlist(String productId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'product_id': productId
    };

    //var url =
        //'${Api.kAddToWishlistUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kAddToWishlistUrl;    
    debugPrint('Add to wishlist Url - $url');
    debugPrint('Add to wishlist Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get wishlist list ------------------------------
  static Future<dynamic> getWishlist() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
    };

    //var url = '${Api.kGetWishlistUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kGetWishlistUrl;
    debugPrint('Get wishlist list Url - $url');
    debugPrint('Get wishlist Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Delete wishlist ------------------------------
  static Future<dynamic> deleteWishlist(String productId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      // 'wishlist_id': productId,
      'product_id': productId,
    };

   // var url =
        //'${Api.kDeleteWishlistUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kDeleteWishlistUrl;
    debugPrint('Delete wishlist Url - $url');
    debugPrint('Delete wishlist Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get Home data------------------------------
  static Future<dynamic> getHomeData(
    String ageId,
    String type,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',

      // 'customer_id': '1',
      // 'password':
      //     "\$2y\$10\$0yXseoAjm/lq8sBX1wDPduigYOpsutypSqsiZUHfSG5sqKtwaeJAK",

      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'age_id': ageId.toString(),
      'kid': type.toString(),
    };

    //var url = '${Api.kGetHomeDatatUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kGetHomeDatatUrl;
    debugPrint('Get home data Url - $url');
    debugPrint('Get home data Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get total list ------------------------------
  static Future<dynamic> getTotalList(couponId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',

      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'coupon_id': couponId.toString(),
    };

    //var url = '${Api.kGetTotalListUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kGetTotalListUrl;
    debugPrint('Get total list Url - $url');
    debugPrint('Get total list Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Apply Coupon --------------------------------------
  static Future<dynamic> applyCoupon(
    String couponCode,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'customer_id': pref.getString('NSUD_userId').toString(),
      'password': pref.getString('NSUD_password').toString(),
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'coupon_code': couponCode
    };

    //var url = '${Api.kApplyCouponUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kApplyCouponUrl;
    debugPrint('Apply coupon Url - $url');
    debugPrint('Apply coupon Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Validate checkout --------------------------------------
  static Future<dynamic> validateCheckout(
    String addressId,
    String paymentMethod,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'customer_id': pref.getString('NSUD_userId').toString(),
      'password': pref.getString('NSUD_password').toString(),
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'address_id': addressId.toString(),
      'payment_method': paymentMethod.toString()
    };

    //var url =
       // '${Api.kValidateCheckout}/?access_token=${await Token.getToken()}';
    var url = Api.kValidateCheckout;   
    debugPrint('Validate checkout Url - $url');
    debugPrint('Validate Checkout Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Address type list -----------------------------------
  static Future<dynamic> getAddressTYpeList() async {
    Map<String, String> body = {
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
    };

    //var url =
        //'${Api.kGetAddressTypeListUrl}/?access_token=${await Token.getToken()}';
        var url = Api.kGetAddressTypeListUrl;
    debugPrint('Address type list Url - $url');
    debugPrint('Address type list Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- State list -----------------------------------
  static Future<dynamic> getStateList() async {
    Map<String, String> body = {
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'country_id': '101'
    };

    //var url = '${Api.kGetStateListUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kGetStateListUrl;
    debugPrint('State list Url - $url');
    debugPrint('State list Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- City list -----------------------------------
  static Future<dynamic> cityList(stateId) async {
    Map<String, String> body = {
      'device_id': await FlutterUdid.udid,
      'state_id': stateId.toString(),
      'access_token': await Token.getToken(),
    };

    //var url = '${Api.kGetCityListUrl}/?access_token=${await Token.getToken()}';
    var url  = Api.kGetCityListUrl;
    debugPrint('City list Url - $url');
    debugPrint('City list Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  // //---------------------- Add address --------------------------------------
  // static Future<dynamic> addAddress(
  //   String addressTypeId,
  //   String houseNumber,
  //   String streetAddress,
  //   String stateId,
  //   String cityId,
  //   String postalCode,
  //   String phoneNumber,
  // ) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   Map<String, String> body = {
  //     'customer_id': pref.getString('NSUD_userId').toString(),
  //     'password': pref.getString('NSUD_password').toString(),
  //     'device_id': await FlutterUdid.udid,
  //     'address_type_id': addressTypeId,
  //     'house_number': houseNumber,
  //     'street_address': streetAddress,
  //     'state_id': stateId,
  //     'city_id': cityId,
  //     'postal_code': postalCode,
  //     'phone_number': phoneNumber,
  //   };

  //   var url =
  //       '${Api.kAddNewAddressUrl}/?access_token=${await Token.getToken()}';
  //   debugPrint('Add address Url - $url');
  //   debugPrint('Add address Parameter Body - $body');
  //   return jsonDecode(await Networking.post(url, body));
  // }

//---------------------- Delete Account --------------------------------------
  static Future<dynamic> deleteAccount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'customer_id': pref.getString('NSUD_userId').toString(),
      'password': pref.getString('NSUD_password').toString(),
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
    };

    //var url =
        //'${Api.kDeleteAccountUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kDeleteAccountUrl;    
    debugPrint('Delete Account Url - $url');
    debugPrint('Delete Account Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get discount  list ------------------------------
  static Future<dynamic> getDiscountList() async {
    Map<String, String> body = {
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
    };

    //var url =
        //'${Api.kGetDiscountListUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kGetDiscountListUrl;    
    debugPrint('Get getDiscountList list Url - $url');
    debugPrint('Get getDiscountList list Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Add pincode ------------------------------
  static Future<dynamic> addPincode(String pinCode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'customer_id': pref.getString('NSUD_userId').toString(),
      'password': pref.getString('NSUD_password').toString(),
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'setting_type': 'deliver_to',
      'setting_value': pinCode.toString(),
    };

    //var url =
        //'${Api.kChangeSettingUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kChangeSettingUrl;    
    debugPrint('Add pincode Url - $url');
    debugPrint('Add pincode Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Update quantity ------------------------------
  static Future<dynamic> updateQuantity(String cartId, String quantity) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',

      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'cart_id': cartId.toString(),
      'quantity': quantity.toString(),
    };

    //var url =
        //'${Api.kUpdateQuantityUrl}/?access_token=${await Token.getToken()}';
    var url =  Api.kUpdateQuantityUrl;    
    debugPrint('Update cart quantity pincode Url - $url');
    debugPrint('Update cart quantity Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Payment with COD --------------------------------------
  static Future<dynamic> paymentWithCOD(
    String addressId,
    String paymentMethod,
    String couponId,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'customer_id': pref.getString('NSUD_userId').toString(),
      'password': pref.getString('NSUD_password').toString(),
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'address_id': addressId.toString(),
      'payment_method': paymentMethod.toString(),
      'coupon_id': couponId.toString(),
    };

    //var url =
        //'${Api.kPaymentWithCODUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kPaymentWithCODUrl;    
    debugPrint('Payment with cod coupon Url - $url');
    debugPrint('Payment with cod Parameter Body - $body');

    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get order list ------------------------------
  static Future<dynamic> getOrderList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
    };

    //var url = '${Api.kGetOrderListUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kGetOrderListUrl;
    debugPrint('Get order list Url - $url');
    debugPrint('Get order list Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get notification list ------------------------------
  static Future<dynamic> getNotificationList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'customer_id': pref.getString('NSUD_userId').toString(),
      'password': pref.getString('NSUD_password').toString(),
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
    };

    //var url =
        //'${Api.kGetNotificationListUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kGetNotificationListUrl;    
    debugPrint('Get notification list Url - $url');
    debugPrint('Get notification list Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get order detail ------------------------------
  static Future<dynamic> getOrderDetail(String orderId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'customer_id': pref.getString('NSUD_userId').toString(),
      'password': pref.getString('NSUD_password').toString(),
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'order_id': orderId,
    };
    //var url =
        //'${Api.kGetOrderDetailUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kGetOrderDetailUrl;    
    debugPrint('Get order detail Url - $url');
    debugPrint('Get order detail Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get Address list ------------------------------
  static Future<dynamic> getaddressList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
    };

    //var url =
        //'${Api.kGetAddressListUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kGetAddressListUrl;    
    debugPrint('Get address list Url - $url');
    debugPrint('Get address list Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Make Default Address ------------------------------
  static Future<dynamic> makeDefaultaAddress(int addressID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'address_id': addressID.toString(),
    };

    //var url =
        //'${Api.kMakeDefaultAddresstUrl}/?access_token=${await Token.getToken()}';
    var url  = Api.kMakeDefaultAddresstUrl;    
    debugPrint('Make address default Url - $url');
    debugPrint('Make address default Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Delete Address ------------------------------
  static Future<dynamic> deletetaAddress(int addressID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'address_id': addressID.toString(),
    };

    //var url =
        //'${Api.kDeleteAddresstUrl}/?access_token=${await Token.getToken()}';
    var url =  Api.kDeleteAddresstUrl;    
    debugPrint('Delete address Url - $url');
    debugPrint('Delete address Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get Address list ------------------------------
  static Future<dynamic> addNewAddress(
    String fullname,
    String phonenumber,
    String housenumber,
    String streetaddress,
    int stateid,
    int cityid,
    String postalcode,
    String addresstype,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'full_name': fullname.toString(),
      'phone_number': phonenumber.toString(),
      'house_number': housenumber.toString(),
      'street_address': streetaddress.toString(),
      'state_id': stateid.toString(),
      'city_id': cityid.toString(),
      'postal_code': postalcode.toString(),
      'address_type': addresstype.toString(),
    };

    //var url =
        //'${Api.kAddNewAddressUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kAddNewAddressUrl;    
    debugPrint('Add address Url - $url');
    debugPrint('Add address Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get Address list ------------------------------
  static Future<dynamic> updateAddress(
      String fullname,
      String phonenumber,
      String housenumber,
      String streetaddress,
      int stateid,
      int cityid,
      String postalcode,
      String addresstype,
      int maddressID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'full_name': fullname.toString(),
      'phone_number': phonenumber.toString(),
      'house_number': housenumber.toString(),
      'street_address': streetaddress.toString(),
      'state_id': stateid.toString(),
      'city_id': cityid.toString(),
      'postal_code': postalcode.toString(),
      'address_type': addresstype.toString(),
      'address_id': maddressID.toString(),
    };

    //var url =
        //'${Api.kUpdateAddressUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kUpdateAddressUrl;    
    debugPrint('update address Url - $url');
    debugPrint('update address Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get Address detail ------------------------------
  static Future<dynamic> getAddressDetail(int maddressID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),
      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
      'address_id': maddressID.toString()
    };

   // var url =
        //'${Api.kGetAddressDetailUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kGetAddressDetailUrl;    
    debugPrint('Get address detail Url - $url');
    debugPrint('Get address detail Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- get cart item count ------------------------------
  static Future<dynamic> getCartItemCount() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      // 'customer_id': pref.getString('NSUD_userId').toString(),
      // 'password': pref.getString('NSUD_password').toString(),

      'customer_id': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_userId').toString()
          : '',
      'password': pref.getString('NSUD_userId') != null
          ? pref.getString('NSUD_password').toString()
          : '',

      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
    };

    //var url =
        //'${Api.kGetCartItemCountUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kGetCartItemCountUrl;    
    debugPrint('Get cart item count Url - $url');
    debugPrint('Get cart item count Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }

  //---------------------- Remove Coupon ------------------------------
  static Future<dynamic> removeCoupon() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> body = {
      'customer_id': pref.getString('NSUD_userId').toString(),
      'password': pref.getString('NSUD_password').toString(),
      'device_id': await FlutterUdid.udid,
      'access_token': await Token.getToken(),
    };

    //var url = '${Api.kRemoveCouponUrl}/?access_token=${await Token.getToken()}';
    var url = Api.kRemoveCouponUrl;
    debugPrint('Remove Url - $url');
    debugPrint('Remove cart Parameter Body - $body');
    return jsonDecode(await Networking.post(url, body));
  }
}
