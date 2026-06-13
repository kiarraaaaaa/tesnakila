import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import '../models/review_model.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),

      padding: const EdgeInsets.all(
        16,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: .05,
            ),
            blurRadius: 12,
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          /// HEADER
          Row(
            children: [

              CircleAvatar(
                radius: 25,

                backgroundImage:
    review.userImage.isNotEmpty
        ? MemoryImage(
            base64Decode(
              review.userImage,
            ),
          )
        : null,

                child:
                    review.userImage.isEmpty
                        ? const Icon(
                            Icons.person,
                          )
                        : null,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Row(
                      children: [

                        Flexible(
                          child: Text(
                            review.userName,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                GoogleFonts
                                    .poppins(
                              fontWeight:
                                  FontWeight
                                      .bold,
                              fontSize:
                                  15,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 5,
                        ),

                        const Icon(
                          Icons.verified,
                          color:
                              Colors.blue,
                          size: 16,
                        ),
                      ],
                    ),

                    Text(
                      _formatDate(
                        review.createdAt,
                      ),

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

              Container(
                padding:
                    const EdgeInsets
                        .symmetric(
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
                      BorderRadius
                          .circular(
                    12,
                  ),
                ),

                child: Row(
                  children: [

                    const Icon(
                      Icons.star,
                      color:
                          Colors.orange,
                      size: 16,
                    ),

                    const SizedBox(
                      width: 4,
                    ),

                    Text(
                      review.rating
                          .toString(),

                      style:
                          GoogleFonts
                              .poppins(
                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          /// REVIEW TEXT
          Text(
            review.reviewText,

            style:
                GoogleFonts.poppins(
              fontSize: 14,
              height: 1.6,
            ),
          ),

          /// REVIEW IMAGE
         if (review.reviewImages.isNotEmpty)

  Padding(
    padding: const EdgeInsets.only(
      top: 15,
    ),

    child: SizedBox(
      height: 120,

      child: ListView.builder(
        scrollDirection:
            Axis.horizontal,

        itemCount:
            review.reviewImages.length,

        itemBuilder:
            (context, index) {

          return Container(
            margin:
                const EdgeInsets.only(
              right: 10,
            ),

            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(
                12,
              ),

              child: Image.memory(
                base64Decode(
                  review.reviewImages[
                      index],
                ),

                width: 120,
                height: 120,

                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    ),
  ),
        ],
      ),
    );
  }
  }

  String _formatDate(
    DateTime date,
  ) {
    return
        "${date.day}/${date.month}/${date.year}";
  }
