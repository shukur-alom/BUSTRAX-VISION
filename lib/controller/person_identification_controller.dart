import 'package:get/get.dart';

class PersonIdentificationController extends GetxController {
  bool _isStudent = true;

  bool get isStudent => _isStudent;

  void changeItToAdmin() {
    _isStudent = false;
    update();
  }

  void changeItToStudent() {
    _isStudent = true;
    update();
  }
}
