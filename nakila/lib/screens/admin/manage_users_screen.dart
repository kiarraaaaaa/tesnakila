import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() =>
      _ManageUsersScreenState();
}

class _ManageUsersScreenState
    extends State<ManageUsersScreen> {

  final TextEditingController
      searchController =
      TextEditingController();

  String searchText = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xffF8FAFC),

      appBar: AppBar(
        title: const Text(
          "Manage Users",
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
              controller:
                  searchController,

              onChanged: (value) {
                setState(() {
                  searchText = value
                      .toLowerCase();
                });
              },

              decoration:
                  InputDecoration(
                hintText:
                    "Search User",

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
                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder<
                QuerySnapshot>(
              stream:
                  FirebaseFirestore
                      .instance
                      .collection(
                        "users",
                      )
                      .snapshots(),

              builder: (
                context,
                snapshot,
              ) {

                if (snapshot
                        .connectionState ==
                    ConnectionState
                        .waiting) {

                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                if (!snapshot
                    .hasData) {

                  return const Center(
                    child: Text(
                      "No Users Found",
                    ),
                  );
                }

                final users =
                    snapshot
                        .data!
                        .docs
                        .where((doc) {

                  final data =
                      doc.data()
                          as Map<
                              String,
                              dynamic>;

                  final name =
                      (data["name"] ??
                              "")
                          .toString()
                          .toLowerCase();

                  return name
                      .contains(
                    searchText,
                  );
                }).toList();

                return ListView.builder(
                  padding:
                      const EdgeInsets
                          .all(
                    20,
                  ),

                  itemCount:
                      users.length,

                  itemBuilder:
                      (
                    context,
                    index,
                  ) {

                    final data =
                        users[index]
                                .data()
                            as Map<
                                String,
                                dynamic>;

                    return Container(
                      margin:
                          const EdgeInsets.only(
                        bottom:
                            15,
                      ),

                      padding:
                          const EdgeInsets.all(
                        16,
                      ),

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors
                                .black
                                .withValues(
                              alpha: .05,
                            ),
                            blurRadius:
                                12,
                          ),
                        ],
                      ),

                      child: Row(
                        children: [

                          CircleAvatar(
                            radius:
                                28,

                            backgroundColor:
                                Colors
                                    .blue
                                    .shade100,

                            child:
                                const Icon(
                              Icons
                                  .person,
                            ),
                          ),

                          const SizedBox(
                            width:
                                15,
                          ),

                          Expanded(
                            child:
                                Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                Row(
                                  children: [

                                    Expanded(
                                      child:
                                          Text(
                                        data["name"] ??
                                            "",

                                        overflow:
                                            TextOverflow.ellipsis,

                                        style:
                                            GoogleFonts.poppins(
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    const Icon(
                                      Icons
                                          .verified,
                                      color:
                                          Colors.blue,
                                      size:
                                          18,
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height:
                                      5,
                                ),

                                Text(
                                  data["email"] ??
                                      "",

                                  style:
                                      GoogleFonts.poppins(
                                    color:
                                        Colors.grey,
                                  ),
                                ),

                                const SizedBox(
                                  height:
                                      5,
                                ),

                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal:
                                        10,
                                    vertical:
                                        5,
                                  ),

                                  decoration:
                                      BoxDecoration(
                                    color:
                                        const Color(
                                      0xffE8F5E9,
                                    ),

                                    borderRadius:
                                        BorderRadius.circular(
                                      12,
                                    ),
                                  ),

                                  child:
                                      Text(
                                    data["role"] ??
                                        "user",

                                    style:
                                        GoogleFonts.poppins(
                                      color:
                                          Colors.green,
                                      fontSize:
                                          12,
                                      fontWeight:
                                          FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          PopupMenuButton(
                            itemBuilder:
                                (context) =>
                                    [

                              const PopupMenuItem(
                                value:
                                    "delete",

                                child:
                                    Text(
                                  "Delete User",
                                ),
                              ),
                            ],

                            onSelected:
                                (
                              value,
                            ) async {

                              if (value ==
                                  "delete") {

                                await FirebaseFirestore
                                    .instance
                                    .collection(
                                      "users",
                                    )
                                    .doc(
                                      users[index]
                                          .id,
                                    )
                                    .delete();
                              }
                            },
                          ),
                        ],
                      ),
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