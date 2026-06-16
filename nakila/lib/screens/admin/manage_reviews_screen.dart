import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/review_model.dart';
import '../../services/review_service.dart';

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

  String searchText = "";

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(
  backgroundColor:
      Theme.of(context)
          .scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text(
          "Manage Reviews",
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
              onChanged:
                  (value) {

                setState(() {

                  searchText =
                      value
                          .toLowerCase();
                });
              },

              decoration:
                  InputDecoration(
                hintText:
                    "Search Review",

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
                ),
              ),
            ),
          ),

          Expanded(
            child:
                StreamBuilder<
                    List<ReviewModel>>(
              stream:
                  ReviewService()
                      .getAllReviews(),

              builder:
                  (
                context,
                snapshot,
              ) {

                if (!snapshot
                    .hasData) {

                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                final reviews =
                    snapshot.data!
                        .where(
                          (
                            review,
                          ) {

                            return review
                                .userName
                                .toLowerCase()
                                .contains(
                                  searchText,
                                );
                          },
                        )
                        .toList();

                if (reviews
                    .isEmpty) {

                  return const Center(
                    child: Text(
                      "No Reviews Found",
                    ),
                  );
                }

                return ListView.builder(
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
                        reviews[
                            index];

                    return Container(
                      margin:
                          const EdgeInsets
                              .only(
                        bottom: 15,
                      ),

                      padding:
                          const EdgeInsets
                              .all(
                        15,
                      ),

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,

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
                                        ? MemoryImage(
                                            base64Decode(
                                              review.userImage,
                                            ),
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
                                child:
                                    Text(
                                  review.userName,

                                  style:
                                      GoogleFonts.poppins(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),

                              Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),

                                decoration:
                                    BoxDecoration(
                                  color:
                                      const Color(
                                    0xffFFF7E6,
                                  ),

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
                                      size: 16,
                                      color:
                                          Colors.orange,
                                    ),

                                    const SizedBox(
                                      width:
                                          4,
                                    ),

                                    Text(
                                      review.rating
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
                            review.reviewText,
                          ),

                          if (review
                              .reviewImages
                              .isNotEmpty)

                            Padding(
                              padding:
                                  const EdgeInsets.only(
                                top: 15,
                              ),

                              child:
                                  SizedBox(
                                height:
                                    100,

                                child:
                                    ListView.builder(
                                  scrollDirection:
                                      Axis.horizontal,

                                  itemCount:
                                      review.reviewImages.length,

                                  itemBuilder:
                                      (
                                    context,
                                    imgIndex,
                                  ) {

                                    return Container(
                                      margin:
                                          const EdgeInsets.only(
                                        right:
                                            10,
                                      ),

                                      child:
                                          ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(
                                          12,
                                        ),

                                        child:
                                            Image.memory(
                                          base64Decode(
                                            review.reviewImages[
                                                imgIndex],
                                          ),

                                          width:
                                              100,

                                          height:
                                              100,

                                          fit:
                                              BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                          const SizedBox(
                            height: 15,
                          ),

                          Align(
                            alignment:
                                Alignment
                                    .centerRight,

                            child:
                                ElevatedButton.icon(
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.red,
                              ),

                              onPressed:
                                  () async {

                                await ReviewService()
                                    .deleteReview(
                                  review.id,
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
                                "Delete",
                              ),
                            ),
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