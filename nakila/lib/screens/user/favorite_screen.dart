import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/favorite_service.dart';
import '../../services/campus_service.dart';
import 'campus_detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
  backgroundColor:
      Theme.of(context)
          .scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor:
            Colors.white,

        elevation: 0,

        centerTitle: true,

        title: Row(
  mainAxisSize: MainAxisSize.min,
  children: [

    const Icon(
      Icons.favorite,
      color: Colors.red,
    ),

    const SizedBox(width: 8),

    Text(
      "Favorite Campuses",
      style:
          GoogleFonts.poppins(
        color: Colors.black,
        fontWeight:
            FontWeight.bold,
      ),
    ),
  ],
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
      docs[index]["campusId"];

  return FutureBuilder(
    future:
        CampusService()
            .getCampusFirestoreById(
      campusId,
    ),

    builder:
        (context, snapshot) {

      if (snapshot.connectionState ==
    ConnectionState.waiting) {
  return const Center(
    child:
        CircularProgressIndicator(),
  );
}

if (!snapshot.hasData) {
  return const SizedBox();
}

      final campus =
          snapshot.data!;

     return Container(
  margin: const EdgeInsets.only(
    bottom: 15,
  ),

  decoration: BoxDecoration(
    color: Theme.of(context)
        .cardColor,

    borderRadius:
        BorderRadius.circular(
      20,
    ),
  
    boxShadow: [
      BoxShadow(
        color:
            Colors.black.withValues(
          alpha: .08,
        ),
      
        blurRadius: 12,
        offset: const Offset(
          0,
          5,
        ),
      ),
    ],
  ),

  child: InkWell(
    borderRadius:
        BorderRadius.circular(
      20,
    ),

    onTap: () {

      Navigator.push(
        context,

        MaterialPageRoute(
          builder: (_) =>
              CampusDetailScreen(
            campus: campus,
          ),
        ),
      );
    },

    child: Row(
      children: [

        /// IMAGE
        ClipRRect(
          borderRadius:
              const BorderRadius.only(
            topLeft:
                Radius.circular(
              20,
            ),
            bottomLeft:
                Radius.circular(
              20,
            ),
          ),

          child: SizedBox(
            width: 120,
            height: 120,

            child: campus.image.isEmpty

    ? Container(
        color: Colors.grey.shade200,

        child: const Center(
          child: Icon(
            Icons.image,
            size: 40,
          ),
        ),
      )

    : campus.image.startsWith(
        "assets/",
      )

        ? Image.asset(
            campus.image,
            fit: BoxFit.cover,
          )

        : Image.memory(
            base64Decode(
              campus.image,
            ),
            fit: BoxFit.cover,
          ),

          ),
        ),

        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.all(
              15,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
 
                    Row(
  children: [

    Flexible(
      child: Text(
        campus.name,

        maxLines: 1,

        overflow:
            TextOverflow.ellipsis,

        style:
            GoogleFonts.poppins(
          fontWeight:
              FontWeight.bold,
          fontSize: 17,
        ),
      ),
    ),

    const SizedBox(
      width: 5,
    ),

    const Icon(
      Icons.verified,
      color: Colors.blue,
      size: 18,
    ),
  ],
),
                   

                const SizedBox(
                  height: 6,
                ),

                Text(
                  "${campus.location}, ${campus.country}",

                  style:
                      GoogleFonts
                          .poppins(
                    color:
                        Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Row(
                  children: [

                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),

                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                          0xffEFF6FF,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          10,
                        ),
                      ),

                      child: Text(
                        campus.worldRanking,

                        style:
                            GoogleFonts
                                .poppins(
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

                    IconButton(
                      onPressed:
                          () async {

                        await FavoriteService()
                            .toggleFavorite(
                          campus.id,
                        );
                      },

                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ),
          ),
      ],
    ),
  ),
);
      }
  );
    }
            ),
          );
            },
          ),
    );
  }
  
}