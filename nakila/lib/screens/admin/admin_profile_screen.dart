import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() =>
      _AdminProfileScreenState();
}

class _AdminProfileScreenState
    extends State<AdminProfileScreen> {

  Uint8List? imageBytes;

  final nameController =
      TextEditingController(
    text: "Administrator",
  );

  final emailController =
      TextEditingController(
    text: "admin@nakila.com",
  );

  Future<void> Future<void> pickImage() async {

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
} async {

    final image =
        await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {

      setState(() {
        profileImage =
            File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xffF8FAFC),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Admin Profile",
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
                    radius: 70,

                    backgroundImage:
                        profileImage != null
                            ? FileImage(
                                profileImage!,
                              )
                            : const AssetImage(
                                    "assets/Additional/Profile.png",
                                  )
                                as ImageProvider,
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,

                    child: Container(
                      padding:
                          const EdgeInsets
                              .all(10),

                      decoration:
                          const BoxDecoration(
                        color:
                            Color(
                          0xff2563EB,
                        ),
                        shape:
                            BoxShape.circle,
                      ),

                      child:
                          const Icon(
                        Icons.camera_alt,
                        color:
                            Colors.white,
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
                  "Administrator",

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
                  width: 5,
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
              "Super Admin",

              style:
                  GoogleFonts
                      .poppins(
                color:
                    Colors.grey,
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
                    BorderRadius.circular(
                  25,
                ),
              ),

              child: Column(
                children: [

                  TextField(
                    controller:
                        nameController,

                    decoration:
                        InputDecoration(
                      labelText:
                          "Admin Name",

                      prefixIcon:
                          const Icon(
                        Icons.person,
                      ),

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          15,
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
                          15,
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
                      onPressed:
                          () {

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Admin Profile Updated",
                            ),
                          ),
                        );
                      },

                      style:
                          ElevatedButton.styleFrom(
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
                              FontWeight.bold,
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

            Container(
              width:
                  double.infinity,

              padding:
                  const EdgeInsets.all(
                20,
              ),

              decoration:
                  BoxDecoration(
                color:
                    Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  25,
                ),
              ),

              child: Column(
                children: [

                  const Icon(
                    Icons.admin_panel_settings,
                    color:
                        Colors.blue,
                    size: 50,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "NAKILA Administration",

                    style:
                        GoogleFonts
                            .poppins(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Manage campuses, reviews, users and application settings from this dashboard.",

                    textAlign:
                        TextAlign.center,

                    style:
                        GoogleFonts
                            .poppins(
                      color:
                          Colors.grey,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}