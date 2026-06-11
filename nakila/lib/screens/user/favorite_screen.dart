import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nakila/models/campus_model.dart';

import '../../services/favorite_service.dart';
import '../../services/campus_service.dart';

import '../../widgets/campus_card.dart';

import 'campus_detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    super.key,
  });

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
          "Favorite Campuses",

          style:
              GoogleFonts.poppins(
            color: Colors.black,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: StreamBuilder<
          QuerySnapshot>(
        stream:
            FavoriteService()
                .getFavorites(),

        builder:
            (context, snapshot) {

          if (!snapshot.hasData) {

            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          final docs =
              snapshot.data!.docs;

          if (docs.isEmpty) {

            return Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center,

                children: [

                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors
                        .grey
                        .shade400,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Text(
                    "No Favorites Yet",

                    style:
                        GoogleFonts
                            .poppins(
                      fontSize: 22,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Start adding campuses to your favorites.",

                    textAlign:
                        TextAlign.center,

                    style:
                        GoogleFonts
                            .poppins(
                      color:
                          Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding:
                const EdgeInsets
                    .all(20),

            child: ListView.builder(
  itemCount: docs.length,

  itemBuilder:
      (context, index) {

                final campusId =
                    docs[index]
                        ["campusId"];

                final campus =
                    CampusService
                        .getCampusById(
                  campusId,
                );

                return CampusCard(
  campus: CampusModel(
    id: campus.id,
    name: campus.name,
    image: campus.image,
    location: campus.location,
    country: campus.country,
    rating: campus.rating,
    verified: campus.verified,
    description: campus.description,
    history: campus.history,
    foundedYear: campus.foundedYear,
    worldRanking: campus.worldRanking,
    achievements: campus.achievements,
    programs: campus.programs,

    isFavorite: true,
  ),

                  onTap: () {

                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                            CampusDetailScreen(
                          campus:
                              campus,
                        ),
                      ),
                    );
                  },

                  onFavoriteTap:
                      () async {

                    await FavoriteService()
                        .toggleFavorite(
                      campus.id,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}