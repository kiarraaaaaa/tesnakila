import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/campus_model.dart';
import '../../widgets/campus_card.dart';
import 'campus_detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() =>
      _FavoriteScreenState();
}

class _FavoriteScreenState
    extends State<FavoriteScreen> {

  late List<CampusModel> favorites;

  @override
  void initState() {
    super.initState();

    favorites = [
      CampusModel(
        id: "harvard",

        name:
            "Harvard University",

        image:
            "assets/Additional/Harvard.png",

        location:
            "Cambridge",

        country:
            "United States",

        rating: 4.9,

        verified: true,

        foundedYear:
            "1636",

        worldRanking:
            "#4",

        description:
            "Harvard University is one of the most prestigious universities in the world.",

        history:
            "Founded in 1636, Harvard is the oldest institution of higher education in the United States.",

        achievements: [
          "161 Nobel Prize Winners",
          "8 US Presidents",
          "Global Research Excellence",
        ],

        programs: [
          "Business",
          "Law",
          "Medicine",
          "Engineering",
        ],

        isFavorite: true,
      ),
    ];
  }

  void removeFavorite(
    CampusModel campus,
  ) {

    setState(() {
      favorites.removeWhere(
        (item) =>
            item.id ==
            campus.id,
      );
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          "${campus.name} removed from favorites",
        ),
      ),
    );
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
          "Favorite Campuses",

          style:
              GoogleFonts.poppins(
            color: Colors.black,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: favorites.isEmpty

          ? Center(
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
            )

          : Padding(
              padding:
                  const EdgeInsets
                      .all(20),

              child: GridView.builder(
                itemCount:
                    favorites.length,

                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      1,

                  childAspectRatio:
                      0.9,
                ),

                itemBuilder:
                    (
                  context,
                  index,
                ) {

                  final campus =
                      favorites[
                          index];

                  return CampusCard(
                    campus:
                        campus,

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

                    onFavoriteTap: () {
                      removeFavorite(
                        campus,
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}