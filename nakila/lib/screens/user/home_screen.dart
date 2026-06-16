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
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/campus_service.dart';

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

  String currentLocation =
    "Location not detected";
  
  String searchQuery = "";

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
        print(
  user["profileUrl"],
);
      return CustomSidebar(
        userName:
            user["name"] ?? "",

        role:
            user["role"] == "admin"
                ? "System Administrator"
                : "Student",

        profileImage:
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

  onChanged: (value) {

    setState(() {
      searchQuery =
          value.toLowerCase();
    });
  },
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

                         StreamBuilder<
    QuerySnapshot<
        Map<String, dynamic>>>(
  stream:
      CampusService()
          .getCampuses(),

  builder:
      (
    context,
    snapshot,
  ) {

    if (!snapshot.hasData) {

      return const Center(
        child:
            CircularProgressIndicator(),
      );
    }

    final campuses =
    snapshot.data!.docs
        .map(
          (e) =>
              CampusModel.fromMap(
            e.data(),
          ),
        )
        .where(
          (campus) {

            return campus.name
                .toLowerCase()
                .contains(
                  searchQuery,
                );
          },
        )
        .toList();
    return StreamBuilder<
    QuerySnapshot>(
  stream:
      FavoriteService()
          .getFavorites(),

  builder:
      (
    context,
    favoriteSnapshot,
  ) {

    if (!favoriteSnapshot
        .hasData) {

      return const Center(
        child:
            CircularProgressIndicator(),
      );
    }

    final favoriteIds =
        favoriteSnapshot
            .data!
            .docs
            .map(
              (e) =>
                  e["campusId"]
                      as String,
            )
            .toList();

    return Wrap(
      spacing: 20,
      runSpacing: 20,

      children:
          campuses.map(
        (campus) {

          return CampusCard(
            campus: CampusModel(
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
      favoriteIds.contains(
    campus.id,
  ),
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
      ).toList(),
    );
  },
    );
  },
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