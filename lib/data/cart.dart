
import 'package:aponwola/data/product.dart';

class CartModel {
  final List<Product>? productList;
  final int? quantity;
  final double? total;
  final double? subTotal;

  CartModel({
  this.productList,
    this.quantity,
    this.total,
    this.subTotal
  });
}