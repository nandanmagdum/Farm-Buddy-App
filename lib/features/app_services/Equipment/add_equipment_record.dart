import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishi_vikas/components/my_buttons.dart';
import 'package:krishi_vikas/components/my_text_field.dart';
import 'package:path/path.dart';

import 'equipment_services.dart';

class AddEquipmentRecord extends StatefulWidget {
  @override
  State<AddEquipmentRecord> createState() => _AddEquipmentRecordState();
}

class _AddEquipmentRecordState extends State<AddEquipmentRecord> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController deliveryStatusController =
      TextEditingController();

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
        title: const Text("Add Equipement Record"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              MyTextField(
                  controller: nameController,
                  hintText: "Name",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: materialController,
                  hintText: "Material",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: locationController,
                  hintText: "Location",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: descriptionController,
                  hintText: "Description",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: priceController,
                  hintText: "Price",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: brandController,
                  hintText: "Brand",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: weightController,
                  hintText: "Weight",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: contactController,
                  hintText: "Contact",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: deliveryStatusController,
                  hintText: "Delivary Status",
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
                  print("""
                  $url,
                      ${nameController.text.trim()},
                      ${materialController.text.trim()},
                      ${locationController.text.trim()},
                      ${descriptionController.text.trim()},
                      ${priceController.text.trim()},
                      ${brandController.text.trim()},
                      ${weightController.text.trim()},
                      ${contactController.text.trim()},
                      ${deliveryStatusController.text.trim()}
                  """);
                  bool status = await EquipmentServices().addRecord(
                      url,
                      nameController.text.trim(),
                      materialController.text.trim(),
                      locationController.text.trim(),
                      descriptionController.text.trim(),
                      priceController.text.trim(),
                      brandController.text.trim(),
                      weightController.text.trim(),
                      contactController.text.trim(),
                      deliveryStatusController.text.trim());
                  if (status) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        content: Text("Record added successfully")));
                        Navigator.pop(context);
                  } else {

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
