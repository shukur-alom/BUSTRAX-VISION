import 'package:get/get.dart';

class BusStatusController extends GetxController {
  bool _isBusMoving = true;
  bool get isBusMoving => _isBusMoving;

  void changeBusStatus() {
    if (_isBusMoving == true) {
      _isBusMoving = false;
    } else {
      _isBusMoving = true;
    }
    update();
  }
}
