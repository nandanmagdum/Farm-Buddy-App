import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishi_vikas/components/my_buttons.dart';
import 'package:krishi_vikas/components/my_text_field.dart';
import 'package:krishi_vikas/features/app_services/grains/grains_services.dart';
import 'package:path/path.dart';

class AddGrainsRecord extends StatefulWidget {
  @override
  State<AddGrainsRecord> createState() => _AddGrainsRecordState();
}

class _AddGrainsRecordState extends State<AddGrainsRecord> {
  final TextEditingController name = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController no_of_items = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price_in_kg = TextEditingController();
  final TextEditingController brand = TextEditingController();
  final TextEditingController diet_type = TextEditingController();
  final TextEditingController net_quantity = TextEditingController();
  final TextEditingController contact = TextEditingController();

  File? _photo;
  String? url;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> uploadFile() async {
    if (_photo == null) return "";
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
      try {
        final uploadTask = ref.putFile(_photo!);
        final snapshot =
            await uploadTask.whenComplete(() {}); // Wait for completion

        final url = await snapshot.ref.getDownloadURL();
        return url; // Return the download URL
      } catch (e) {
        print('Error uploading image: $e');
        return ''; // Indicate error or handle appropriately
      }
    } catch (e) {
      print('error occured $e');
      return "error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      appBar: AppBar(
        title: const Text("Add Grains Records"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              MyTextField(
                  controller: name,
                  hintText: "Name",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: weight,
                  hintText: "Weight",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: no_of_items,
                  hintText: "Number of Items",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: location,
                  hintText: "Location",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: description,
                  hintText: "Description",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: price_in_kg,
                  hintText: "Price in kg",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: brand,
                  hintText: "Brand",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: diet_type,
                  hintText: "Diet Type",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: net_quantity,
                  hintText: "Net Quantity",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: contact,
                  hintText: "Contact",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              Container(
                // height: 100.h,
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1),
                ),
                child: _photo != null
                    ? Image.file(
                        _photo!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : GestureDetector(
                        onTap: () async {
                          // pick image from gallery
                          imgFromGallery();
                        },
                        child: const Center(
                            child: Text("Tap here to Upload File"))),
              ),
              SizedBox(height: 15.h),
              MyFilledButton(
                text: "Add Record",
                onTap: () async {
                  // upload image on firebase and store the url
                  String url = await uploadFile();
                  print("***** $url");
                  bool status = await GrainServices().addRecord(
                      name.text.trim(),
                      url,
                      weight.text.trim(),
                      no_of_items.text.trim(),
                      location.text.trim(),
                      description.text.trim(),
                      price_in_kg.text.trim(),
                      brand.text.trim(),
                      diet_type.text.trim(),
                      net_quantity.text.trim(),
                      contact.text.trim());
                  if (status) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        content: Text("Record added successfully")));
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
