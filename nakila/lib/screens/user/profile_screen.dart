import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  String role = "";
  String photoUrl = "";
  Uint8List? imageBytes;

  final nameController =
    TextEditingController();

final emailController =
    TextEditingController();

  Future<void> pickImage() async {

  final image =
      await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
  );

  if (image != null) {

    imageBytes =
        await image.readAsBytes();

    setState(() {});
  }
}

@override
void initState() {
  super.initState();

  loadUserData();
}

Future<void> loadUserData() async {

  final uid =
      FirebaseAuth
          .instance
          .currentUser!
          .uid;

  final doc =
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();

  final data = doc.data();

  if (data != null) {

    setState(() {

      nameController.text =
          data["name"] ?? "";

      emailController.text =
          data["email"] ?? "";

      role =
          data["role"] ?? "user";

      photoUrl =
          data["photoUrl"] ?? "";
    });
  }
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(
        0xffF8FAFC,
      ),

      appBar: AppBar(
        backgroundColor:
            Colors.white,

        elevation: 0,

        centerTitle: true,

        title: Text(
          "Profile",

          style:
              GoogleFonts.poppins(
            color: Colors.black,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(
          20,
        ),

        child: Column(
          children: [

            GestureDetector(
              onTap: pickImage,

              child: Stack(
                children: [

                  CircleAvatar(
                    radius: 65,

                    backgroundColor:
                        Colors.white,

                   backgroundImage:

    imageBytes != null

        ? MemoryImage(
            imageBytes!,
          )

       : photoUrl.isNotEmpty
    ? MemoryImage(
        base64Decode(
          photoUrl,
        ),
      )
    : const AssetImage(
        "assets/Additional/Profile.png",
      ) as ImageProvider
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,

                    child: Container(
                      padding:
                          const EdgeInsets
                              .all(
                        8,
                      ),

                      decoration:
                          const BoxDecoration(
                        shape:
                            BoxShape.circle,

                        color:
                            Color(
                          0xff2563EB,
                        ),
                      ),

                      child:
                          const Icon(
                        Icons.camera_alt,
                        color:
                            Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .center,

              children: [

                Text(
  nameController.text,

                  style:
                      GoogleFonts
                          .poppins(
                    fontSize: 24,
                    fontWeight:
                        FontWeight
                            .bold,
                  ),
                ),

                const SizedBox(
                  width: 6,
                ),

                const Icon(
                  Icons.verified,
                  color: Colors.blue,
                ),
              ],
            ),

            const SizedBox(
              height: 5,
            ),

            Text(
              role == "admin"
      ? "System Administrator"
      : "Student",

              style:
                  GoogleFonts.poppins(
                color: Colors.grey,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            Container(
              padding:
                  const EdgeInsets.all(
                20,
              ),

              decoration:
                  BoxDecoration(
                color:
                    Colors.white,

                borderRadius:
                    BorderRadius
                        .circular(
                  24,
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors
                        .black
                        .withValues(
                      alpha: .05,
                    ),
                    blurRadius: 15,
                  ),
                ],
              ),

              child: Column(
                children: [

                  TextField(
                    controller:
                        nameController,

                    decoration:
                        InputDecoration(
                      labelText:
                          "Full Name",

                      prefixIcon:
                          const Icon(
                        Icons.person,
                      ),

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  TextField(
                    controller:
                        emailController,

                    readOnly: true,

                    decoration:
                        InputDecoration(
                      labelText:
                          "Email",

                      prefixIcon:
                          const Icon(
                        Icons.email,
                      ),

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  SizedBox(
                    width:
                        double.infinity,
                    height: 55,

                    child:
                        ElevatedButton(
                      onPressed: () async {

  final uid =
      FirebaseAuth
          .instance
          .currentUser!
          .uid;

String photoBase64 = photoUrl;

if (imageBytes != null) {
  photoBase64 =
      base64Encode(
        imageBytes!,
      );
}

await FirebaseFirestore.instance
    .collection("users")
    .doc(uid)
    .update({

  "name":
      nameController.text,

  "photoUrl":
      photoBase64,
});

  if (!mounted) return;

  ScaffoldMessenger.of(
    context,
  ).showSnackBar(

    const SnackBar(
      backgroundColor:
          Colors.green,

      content: Text(
        "Profile Updated Successfully",
      ),
    ),
  );

  await loadUserData();
},

                      style:
                          ElevatedButton
                              .styleFrom(
                        backgroundColor:
                            const Color(
                          0xff2563EB,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),
                      ),

                      child: Text(
                        "Save Changes",

                        style:
                            GoogleFonts
                                .poppins(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight
                                  .w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}