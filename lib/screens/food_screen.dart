import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_43a87006190362/dataaccess/food-dataaccess.dart';
import 'package:uas_43a87006190362/model/food.dart';

class FoodScreens extends StatelessWidget {
  FoodScreens({super.key});
  final FoodDataAccess pda = FoodDataAccess();
  List<Food> list = <Food>[].obs;
  final namaController = TextEditingController();
  final asalController = TextEditingController();
  var isNew = false;
  var id = -1;

  getData() async {
    // pda.deleteAll();
    var data = await pda.getAll();
    list.clear();
    list.addAll(data);
  }

  showButtomSheet() {
    return SingleChildScrollView(
      child: Container(
        height: 280,
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama"),
            TextField(
              controller: namaController,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Asal"),
            TextField(
              controller: asalController,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: Size.infinite.width,
              child: ElevatedButton(
                  onPressed: () async {
                    if (isNew) {
                      await pda.insert(Food(
                          nama: namaController.text,
                          asal: asalController.text));
                      // getData();
                    } else {
                      await pda.update(Food(
                          id: id,
                          nama: namaController.text,
                          asal: asalController.text));
                      // getData();
                    }
                    Get.back();
                    getData();
                  },
                  child: Text("Save")),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return MaterialApp(
      title: "Flutter Sqlite",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Food Sqlite"),
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  return await Get.dialog(AlertDialog(
                    content: Container(
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Are You Sure?"),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                // Get.back(result: true);
                                Get.back(result: true);
                              },
                              child: Text("Delete"))
                        ],
                      ),
                    ),
                  ));
                },
                onDismissed: (direction) async {
                  await pda.deleteById(item.id!);
                  getData();
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    id = item.id!;
                    isNew = false;
                    namaController.text = item.nama;
                    asalController.text = item.asal;
                    Get.bottomSheet(showButtomSheet());
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 54,
                    child: Row(
                      children: [
                        const Icon(Icons.food_bank_sharp),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.nama,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              list[index].asal,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // await pda.insert(Food(nama: "Kerak Telor", asal: "Jakarta"));
            isNew = true;
            namaController.clear();
            asalController.clear();
            Get.bottomSheet(showButtomSheet());
            // FocusScope.of(context).requestFocus();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
