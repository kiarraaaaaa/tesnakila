import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/review_service.dart';
import '../../models/review_model.dart';
import 'add_review_screen.dart';
import '../../models/campus_model.dart';
import 'dart:convert';
class CampusDetailScreen extends StatelessWidget {
  final CampusModel campus;

  const CampusDetailScreen({
    super.key,
    required this.campus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            expandedHeight: 320,
            pinned: true,

            backgroundColor:
                const Color(0xff1E40AF),

            flexibleSpace:
                FlexibleSpaceBar(
              background: Hero(
                tag: campus.id,

                child: Image.asset(
                  campus.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          campus.name,

                          style:
                              GoogleFonts
                                  .poppins(
                            fontSize: 28,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ),

                      if (campus.verified)
                        const Icon(
                          Icons.verified,
                          color: Colors.blue,
                        ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [

                      const Icon(
                        Icons.star,
                        color:
                            Colors.orange,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        campus.rating
                            .toString(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding:
                        const EdgeInsets.all(
                      16,
                    ),

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
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceAround,

                      children: [

                        _infoItem(
                          "Founded",
                          campus.foundedYear,
                        ),

                        _infoItem(
                          "Ranking",
                          campus.worldRanking,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    "Description",

                    style:
                        GoogleFonts.poppins(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    campus.description,

                    style:
                        GoogleFonts.poppins(
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    "History",

                    style:
                        GoogleFonts.poppins(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    campus.history,

                    style:
                        GoogleFonts.poppins(
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    "Achievements",

                    style:
                        GoogleFonts.poppins(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 15),

                  ...campus.achievements
                      .map(
                        (achievement) =>
                            ListTile(
                          leading:
                              const Icon(
                            Icons.emoji_events,
                            color:
                                Colors.amber,
                          ),
                          title: Text(
                            achievement,
                          ),
                        ),
                      ),

                  const SizedBox(height: 25),

                  Text(
                    "Programs",

                    style:
                        GoogleFonts.poppins(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,

                    children: campus
                        .programs
                        .map(
                          (program) =>
                              Chip(
                            label:
                                Text(
                              program,
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "Reviews",

                    style:
                        GoogleFonts.poppins(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 15),

                  StreamBuilder<List<ReviewModel>>(
  stream: ReviewService()
      .getReviewsByCampus(
    campus.id,
  ),

  builder: (
    context,
    snapshot,
  ) {
    if (snapshot.hasError) {

  return Text(
    snapshot.error.toString(),
  );
}

    if (!snapshot.hasData) {

      return const Center(
        child:
            CircularProgressIndicator(),
      );
    }

    final reviews =
        snapshot.data!;

    if (reviews.isEmpty) {

      return Container(
        padding:
            const EdgeInsets.all(
          20,
        ),

        decoration:
            BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(
            20,
          ),
        ),

        child: const Center(
          child: Text(
            "No reviews yet",
          ),
        ),
      );
    }

    return Column(
      children:
          reviews.map(
        (review) {

          return Container(
            margin:
                const EdgeInsets.only(
              bottom: 15,
            ),

            padding:
                const EdgeInsets.all(
              16,
            ),

            decoration:
                BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                20,
              ),
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Row(
                  children: [

                    CircleAvatar(
                      backgroundImage:
                          review.userImage
                                  .isNotEmpty
                              ? NetworkImage(
                                  review.userImage,
                                )
                              : null,

                      child:
                          review.userImage
                                  .isEmpty
                              ? const Icon(
                                  Icons.person,
                                )
                              : null,
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Text(
                            review.userName,
                            style:
                                GoogleFonts
                                    .poppins(
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          Text(
                            review.createdAt
                                .toString(),
                            style:
                                GoogleFonts
                                    .poppins(
                              fontSize: 12,
                              color:
                                  Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                Row(
                  children: List.generate(
                    review.rating
                        .toInt(),

                    (index) =>
                        const Icon(
                      Icons.star,
                      color:
                          Colors.orange,
                      size: 18,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  review.reviewText,
                ),

                if (review.reviewImage.isNotEmpty)

  Padding(
    padding:
        const EdgeInsets.only(
      top: 10,
    ),

    child: ClipRRect(
      borderRadius:
          BorderRadius.circular(
        12,
      ),

      child: Image.memory(
        base64Decode(
          review.reviewImage,
        ),
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    ),
  ),
              ],
            ),
          );
        },
      ).toList(),
    );
  },
),

                  const SizedBox(height: 30),

                  SizedBox(
                    width:
                        double.infinity,
                    height: 55,

                    child:
                        ElevatedButton.icon(
                      onPressed: () {

  Navigator.push(
    context,

    MaterialPageRoute(
      builder: (_) =>
          AddReviewScreen(
        campus: campus,
      ),
    ),
  );
},

                      icon: const Icon(
                        Icons.rate_review,
                      ),

                      label: const Text(
                        "Write Review",
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoItem(
    String title,
    String value,
  ) {
    return Column(
      children: [

        Text(
          value,
          style: const TextStyle(
            fontWeight:
                FontWeight.bold,
            fontSize: 18,
          ),
        ),

        const SizedBox(height: 5),

        Text(title),
      ],
    );
  }
}