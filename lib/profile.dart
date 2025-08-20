import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'edit_profile.dart';
import 'login.dart';
import 'landing_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic>? userData;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  /// Fetch user data from Firestore
  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists) {
        setState(() {
          userData = doc.data();
          profileImageUrl = userData?['profileImage'];
        });
      }
    }
  }

  /// Pick image from gallery and upload
  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery, // Opens gallery
      imageQuality: 75, // Compress image
    );

    if (pickedFile == null) return; // No image selected

    final file = File(pickedFile.path);
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Upload to Firebase Storage
        final ref = FirebaseStorage.instance.ref().child('profile_images/${user.uid}.jpg');
        await ref.putFile(file);

        // Get URL
        final url = await ref.getDownloadURL();

        // Save URL to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'profileImage': url,
        });

        // Update UI
        setState(() {
          profileImageUrl = url;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile picture updated successfully")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error uploading image: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 12, 11),
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile picture
                  GestureDetector(
                    onTap: pickAndUploadImage, // Click to pick image
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[800],
                      backgroundImage: profileImageUrl != null
                          ? NetworkImage(profileImageUrl!)
                          : null,
                      child: profileImageUrl == null
                          ? const Icon(Icons.camera_alt, color: Colors.white, size: 40)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // User details
                  infoTile(label: "Name", value: userData!['name'] ?? ''),
                  infoTile(label: "Email", value: FirebaseAuth.instance.currentUser?.email ?? ''),
                  infoTile(label: "Age", value: userData!['age']?.toString() ?? ''),
                  infoTile(label: "Gender", value: userData!['gender'] ?? ''),
                  infoTile(label: "Address", value: userData!['address'] ?? ''),
                  infoTile(label: "District", value: userData!['district'] ?? ''),

                  const SizedBox(height: 30),

                  // Logout Button
                  SizedBox(
                    width: screenWidth,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text('Logout', style: TextStyle(fontSize: 16, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const login()),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Edit Profile Button
                  SizedBox(
                    width: screenWidth,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditProfilePage()),
                        );
                        fetchUserData(); // Refresh after editing
                      },
                      child: const Text('Edit Profile', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: bottnavbar(currentIndex: 2),
    );
  }

  /// Widget to show label and value
  Widget infoTile({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            "$label:",
            style: const TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
