import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:uas_43a87006190362/controller/product_controller.dart';
import 'package:uas_43a87006190362/model/product_model.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({super.key});
  final controller = Get.put(ProductController());

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController(text: '0,0');
  final discountController = TextEditingController(text: '0,0');
  final stockController = TextEditingController(text: '1');
  final brandController = TextEditingController();
  final categoryController = TextEditingController();
  final thumbnailController = TextEditingController();

  saveProduct() async {
    final product = Product(
        id: 0,
        title: titleController.text,
        description: descriptionController.text,
        category: categoryController.text,
        price: double.parse(priceController.text),
        discountPercentage: double.parse(discountController.text),
        rating: 0.0,
        stock: int.parse(stockController.text),
        brand: brandController.text,
        thumbnail: thumbnailController.text,
        images: []);

    dynamic result;
    if (controller.product == null) {
      result = await controller.addProduct(product);
    } else {
      product.id = controller.product!.id;
      result = await controller.updateProduct(product);
    }
    if (result != null) {
      Get.back();
      Get.snackbar('Save Product Success', 'Product saved with id ${result.id}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      Get.snackbar('Save Product Error', 'Please check your data',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  deleteProduct() async {
    dynamic result;
    if (controller.product != null) {
      result = await controller.deleteProduct(controller.product!.id);
    }

    if (result != null) {
      Get.back();
      Get.snackbar('Delete Product Success', 'Product deleted!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      Get.snackbar('Delete Product Error', 'Please check your data',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          IconButton(
              onPressed: () {
                deleteProduct();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Obx(() {
        if (controller.product != null) {
          final product = controller.product!;
          titleController.text = product.title;
          descriptionController.text = product.description;
          priceController.text = product.price.toString();
          discountController.text = product.discountPercentage.toString();
          stockController.text = product.stock.toString();
          brandController.text = product.brand;
          categoryController.text = product.category;
          thumbnailController.text = product.thumbnail;
        } else {
          titleController.text = '';
          descriptionController.text = '';
          priceController.text = '0';
          discountController.text = '0';
          stockController.text = '1';
          brandController.text = '';
          categoryController.text = '';
          thumbnailController.text = '';
        }
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    const Text('Title'),
                    TextField(
                      controller: titleController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Description'),
                    TextField(
                      controller: descriptionController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Price'),
                    TextField(
                      controller: priceController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Discount'),
                    TextField(
                      controller: discountController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Stock'),
                    TextField(
                      controller: stockController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Brand'),
                    TextField(
                      controller: brandController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Category'),
                    TextField(
                      controller: categoryController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Thumbnail'),
                    TextField(
                      controller: thumbnailController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          saveProduct();
                        },
                        child: const Text('Save'))
                  ],
                ),
              );
      }),
    );
  }
}
