import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends State<AdminDashboardScreen> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    bool isDesktop =
        MediaQuery.of(context).size.width >
            1000;

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

                  const SizedBox(height: 20),

                  Container(
                    margin:
                        const EdgeInsets.all(
                      15,
                    ),

                    padding:
                        const EdgeInsets.all(
                      15,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.white
                              .withOpacity(
                        .08,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),

                    child: Row(
                      children: [

                        Container(
                          height: 55,
                          width: 55,

                          decoration:
                              BoxDecoration(
                            color:
                                Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                              15,
                            ),
                          ),

                          child:
                              const Icon(
                            Icons.school,
                            color:
                                Color(
                              0xff2563EB,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 12,
                        ),

                        Expanded(
                          child:
                              Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              Text(
                                "NAKILA",

                                style:
                                    GoogleFonts.poppins(
                                  color:
                                      Colors.white,
                                  fontSize:
                                      18,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              Text(
                                "Admin Panel",

                                style:
                                    GoogleFonts.poppins(
                                  color:
                                      Colors.white60,
                                  fontSize:
                                      12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                        onPressed:
                            () {},

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

                      _statCard(
                        "Campuses",
                        "12",
                        Icons.school,
                      ),

                      _statCard(
                        "Users",
                        "245",
                        Icons.people,
                      ),

                      _statCard(
                        "Reviews",
                        "524",
                        Icons.reviews,
                      ),

                      _statCard(
                        "Favorites",
                        "180",
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

                        ListTile(
                          leading:
                              const CircleAvatar(
                            child:
                                Icon(
                              Icons
                                  .school,
                            ),
                          ),

                          title:
                              const Text(
                            "Harvard Updated",
                          ),

                          subtitle:
                              const Text(
                            "2 minutes ago",
                          ),
                        ),

                        ListTile(
                          leading:
                              const CircleAvatar(
                            child:
                                Icon(
                              Icons
                                  .person,
                            ),
                          ),

                          title:
                              const Text(
                            "New User Registered",
                          ),

                          subtitle:
                              const Text(
                            "10 minutes ago",
                          ),
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
      },
    );
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
  ) {

    return Container(
      width: 240,

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          25,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Icon(
            icon,
            size: 35,
            color:
                const Color(
              0xff2563EB,
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          Text(
            value,

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
              color:
                  Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}