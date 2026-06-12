import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/campus_model.dart';
import '../../services/campus_service.dart';

class ManageCampusesScreen
    extends StatefulWidget {
  const ManageCampusesScreen({
    super.key,
  });

  @override
  State<ManageCampusesScreen>
      createState() =>
          _ManageCampusesScreenState();
}

class _ManageCampusesScreenState
    extends State<
        ManageCampusesScreen> {

  final nameController =
      TextEditingController();

  final locationController =
      TextEditingController();

  final countryController =
      TextEditingController();

  final rankingController =
      TextEditingController();

  final foundedController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  File? imageFile;

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
        await ImagePicker()
            .pickImage(
      source:
          ImageSource.gallery,
    );

    if (image != null) {

      setState(() {
        imageFile =
            File(image.path);
      });
    }
  }

  Future<void> addCampus()
  async {

    CampusModel campus =
        CampusModel(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),

      name:
          nameController.text,

      image:
          "",

      location:
          locationController.text,

      country:
          countryController.text,

      rating: 5,

      verified: true,

      description:
          descriptionController.text,

      history:
          "Campus History",

      foundedYear:
          foundedController.text,

      worldRanking:
          rankingController.text,

      achievements: [],

      programs: [],
    );

    await CampusService()
        .addCampus(
      campus,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      const SnackBar(
        content: Text(
          "Campus Added Successfully",
        ),
      ),
    );

    nameController.clear();
    locationController.clear();
    countryController.clear();
    rankingController.clear();
    foundedController.clear();
    descriptionController.clear();

    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(
      backgroundColor:
          const Color(
        0xffF8FAFC,
      ),

      appBar: AppBar(
        title:
            const Text(
          "Manage Campuses",
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

              child: Container(
                height: 180,

                width:
                    double.infinity,

                decoration:
                    BoxDecoration(
                  color:
                      Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),

                child: imageFile ==
                        null
                    ? const Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [

                          Icon(
                            Icons.image,
                            size: 60,
                          ),

                          SizedBox(
                            height:
                                10,
                          ),

                          Text(
                            "Upload Campus Image",
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                        child:
                            Image.file(
                          imageFile!,
                          fit: BoxFit
                              .cover,
                        ),
                      ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            _field(
              controller:
                  nameController,
              hint:
                  "Campus Name",
            ),

            _field(
              controller:
                  locationController,
              hint:
                  "Location",
            ),

            _field(
              controller:
                  countryController,
              hint:
                  "Country",
            ),

            _field(
              controller:
                  rankingController,
              hint:
                  "World Ranking",
            ),

            _field(
              controller:
                  foundedController,
              hint:
                  "Founded Year",
            ),

            _field(
              controller:
                  descriptionController,
              hint:
                  "Description",
              maxLines: 4,
            ),

            const SizedBox(
              height: 20,
            ),

            SizedBox(
              width:
                  double.infinity,

              height: 55,

              child:
                  ElevatedButton(
                onPressed:
                    addCampus,

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(
                    0xff2563EB,
                  ),
                ),

                child: Text(
                  "Add Campus",

                  style:
                      GoogleFonts
                          .poppins(
                    color:
                        Colors.white,
                    fontWeight:
                        FontWeight
                            .bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController
        controller,
    required String hint,
    int maxLines = 1,
  }) {

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 15,
      ),

      child: TextField(
        controller:
            controller,

        maxLines:
            maxLines,

        decoration:
            InputDecoration(
          hintText:
              hint,

          filled: true,

          fillColor:
              Colors.white,

          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
              15,
            ),
          ),
        ),
      ),
    );
  }
}