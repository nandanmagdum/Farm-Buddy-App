import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishi_vikas/components/my_buttons.dart';
import 'package:krishi_vikas/components/my_text_field.dart';
import 'package:krishi_vikas/features/app_services/vehicle_rent/vehicle_rent_services.dart';
import 'package:path/path.dart';

class AddVehicleRecord extends StatefulWidget {
  @override
  State<AddVehicleRecord> createState() => _AddVehicleRecordState();
}

class _AddVehicleRecordState extends State<AddVehicleRecord> {
  final TextEditingController username = TextEditingController();
  final TextEditingController aadhar_number = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController date_of_birth = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController street_address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController zip = TextEditingController();
  final TextEditingController pricing_model = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController open_from = TextEditingController();
  final TextEditingController open_to = TextEditingController();
  final TextEditingController open_time = TextEditingController();
  final TextEditingController closing_time = TextEditingController();
  final TextEditingController service_area = TextEditingController();
  final TextEditingController photo_url = TextEditingController();

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
      // floatingActionButton: FloatingActionButton(onPressed: () {}),
      appBar: AppBar(
        title: const Text("Add Vehicle record"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              MyTextField(
                  controller: username,
                  hintText: "Username",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: aadhar_number,
                  hintText: "Aadhar Number",
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
                  controller: date_of_birth,
                  hintText: "Date of Birth",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: gender,
                  hintText: "Gender",
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
                  controller: street_address,
                  hintText: "Street Address",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: city,
                  hintText: "City",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: state,
                  hintText: "State",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: country,
                  hintText: "Country",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: zip,
                  hintText: "Zip",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: pricing_model,
                  hintText: "Pricing Model",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: price,
                  hintText: "Price",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: open_from,
                  hintText: "Open from",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: open_to,
                  hintText: "Open to",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: open_time,
                  hintText: "Open Time",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: closing_time,
                  hintText: "Closing Time",
                  obsecureText: false,
                  prefixIcon: const Icon(Icons.animation)),
              SizedBox(height: 15.h),
              MyTextField(
                  controller: service_area,
                  hintText: "Service Area",
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
                  bool status = await VehicleRentServices().addRecord(
                      username.text.trim(),
                      aadhar_number.text.trim(),
                      email.text.trim(),
                      phone.text.trim(),
                      date_of_birth.text.trim(),
                      gender.text.trim(),
                      description.text.trim(),
                      street_address.text.trim(),
                      city.text.trim(),
                      state.text.trim(),
                      country.text.trim(),
                      zip.text.trim(),
                      pricing_model.text.trim(),
                      price.text.trim(),
                      open_from.text.trim(),
                      open_to.text.trim(),
                      open_time.text.trim(),
                      closing_time.text.trim(),
                      service_area.text.trim(),
                      photo_url.text.trim());
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
