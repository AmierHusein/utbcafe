import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:utb_cafe/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/customized_drawer.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({Key? key}) : super(key: key);

  @override
  State<VendorScreen> createState() => _VendorScreen();
}

class _VendorScreen extends State<VendorScreen> {
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  File?  _image;

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future<void> _addProduct() async {
    final formState = _formKey.currentState;

    if (formState!.validate() && _image != null) {
      formState.save();

      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child('product_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = storageRef.putFile(_image!.absolute);
      final TaskSnapshot downloadUrl = (await uploadTask);
      final String url = await downloadUrl.ref.getDownloadURL();

      // Add product to Firestore
      final CollectionReference productCollection = FirebaseFirestore.instance.collection('Foods');
      productCollection.add({
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'imageUrl': url,
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added successfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Menu Settings'),
      ),
      drawer: const CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(labelText: 'Stock Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter stock quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _image == null
                  ? const Text('No image selected.')
                  : Image.file(_image!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: getImage,
                child: const Text('Choose Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addProduct,
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





          // Text("Hello $userName"),
          // ElevatedButton(
          //     onPressed: () async {
          //       await FirebaseAuth.instance.signOut();
          //       if (!mounted) return;
          //       Navigator.push(context, MaterialPageRoute(builder: (context) {
          //         return const WelcomeScreen();
          //       }));
          //     },
          //     child: const Text("Sign Out"))
//         ],
//       ),
//     );
//   }
// }

