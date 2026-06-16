
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:typed_data';
import '../../models/campus_model.dart';
import '../../services/campus_service.dart';

class AddCampusScreen
    extends StatefulWidget {
  const AddCampusScreen({
    super.key,
  });

  @override
  State<AddCampusScreen>
      createState() =>
          _AddCampusScreenState();
}

class _AddCampusScreenState
    extends State<
        AddCampusScreen> {

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
  
  final historyController =
    TextEditingController();

final achievementController =
    TextEditingController();

final programController =
    TextEditingController();

  Uint8List? imageBytes;
  String imageBase64 = "";
  List<String> achievements = [];
  List<String> programs = [];
  
  Future<void> pickImage() async {

  final image =
      await ImagePicker()
          .pickImage(
    source: ImageSource.gallery,
  );

 if (image != null) {

  imageBytes =
      await image.readAsBytes();

  imageBase64 =
      base64Encode(
    imageBytes!,
  );

  print(
    "Image loaded: ${imageBytes!.length}",
  );

  setState(() {});
 }
  }

  Future<void> addCampus()
  async {

    CampusModel campus =
        CampusModel(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),

      history:
    historyController.text,

foundedYear:
    foundedController.text,

worldRanking:
    rankingController.text,


achievements:
    achievements,

programs:
    programs,

      name:
          nameController.text,

      image: imageBase64,

      location:
          locationController.text,

      country:
          countryController.text,

      rating: 5,

      verified: true,

      description:
          descriptionController.text,

    
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
historyController.clear();

achievementController.clear();

programController.clear();

achievements.clear();

programs.clear();

    setState(() {
      imageBytes = null;
      imageBase64 = "";
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

                child: imageBytes ==
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

    child: Image.memory(
  imageBytes!,
  fit: BoxFit.cover,
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
            _field(
  controller:
      historyController,
  hint:
      "History",
  maxLines: 5,
),

Text(
  "Achievements",
  style: GoogleFonts.poppins(
    fontWeight:
        FontWeight.bold,
    fontSize: 16,
  ),
),

const SizedBox(
  height: 10,
),

_field(
  controller:
      achievementController,
  hint:
      "Achievement",
),

SizedBox(
  width: double.infinity,

  child: ElevatedButton(
    onPressed: () {

      if (achievementController
          .text
          .trim()
          .isEmpty) {
        return;
      }

      setState(() {

        achievements.add(
          achievementController.text,
        );

        achievementController.clear();
      });
    },

    child: const Text(
      "Add Achievement",
    ),
  ),
),

const SizedBox(
  height: 10,
),

Wrap(
  spacing: 8,
  runSpacing: 8,

  children:
      achievements
          .map(
            (e) => Chip(
              label: Text(
                e,
              ),

              onDeleted: () {

                setState(() {

                  achievements.remove(
                    e,
                  );
                });
              },
            ),
          )
          .toList(),
),
const SizedBox(
  height: 20,
),

Text(
  "Programs",
  style: GoogleFonts.poppins(
    fontWeight:
        FontWeight.bold,
    fontSize: 16,
  ),
),

const SizedBox(
  height: 10,
),

_field(
  controller:
      programController,
  hint:
      "Program",
),

SizedBox(
  width: double.infinity,

  child: ElevatedButton(
    onPressed: () {

      if (programController
          .text
          .trim()
          .isEmpty) {
        return;
      }

      setState(() {

        programs.add(
          programController.text,
        );

        programController.clear();
      });
    },

    child: const Text(
      "Add Program",
    ),
  ),
),

const SizedBox(
  height: 10,
),

Wrap(
  spacing: 8,
  runSpacing: 8,

  children:
      programs
          .map(
            (e) => Chip(
              label: Text(
                e,
              ),

              onDeleted: () {

                setState(() {

                  programs.remove(
                    e,
                  );
                });
              },
            ),
          )
          .toList(),
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