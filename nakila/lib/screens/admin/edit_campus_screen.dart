import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(
      text: widget.campus.name,
    );

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

    historyController =
        TextEditingController(
      text: widget.campus.history,
    );
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
          widget.campus.image,

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
          widget.campus.achievements,

      programs:
          widget.campus.programs,

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