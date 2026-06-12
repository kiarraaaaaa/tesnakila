import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/user_service.dart';
import '../../models/campus_model.dart';
import '../../widgets/campus_card.dart';
import '../../widgets/custom_sidebar.dart';
import 'package:geolocator/geolocator.dart';
import 'about_screen.dart';
import 'campus_detail_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';
import '../../services/favorite_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  final TextEditingController
      searchController =
      TextEditingController();

  late List<CampusModel> campuses;
  String currentLocation =
    "Location not detected";
  
  Future<void> loadFavorites() async {

  final favorites =
      await FavoriteService()
          .getFavorites()
          .first;

  final favoriteIds =
      favorites.docs
          .map(
            (e) => e["campusId"] as String,
          )
          .toList();

  setState(() {

    campuses =
        campuses.map((campus) {

      return CampusModel(
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

        isFavorite:
            favoriteIds.contains(
          campus.id,
        ),
      );
    }).toList();
  });
}

  Future<void> getCurrentLocation() async {

  try {

    LocationPermission permission =
        await Geolocator
            .requestPermission();

    if (permission ==
            LocationPermission.denied ||
        permission ==
            LocationPermission
                .deniedForever) {

      return;
    }

    Position position =
        await Geolocator
            .getCurrentPosition();

    setState(() {

      currentLocation =
          "${position.latitude.toStringAsFixed(4)}, "
          "${position.longitude.toStringAsFixed(4)}";
    });

  } catch (e) {

    debugPrint(
      "LOCATION ERROR: $e",
    );
  }
} 


  @override
  void initState() {
    super.initState();

    campuses = [

      CampusModel(
        id: "harvard",

        name:
            "Harvard University",

        image:
            "assets/Additional/Harvard.jpg",

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
          "Medicine",
          "Law",
          "Engineering",
        ],
      ),

      CampusModel(
        id: "oxford",

        name:
            "University of Oxford",

        image:
            "assets/Additional/Oxford.jpg",

        location:
            "Oxford",

        country:
            "United Kingdom",

        rating: 4.9,

        verified: true,

        foundedYear:
            "1096",

        worldRanking:
            "#1",

        description:
            "The University of Oxford is the oldest university in the English-speaking world.",

        history:
            "Oxford has been teaching students since 1096 and is known for academic excellence.",

        achievements: [
          "Numerous Nobel Laureates",
          "World Leading Research",
          "Top Global Ranking",
        ],

        programs: [
          "Philosophy",
          "Law",
          "Medicine",
          "Economics",
        ],
      ),

      CampusModel(
        id: "stanford",

        name:
            "Stanford University",

        image:
            "assets/Additional/Stanford.jpg",

        location:
            "California",

        country:
            "United States",

        rating: 4.8,

        verified: true,

        foundedYear:
            "1885",

        worldRanking:
            "#3",

        description:
            "Stanford is recognized globally for innovation and technology leadership.",

        history:
            "Founded in 1885, Stanford became one of the world's top research universities.",

        achievements: [
          "Google Founders",
          "Nobel Prize Winners",
          "Innovation Leadership",
        ],

        programs: [
          "Computer Science",
          "Business",
          "Engineering",
          "Medicine",
        ],
      ),
    ];
    loadFavorites();
  }

  void openScreen(int index) {

    switch (index) {

      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const FavoriteScreen(),
          ),
        );
        break;

      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const ProfileScreen(),
          ),
        );
        break;

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const AboutScreen(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    bool desktop =
        MediaQuery.of(context)
                .size
                .width >
            900;

    return Scaffold(
      backgroundColor:
          const Color(0xffF8FAFC),

      body: Row(
        children: [

          if (desktop)
  StreamBuilder(
    stream: UserService().getCurrentUser(),
    builder: (context, snapshot) {

      if (!snapshot.hasData) {
        return const SizedBox();
      }

      final user =
          snapshot.data!.data()!;

      return CustomSidebar(
        userName:
            user["name"] ?? "",

        role:
            user["role"] == "admin"
                ? "System Administrator"
                : "Student",

        profileImage:
            user["photoUrl"] ??
                user["photoUrl"] ?? "",

        selectedIndex: 0,

        onItemTap: openScreen,
      );
    },
  ),

  
          Expanded(
            child: SafeArea(
              child: Column(
                children: [

                  if (!desktop)

                    Container(
                      padding:
                          const EdgeInsets
                              .all(15),

                      child: Row(
                        children: [

                          Builder(
                            builder: (context) {

                              return IconButton(
  onPressed: () {

    Scaffold.of(
      context,
    ).openDrawer();
  },

  icon: const Icon(
    Icons.menu,
  ),
                              );
                            },
                          ),

                          Text(
                            "NAKILA",

                            style:
                                GoogleFonts
                                    .poppins(
                              fontWeight:
                                  FontWeight
                                      .bold,
                              fontSize:
                                  20,
                            ),
                          ),
                        ],
                      ),
                    ),

                  Expanded(
                    child:
                        SingleChildScrollView(
                      padding:
                          const EdgeInsets
                              .all(25),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Text(
                            "Discover Your Dream University",

                            style:
                                GoogleFonts
                                    .poppins(
                              fontSize:
                                  30,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Text(
                            "Explore the world's best universities.",

                            style:
                                GoogleFonts
                                    .poppins(
                              color:
                                  Colors.grey,
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          Container(
                            padding:
                                const EdgeInsets
                                    .all(18),

                            decoration:
                                BoxDecoration(
                              color:
                                  Colors.white,

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                20,
                              ),
                            ),

                            child: Row(
                              children: [

                                const Icon(
                                  Icons
                                      .location_on,
                                  color:
                                      Colors
                                          .blue,
                                ),

                                const SizedBox(
                                  width:
                                      10,
                                ),

                                Expanded(
                                  child:
                                      Text(
                                    currentLocation ==
        "Location not detected"

    ? "Allow location access to discover universities around you."

    : "Current Location: $currentLocation",

                                    style:
                                        GoogleFonts.poppins(),
                                  ),
                                ),

                                ElevatedButton(
  onPressed: getCurrentLocation,

  child: const Text(
    "Allow",
  ),
),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          TextField(
                            controller:
                                searchController,

                            decoration:
                                InputDecoration(
                              hintText:
                                  "Search University",

                              prefixIcon:
                                  const Icon(
                                Icons
                                    .search,
                              ),

                              filled:
                                  true,

                              fillColor:
                                  Colors.white,

                              border:
                                  OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  18,
                                ),
                                borderSide:
                                    BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          Text(
                            "Featured Universities",

                            style:
                                GoogleFonts
                                    .poppins(
                              fontWeight:
                                  FontWeight
                                      .bold,
                              fontSize:
                                  24,
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Wrap(
                            spacing: 20,
                            runSpacing: 20,

                            children: campuses
                                .map(
                                  (
                                    campus,
                                  ) {

                                    return CampusCard(
                                      campus:
                                          campus,

                                      onTap:
                                          () {

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) =>
                                                    CampusDetailScreen(
                                              campus:
                                                  campus,
                                            ),
                                          ),
                                        );
                                      },

                                      onFavoriteTap: () async {

  await FavoriteService()
      .toggleFavorite(
    campus.id,
  );

  setState(() {

    final index =
        campuses.indexWhere(
      (e) => e.id == campus.id,
    );

    if (index != -1) {

      campuses[index] =
          CampusModel(
        id: campus.id,
        name: campus.name,
        image: campus.image,
        location: campus.location,
        country: campus.country,
        rating: campus.rating,
        verified: campus.verified,
        description:
            campus.description,
        history:
            campus.history,
        foundedYear:
            campus.foundedYear,
        worldRanking:
            campus.worldRanking,
        achievements:
            campus.achievements,
        programs:
            campus.programs,

        isFavorite:
            !campus.isFavorite,
      );
    }
  });
},
                                    );
                                  },
                                )
                                .toList(),
                        
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
    }