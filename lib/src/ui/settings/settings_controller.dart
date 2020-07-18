import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:ludisy/src/ui/dto/developer.dto.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:ludisy/src/data/model/user_model.dart';
import 'package:ludisy/src/di/locator.dart';
import 'package:ludisy/src/states/user_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import 'package:ludisy/src/util/assets.dart';

class SettingsController extends ControllerMVC {
  final UserState userState = locator<UserState>();

  User userData = User();

  bool available = true;

  String versionName = "";


  /// Consumable credits the user can buy
  int credits = 0;

  Future<void> init() async {
    userData = userState.getUserData();
    var packageInfo = await PackageInfo.fromPlatform();
    versionName = "${packageInfo.appName} v${packageInfo.version}";
    refresh();
  }

  void launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<Developer> loadDevelopers() {
    return [
      new Developer(name: "Akos", role: "App developer", photo: AppAssets.developer_image, url: "https://www.linkedin.com/in/zsebe-akos-b581b9139" ),
      new Developer(name: "Tibold", role: "Designer and developer", photo: AppAssets.designer_image, url: "https://www.linkedin.com/in/jozsa-tibold"),
      new Developer(name: "Ferenc", role: "Backend developer", photo: AppAssets.be_developer_image, url: "https://www.linkedin.com/in/ferenc-solyom-465606119")
    ];
  }

  Future<void> pay(index) async {
    final bool available = await InAppPurchaseConnection.instance.isAvailable();
    if (available) {
      print("available");
      const Set<String> _kIds = {
        'buy_water_for_developer',
        'buy_coffee_for_developer',
        'buy_lunch_for_developer'
      };
      final ProductDetailsResponse response =
          await InAppPurchaseConnection.instance.queryProductDetails(_kIds);
      if (response.notFoundIDs.isNotEmpty) {
        print("error products");
      }
      List<ProductDetails> products = response.productDetails;
      print("$products");
      if (products.length > 2) {
        ProductDetails selectedProduct = products.elementAt(index);
        if (selectedProduct != null) {
          final PurchaseParam purchaseParam =
              PurchaseParam(productDetails: selectedProduct);

          ///if (_isConsumable(selectedProduct)) {
          InAppPurchaseConnection.instance
              .buyConsumable(purchaseParam: purchaseParam);
          // } else {
          //   InAppPurchaseConnection.instance
          //       .buyNonConsumable(purchaseParam: purchaseParam);
          //}
        }
      }
    } else {
      print("not available");
    }
  }
}

