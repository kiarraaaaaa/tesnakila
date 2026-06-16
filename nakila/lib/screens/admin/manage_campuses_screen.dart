import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_campus_screen.dart';
import '../../models/campus_model.dart';
import '../../services/campus_service.dart';
import 'add_campus_screen.dart';
import 'dart:convert';

class ManageCampusesScreen extends StatefulWidget {
  const ManageCampusesScreen({
    super.key,
  });

  @override
  State<ManageCampusesScreen> createState() =>
      _ManageCampusesScreenState();
}

class _ManageCampusesScreenState
    extends State<ManageCampusesScreen> {

  String searchText = "";

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
          "Manage Campuses",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        backgroundColor:
            const Color(
          0xff2563EB,
        ),

        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddCampusScreen(),
            ),
          );
        },

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: Column(
        children: [

          Padding(
            padding:
                const EdgeInsets.all(
              20,
            ),

            child: TextField(
              onChanged: (
                value,
              ) {

                setState(() {

                  searchText =
                      value
                          .toLowerCase();
                });
              },

              decoration:
                  InputDecoration(
                hintText:
                    "Search Campus",

                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

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
          ),

          Expanded(
            child: StreamBuilder<
                QuerySnapshot<
                    Map<String,
                        dynamic>>>(
              stream:
                  CampusService()
                      .getCampuses(),

              builder:
                  (
                context,
                snapshot,
              ) {

                if (!snapshot
                    .hasData) {

                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                final docs =
                    snapshot
                        .data!
                        .docs;

                final campuses =
                    docs
                        .map(
                          (
                            e,
                          ) =>
                              CampusModel.fromMap(
                            e.data(),
                          ),
                        )
                        .where(
                          (
                            campus,
                          ) {

                            return campus
                                .name
                                .toLowerCase()
                                .contains(
                                  searchText,
                                );
                          },
                        )
                        .toList();

                if (campuses
                    .isEmpty) {

                  return const Center(
                    child: Text(
                      "No Campus Found",
                    ),
                  );
                }

                return LayoutBuilder(
                  builder:
                      (
                    context,
                    constraints,
                  ) {

                    final isDesktop =
                        constraints
                                .maxWidth >
                            900;

                    return GridView
                        .builder(
                      padding:
                          const EdgeInsets
                              .all(
                        20,
                      ),

                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            isDesktop
                                ? 3
                                : 1,

                        childAspectRatio:
                            isDesktop
                                ? 0.85
                                : 0.95,

                        crossAxisSpacing:
                            15,

                        mainAxisSpacing:
                            15,
                      ),

                      itemCount:
                          campuses
                              .length,

                      itemBuilder:
                          (
                        context,
                        index,
                      ) {

                        final campus =
                            campuses[
                                index];

                        return Container(
                          padding:
                              const EdgeInsets
                                  .all(
                            16,
                          ),

                          decoration: BoxDecoration(
  color: Colors.white,

  borderRadius:
      BorderRadius.circular(20),

  boxShadow: [
    BoxShadow(
      color:
          Colors.black.withValues(
        alpha: .08,
      ),
      blurRadius: 15,
      offset:
          const Offset(0, 5),
    ),
  ],
),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [
                              ClipRRect(
  borderRadius:
      BorderRadius.circular(
    15,
  ),

  child:
      campus.image.isEmpty

          ? Container(
              height: 140,
              color:
                  Colors.grey.shade200,

              child:
                  const Center(
                child: Icon(
                  Icons.image,
                  size: 50,
                ),
              ),
            )

          : campus.image.startsWith(
              "assets/",
            )

              ? Image.asset(
                  campus.image,
                  height: 140,
                  width:
                      double.infinity,
                  fit: BoxFit.cover,
                )

              : Image.memory(
                  base64Decode(
                    campus.image,
                  ),
                  height: 140,
                  width:
                      double.infinity,
                  fit: BoxFit.cover,
                ),
),

const SizedBox(
  height: 12,
),

                              Text(
                                campus.name,

                                maxLines:
                                    1,

                                overflow:
                                    TextOverflow.ellipsis,

                                style:
                                    GoogleFonts.poppins(
                                  fontSize:
                                      18,

                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(
                                height:
                                    8,
                              ),

                              Text(
                                "${campus.location}, ${campus.country}",
                              ),
const SizedBox(
  height: 8,
),

Container(
  padding:
      const EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 5,
  ),

  decoration: BoxDecoration(
    color:
        const Color(
      0xffEFF6FF,
    ),

    borderRadius:
        BorderRadius.circular(
      12,
    ),
  ),

  child: Text(
    campus.worldRanking,

    style:
        GoogleFonts.poppins(
      color:
          const Color(
        0xff2563EB,
      ),
      fontWeight:
          FontWeight.bold,
    ),
  ),
),
                              const Spacer(),

                              Row(
                                children: [

                                 Expanded(
  child:
      ElevatedButton.icon(
  icon: const Icon(
    Icons.edit,
  ),

  label: const Text(
    "Edit",
  ),
    onPressed: () {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              EditCampusScreen(
            campus: campus,
          ),
        ),
      );
    },

    
    
  ),
),

                                  const SizedBox(
                                    width:
                                        10,
                                  ),

                                  Expanded(
                                    child:
                                        ElevatedButton.icon(
  icon: const Icon(
    Icons.delete,
  ),

  label: const Text(
    "Delete",
  ),

                                      onPressed:
                                          () async {

                                        final confirm =
                                            await showDialog<bool>(
                                          context:
                                              context,

                                          builder:
                                              (
                                            context,
                                          ) {

                                            return AlertDialog(
                                              title:
                                                  const Text(
                                                "Delete Campus",
                                              ),

                                              content:
                                                  Text(
                                                "Delete ${campus.name} ?",
                                              ),

                                              actions: [

                                                TextButton(
                                                  onPressed:
                                                      () {

                                                    Navigator.pop(
                                                      context,
                                                      false,
                                                    );
                                                  },

                                                  child:
                                                      const Text(
                                                    "Cancel",
                                                  ),
                                                ),

                                                TextButton(
                                                  onPressed:
                                                      () {

                                                    Navigator.pop(
                                                      context,
                                                      true,
                                                    );
                                                  },

                                                  child:
                                                      const Text(
                                                    "Delete",
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        if (confirm ==
                                            true) {

                                          await CampusService()
                                              .deleteCampus(
                                            campus.id,
                                          );
                                        }
                                      },

                                     
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}