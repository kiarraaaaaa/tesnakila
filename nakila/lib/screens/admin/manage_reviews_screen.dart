import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageReviewsScreen
    extends StatefulWidget {
  const ManageReviewsScreen({
    super.key,
  });

  @override
  State<ManageReviewsScreen>
      createState() =>
          _ManageReviewsScreenState();
}

class _ManageReviewsScreenState
    extends State<
        ManageReviewsScreen> {

  final List<Map<String, dynamic>>
      reviews = [

    {
      "name": "Handy",
      "campus":
          "Harvard University",
      "rating": 5.0,
      "review":
          "Amazing campus with outstanding facilities and academic excellence.",
      "image":
          "assets/Additional/Harvard.jpg",
    },

    {
      "name": "Bella",
      "campus":
          "Oxford University",
      "rating": 4.8,
      "review":
          "Beautiful environment and top-quality education.",
      "image":
          "assets/Additional/Oxford.jpg",
    },
  ];

  void deleteReview(
    int index,
  ) {

    setState(() {
      reviews.removeAt(index);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      const SnackBar(
        content: Text(
          "Review Deleted",
        ),
      ),
    );
  }

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
          "Manage Reviews",
        ),
      ),

      body: reviews.isEmpty

          ? Center(
              child: Text(
                "No Reviews Found",

                style:
                    GoogleFonts
                        .poppins(
                  fontSize: 18,
                  fontWeight:
                      FontWeight
                          .bold,
                ),
              ),
            )

          : ListView.builder(
              padding:
                  const EdgeInsets
                      .all(
                20,
              ),

              itemCount:
                  reviews.length,

              itemBuilder:
                  (
                context,
                index,
              ) {

                final review =
                    reviews[index];

                return Container(
                  margin:
                      const EdgeInsets
                          .only(
                    bottom: 20,
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
                            .withOpacity(
                          .05,
                        ),
                        blurRadius:
                            12,
                      ),
                    ],
                  ),

                  child: Column(
                    children: [

                      ClipRRect(
                        borderRadius:
                            const BorderRadius.only(
                          topLeft:
                              Radius.circular(
                            20,
                          ),
                          topRight:
                              Radius.circular(
                            20,
                          ),
                        ),

                        child:
                            Image.asset(
                          review[
                              "image"],

                          height:
                              180,

                          width:
                              double.infinity,

                          fit:
                              BoxFit.cover,
                        ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsets.all(
                          16,
                        ),

                        child:
                            Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Row(
                              children: [

                                const CircleAvatar(
                                  child:
                                      Icon(
                                    Icons.person,
                                  ),
                                ),

                                const SizedBox(
                                  width:
                                      10,
                                ),

                                Expanded(
                                  child:
                                      Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [

                                      Text(
                                        review[
                                            "name"],

                                        style:
                                            GoogleFonts.poppins(
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),

                                      Text(
                                        review[
                                            "campus"],
                                      ),
                                    ],
                                  ),
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
                                        Colors.orange.shade100,

                                    borderRadius:
                                        BorderRadius.circular(
                                      12,
                                    ),
                                  ),

                                  child:
                                      Row(
                                    children: [

                                      const Icon(
                                        Icons.star,
                                        color:
                                            Colors.orange,
                                        size:
                                            16,
                                      ),

                                      const SizedBox(
                                        width:
                                            4,
                                      ),

                                      Text(
                                        review["rating"]
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            Text(
                              review[
                                  "review"],

                              style:
                                  GoogleFonts.poppins(
                                height:
                                    1.5,
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            SizedBox(
                              width:
                                  double.infinity,

                              child:
                                  ElevatedButton.icon(
                                onPressed:
                                    () {
                                  deleteReview(
                                    index,
                                  );
                                },

                                icon:
                                    const Icon(
                                  Icons.delete,
                                  color:
                                      Colors.white,
                                ),

                                label:
                                    const Text(
                                  "Delete Review",
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
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}