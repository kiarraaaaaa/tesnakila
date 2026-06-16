import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nakila/screens/auth/login_screen.dart';
import 'package:nakila/services/activity_service.dart';
import 'manage_campuses_screen.dart';
import 'manage_reviews_screen.dart';
import 'manage_users_screen.dart';
import 'admin_profile_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends State<AdminDashboardScreen> {

  int selectedIndex = 0;

  Widget _firestoreStatCard(
  String title,
  String collection,
  IconData icon,
) {

  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection(collection)
        .snapshots(),

    builder: (context, snapshot) {

      final count =
          snapshot.data?.docs.length ?? 0;

      return Container(
        width: 240,

        padding:
            const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(25),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Icon(
              icon,
              size: 35,
              color: const Color(
                0xff2563EB,
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            Text(
              count.toString(),

              style:
                  GoogleFonts.poppins(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            Text(
              title,

              style:
                  GoogleFonts.poppins(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
      backgroundColor:
          const Color(0xffF8FAFC),

      body: Row(
        children: [

          /// SIDEBAR
          Container(
            width: 270,

            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff0F172A),
                  Color(0xff172554),
                ],
              ),
            ),

            child: SafeArea(
              child: Column(
                children: [

                  const SizedBox(
  height: 20,
),

StreamBuilder<DocumentSnapshot>(
  stream: FirebaseFirestore
      .instance
      .collection("users")
      .doc(
        FirebaseAuth
            .instance
            .currentUser!
            .uid,
      )
      .snapshots(),

  builder: (context, snapshot) {

    final user =
        snapshot.data?.data()
            as Map<String, dynamic>?;

    return Container(
      margin:
          const EdgeInsets.all(15),

      padding:
          const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color:
            Colors.white.withValues(
          alpha: .08,
        ),
        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 28,

            backgroundImage:
                (user?["profileImage"] ??
                            "")
                        .toString()
                        .isNotEmpty

                    ? MemoryImage(
                        base64Decode(
                          user![
                              "profileImage"],
                        ),
                      )

                    : const AssetImage(
                            "assets/Additional/Profile.png",
                          )
                        as ImageProvider,
          ),

          const SizedBox(
            width: 12,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Row(
                  children: [

                    Expanded(
                      child: Text(
                        user?["name"] ??
                            "Admin",

                        overflow:
                            TextOverflow
                                .ellipsis,

                        style:
                            GoogleFonts.poppins(
                          color:
                              Colors.white,
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    const Icon(
                      Icons.verified,
                      color: Colors.blue,
                      size: 16,
                    ),
                  ],
                ),

                Text(
                  "System Administrator",

                  style:
                      GoogleFonts.poppins(
                    color:
                        Colors.white60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  },
),

const SizedBox(
  height: 20,
),
                  _menu(
                    0,
                    Icons.dashboard,
                    "Dashboard",
                  ),

                  _menu(
                    1,
                    Icons.school,
                    "Campuses",
                  ),

                  _menu(
                    2,
                    Icons.reviews,
                    "Reviews",
                  ),

                  _menu(
                    3,
                    Icons.people,
                    "Users",
                  ),

                  _menu(
                    4,
                    Icons.person,
                    "Profile",
                  ),

                  const Spacer(),

                  Padding(
                    padding:
                        const EdgeInsets
                            .all(15),

                    child:
                        SizedBox(
                      width:
                          double.infinity,

                      height: 50,

                      child:
                          ElevatedButton.icon(
                        onPressed: () async {

  await FirebaseAuth.instance
      .signOut();

  if (!context.mounted) return;

  Navigator.pushAndRemoveUntil(
    context,

    MaterialPageRoute(
      builder: (_) =>
          const LoginScreen(),
    ),

    (route) => false,
  );
},

                        icon:
                            const Icon(
                          Icons.logout,
                          color:
                              Colors.white,
                        ),

                        label:
                            const Text(
                          "Logout",
                        ),

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.red,
                          foregroundColor:
                              Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// CONTENT
          Expanded(
            child:
                SingleChildScrollView(
              padding:
                  const EdgeInsets.all(
                25,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(
                    "Welcome Admin 👋",

                    style:
                        GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    "Manage your campuses and users.",

                    style:
                        GoogleFonts.poppins(
                      color:
                          Colors.grey,
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  Wrap(
  spacing: 20,
  runSpacing: 20,

  children: [

    _firestoreStatCard(
      "Campuses",
      "campuses",
      Icons.school,
    ),

    _firestoreStatCard(
      "Users",
      "users",
      Icons.people,
    ),

    _firestoreStatCard(
      "Reviews",
      "reviews",
      Icons.reviews,
    ),

    _firestoreStatCard(
      "Favorites",
      "favorites",
      Icons.favorite,
    ),
  ],
),
                

                  const SizedBox(
                    height: 30,
                  ),

                  Container(
                    width:
                        double.infinity,

                    padding:
                        const EdgeInsets
                            .all(20),

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                        25,
                      ),
                    ),

                    child:
                        Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(
                          "Recent Activity",

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

                        const SizedBox(
                          height: 20,
                        ),

                     StreamBuilder<
    QuerySnapshot<
        Map<String, dynamic>>>(
  stream:
      ActivityService()
          .getActivities(),

  builder: (
    context,
    snapshot,
  ) {

    if (!snapshot.hasData) {
      return const Center(
        child:
            CircularProgressIndicator(),
      );
    }

    final docs =
        snapshot.data!.docs;

    return Column(
      children:
          docs.map((doc) {

        final data =
            doc.data();

        return ListTile(
          leading:
              const CircleAvatar(
            child: Icon(
              Icons.history,
            ),
          ),

          title: Text(
            data["title"] ?? "",
          ),

          subtitle: Text(
            data["type"] ?? "",
          ),
        );
      }).toList(),
    );
  },
),
                      ],
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

  Widget _menu(
    int index,
    IconData icon,
    String title,
  ) {

    bool selected =
        selectedIndex == index;

    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),

      title: Text(
        title,

        style:
            GoogleFonts.poppins(
          color: Colors.white,
        ),
      ),

      tileColor: selected
          ? Colors.blue
          : Colors.transparent,

      onTap: () {

  setState(() {
    selectedIndex = index;
  });

  if (index == 1) {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const ManageCampusesScreen(),
      ),
    );
  }

  if (index == 2) {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const ManageReviewsScreen(),
      ),
    );
  }

  if (index == 3) {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const ManageUsersScreen(),
      ),
    );
  }

  if (index == 4) {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const AdminProfileScreen(),
      ),
    );
  }
},
    );
  }
  }