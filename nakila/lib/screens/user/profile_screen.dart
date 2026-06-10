import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  File? profileImage;

  final nameController =
      TextEditingController(
    text: "Handy",
  );

  final emailController =
      TextEditingController(
    text: "handy@gmail.com",
  );

  Future<void> pickImage() async {

    final picker = ImagePicker();

    final image =
        await picker.pickImage(
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
                        profileImage !=
                                null
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
                  "Handy",

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
              "Student",

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
                        .withOpacity(
                      .05,
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
                      onPressed: () {

                        ScaffoldMessenger
                                .of(
                          context,
                        )
                            .showSnackBar(
                          const SnackBar(
                            content:
                                Text(
                              "Profile Updated",
                            ),
                          ),
                        );
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