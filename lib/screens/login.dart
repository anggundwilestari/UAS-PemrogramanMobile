import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_43a87006190362/screens/home_screen.dart';
import 'package:uas_43a87006190362/screens/product_screen.dart';

class login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {'email': null, 'password': null};

  _buildEmailField() => TextFormField(
        decoration: const InputDecoration(labelText: 'Email'),
        validator: (value) {
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value!)) {
            return 'not valid';
          }
        },
        onSaved: (Value) {
          formData['email'] = Value;
        },
      );

  _buildPasswordField() => TextFormField(
        decoration: const InputDecoration(labelText: 'Password'),
        validator: (value) {
          if (value!.isEmpty) {
            return 'input pw';
          }
        },
        onSaved: (Value) {
          formData['password'] = Value;
        },
      );

  _buildSubmitButton() => SizedBox(
        child: ElevatedButton(
          onPressed: () {
            // _submitForm();
            // Get.to(() => HomeScreen());
            // Get.to(HomeScreen());
            // Get.to(() => HomeScreen(), binding: Tab());
          },
          child: const Text('Login'),
        ),
      );

  _buildForm() {
    return Form(
        key: _formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 100,
            child: Center(
              child: Text(
                'Welcome',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
          ),
          _buildEmailField(),
          const SizedBox(
            height: 10,
          ),
          _buildPasswordField(),
          const SizedBox(
            height: 10,
          ),
          _buildSubmitButton(),
          const SizedBox(
            height: 10,
          ),
        ]));
  }

  void _submitForm() {
    print('submit form');
    if (_formKey.currentState!.validate()) {
      print('form was validate');
      _formKey.currentState!.save();
      print(formData);
      Get.snackbar('form data',
          'Email: ${formData['email']}Password: ${formData['password']}',
          backgroundColor: Colors.blue, snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter Form',
      home: Scaffold(
          body: Container(
        margin: const EdgeInsets.all(20),
        child: _buildForm(),
      )),
    );
  }
}
