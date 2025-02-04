import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<Map<String, dynamic>> _cartItems = <Map<String, dynamic>>[].obs;

  RxList<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> item) {
    _cartItems.add(item);
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
  }

  double calculateSubtotal() {
    double subtotal = 0;
    for (var variety in _cartItems) {
      subtotal += variety['price'];
    }
    return subtotal;
  }

}
