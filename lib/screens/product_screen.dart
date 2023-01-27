import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_43a87006190362/controller/product_controller.dart';
import 'package:uas_43a87006190362/screens/productdetail_screen.dart';

class ProductScreens extends StatelessWidget {
  ProductScreens({super.key});
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter RestAPI',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter RestAPI'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  controller.findProduct(0);
                  Get.to(() => ProductDetail());
                },
                icon: const Icon(Icons.add_box))
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                      mainAxisExtent: 280),
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            controller.findProduct(product.id);
                            Get.to(() => ProductDetail());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: SizedBox(
                                  width: Size.infinite.width,
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Image.network(
                                      product.thumbnail,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                width: Size.infinite.width,
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.category,
                                      style: const TextStyle(
                                          color: Colors.blue, fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      product.title,
                                      overflow: TextOverflow.fade,
                                      maxLines: 2,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      '\$${product.price}',
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                          size: 14,
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                            '${product.rating} | Stock ${product.stock}'),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
        ),
      ),
    );
  }
}
