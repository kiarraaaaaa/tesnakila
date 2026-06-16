import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import '../../models/campus_model.dart';
import '../../services/campus_service.dart';

class EditCampusScreen extends StatefulWidget {
  final CampusModel campus;

  const EditCampusScreen({
    super.key,
    required this.campus,
  });

  @override
  State<EditCampusScreen> createState() =>
      _EditCampusScreenState();
}

class _EditCampusScreenState
    extends State<EditCampusScreen> {

  late TextEditingController nameController;
  late TextEditingController locationController;
  late TextEditingController countryController;
  late TextEditingController rankingController;
  late TextEditingController foundedController;
  late TextEditingController descriptionController;
  late TextEditingController historyController;

  bool isLoading = false;
  String imageBase64 = "";
  Uint8List? imageBytes;
  List<String> achievements = [];
List<String> programs = [];

final achievementController =
    TextEditingController();

final programController =
    TextEditingController();
    
  @override
  void initState() {
    super.initState();

    
    nameController =
        TextEditingController(
      text: widget.campus.name,
    );

    historyController =
    TextEditingController(
  text: widget.campus.history,
);

    if (
  widget.campus.image.isNotEmpty &&
  !widget.campus.image.startsWith(
    "assets/",
  )
) {

  imageBase64 =
      widget.campus.image;

  imageBytes =
      base64Decode(
    imageBase64,
  );
}

    locationController =
        TextEditingController(
      text: widget.campus.location,
    );

    countryController =
        TextEditingController(
      text: widget.campus.country,
    );

    rankingController =
        TextEditingController(
      text: widget.campus.worldRanking,
    );

    foundedController =
        TextEditingController(
      text: widget.campus.foundedYear,
    );

    descriptionController =
        TextEditingController(
      text: widget.campus.description,
    );
achievements =
    List<String>.from(
  widget.campus.achievements,
);

programs =
    List<String>.from(
  widget.campus.programs,
);
  }

  Future<void> pickImage() async {

  final image =
      await ImagePicker()
          .pickImage(
    source:
        ImageSource.gallery,
  );

  if (image != null) {

    imageBytes =
        await image.readAsBytes();

    imageBase64 =
        base64Encode(
      imageBytes!,
    );

    setState(() {});
  }
}

  Future<void> updateCampus() async {

    setState(() {
      isLoading = true;
    });

    final updatedCampus =
        CampusModel(
      id: widget.campus.id,

      name:
          nameController.text,

      image:
    imageBase64.isEmpty

        ? widget.campus.image

        : imageBase64,

      location:
          locationController.text,

      country:
          countryController.text,

      rating:
          widget.campus.rating,

      verified:
          widget.campus.verified,

      description:
          descriptionController.text,

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

      isFavorite:
          widget.campus.isFavorite,
    );

    await CampusService()
        .updateCampus(
      updatedCampus,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      const SnackBar(
        content: Text(
          "Campus Updated Successfully",
        ),
      ),
    );

    Navigator.pop(context);

    setState(() {
      isLoading = false;
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
        title: const Text(
          "Edit Campus",
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
    width: double.infinity,

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(
        20,
      ),
    ),

    child: imageBytes != null

        ? ClipRRect(
            borderRadius:
                BorderRadius.circular(
              20,
            ),

            child: Image.memory(
              imageBytes!,
              fit: BoxFit.cover,
            ),
          )

        : widget.campus.image.startsWith(
    "assets/",
  )

    ? ClipRRect(
        borderRadius:
            BorderRadius.circular(
          20,
        ),

        child: Image.asset(
          widget.campus.image,
          fit: BoxFit.cover,
        ),
      )

    : ClipRRect(
        borderRadius:
            BorderRadius.circular(
          20,
        ),

        child: Image.memory(
          base64Decode(
            widget.campus.image,
          ),
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
              maxLines: 5,
            ),

            _field(
              controller:
                  historyController,
              hint:
                  "History",
              maxLines: 6,
            ),
Text(
  "Achievements",
  style: GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),

const SizedBox(height: 10),

_field(
  controller: achievementController,
  hint: "Achievement",
),

SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      if (achievementController.text.trim().isEmpty) {
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

const SizedBox(height: 10),

Wrap(
  spacing: 8,
  runSpacing: 8,
  children: achievements
      .map(
        (e) => Chip(
          label: Text(e),
          onDeleted: () {
            setState(() {
              achievements.remove(e);
            });
          },
        ),
      )
      .toList(),
),

const SizedBox(height: 20),

Text(
  "Programs",
  style: GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),

const SizedBox(height: 10),

_field(
  controller: programController,
  hint: "Program",
),

SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      if (programController.text.trim().isEmpty) {
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

const SizedBox(height: 10),

Wrap(
  spacing: 8,
  runSpacing: 8,
  children: programs
      .map(
        (e) => Chip(
          label: Text(e),
          onDeleted: () {
            setState(() {
              programs.remove(e);
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
                    isLoading
                        ? null
                        : updateCampus,

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(
                    0xff2563EB,
                  ),
                ),

                child:
                    isLoading

                        ? const CircularProgressIndicator(
                            color:
                                Colors.white,
                          )

                        : Text(
                            "Update Campus",

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