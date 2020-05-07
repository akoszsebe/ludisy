import 'package:flutter/cupertino.dart';
import 'package:ludisy/src/util/assets.dart';

class UiState {
  UiState();

  AssetImage _backgroundImage = AppAssets.background_stair;

  void changeBackgroundImage(AssetImage image) {
    _backgroundImage = image;
  }

  AssetImage getBackgroundImage() {
    return _backgroundImage;
  }
}
