import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UploadProfileImage extends StatefulWidget {
  const UploadProfileImage({super.key});

  @override
  State<UploadProfileImage> createState() => _UploadProfileImageState();
}

class _UploadProfileImageState extends State<UploadProfileImage> {
  final ImagePicker _picker = ImagePicker();
  bool isUploading = false;

  Future<void> pickAndUploadImage() async {
    try {
      // Pick image
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        debugPrint("❌ No image selected");
        return; // stop here to avoid null errors
      }

      File file = File(pickedFile.path);

      // Start upload
      setState(() => isUploading = true);

      final storageRef = FirebaseStorage.instance
          .ref()
          .child("profile_images")
          .child("${FirebaseAuth.instance.currentUser!.uid}.jpg");

      await storageRef.putFile(file);

      String downloadUrl = await storageRef.getDownloadURL();
      debugPrint("✅ Image uploaded: $downloadUrl");

      setState(() => isUploading = false);
    } catch (e) {
      debugPrint("⚠️ Upload failed: $e");
      setState(() => isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Profile Image")),
      body: Center(
        child: isUploading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: pickAndUploadImage,
                child: const Text("Select & Upload"),
              ),
      ),
    );
  }
}
