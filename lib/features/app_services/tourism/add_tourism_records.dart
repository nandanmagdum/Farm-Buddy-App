import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishi_vikas/components/my_buttons.dart';
import 'package:krishi_vikas/components/my_text_field.dart';
import 'package:krishi_vikas/features/app_services/tourism/tourism_services.dart';
import 'package:path/path.dart';

class AddTourismRecord extends StatefulWidget {
  @override
  State<AddTourismRecord> createState() => _AddTourismRecordState();
}

class _AddTourismRecordState extends State<AddTourismRecord> {
  final TextEditingController farm_name = TextEditingController();
  final TextEditingController owner_name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController farm_specialization = TextEditingController();
  final TextEditingController availability = TextEditingController();
  final TextEditingController check_in = TextEditingController();
  final TextEditingController check_out = TextEditingController();
  final TextEditingController total_price = TextEditingController();

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
        title: const Text("Add Tourism record"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              MyTextField(
                  controller: farm_name,
                  hintText: "Farm Name",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: owner_name,
                  hintText: "Owner Name",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: email,
                  hintText: "Email",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: phone,
                  hintText: "Phone",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: address,
                  hintText: "Address",
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
                  controller: farm_specialization,
                  hintText: "Farm Specialization",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: availability,
                  hintText: "Availability",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: check_in,
                  hintText: "Check in",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: check_out,
                  hintText: "Check out",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: total_price,
                  hintText: "Total Price",
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
                  bool status = await TourismServices().addRecord(
                      url,
                      farm_name.text.trim(),
                      owner_name.text.trim(),
                      email.text.trim(),
                      phone.text.trim(),
                      address.text.trim(),
                      description.text.trim(),
                      farm_specialization.text.trim(),
                      availability.text.trim(),
                      check_in.text.trim(),
                      check_out.text.trim(),
                      total_price.text.trim());
                  if (status) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        content: Text("Record add successfully")));
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
