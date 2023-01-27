import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:uas_43a87006190362/model/product_model.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  final String url = 'https://dummyjson.com';
  List<Product> products = [];
  Product? product;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  getProducts() async {
    isLoading(true);
    final response = await http.get(Uri.parse('$url/products?skip=0&limit=25'));
    // isLoading.value = false;
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data['products']);
      products =
          List<Product>.from(data['products'].map((x) => Product.fromMap(x)));
    }
    isLoading(false);
  }

  findProduct(int id) async {
    product = await getProduct(id);
  }

  Future<Product?> getProduct(int id) async {
    isLoading(true);
    final response = await http.get(Uri.parse('$url/products/$id'));
    isLoading(false);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Product.fromMap(data);
    }
    return null;
  }

  Future<Product?> addProduct(Product product) async {
    isLoading(true);
    final connect = GetConnect();
    final response = await connect.post('$url/products/add', product.toMap());
    isLoading(false);
    if (response.statusCode == 200) {
      return Product.fromMap(response.body);
    }
    return null;
  }

  Future<Product?> updateProduct(Product product) async {
    isLoading(true);
    final connect = GetConnect();
    final response =
        await connect.put('$url/products/${product.id}', product.toMap());
    isLoading(false);
    if (response.statusCode == 200) {
      return Product.fromMap(response.body);
    }
    return null;
  }

  Future<Product?> deleteProduct(int id) async {
    isLoading(true);
    final connect = GetConnect();
    final response = await connect.delete('$url/products/$id');
    isLoading(false);
    if (response.statusCode == 200) {
      return Product.fromMap(response.body);
    }
    return null;
  }
}
