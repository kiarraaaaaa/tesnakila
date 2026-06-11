import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/campus_model.dart';

class CampusCard extends StatelessWidget {
  final CampusModel campus;

  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  
  const CampusCard({
    super.key,
    required this.campus,
    required this.onTap,
    required this.onFavoriteTap,
    
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: 260,

        margin: const EdgeInsets.only(
          right: 20,
          bottom: 15,
        ),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(24),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: .08,
              ),
              blurRadius: 15,
              offset: const Offset(
                0,
                5,
              ),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            /// IMAGE
            Stack(
              children: [

                Hero(
                  tag: campus.id,

                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.only(
                      topLeft:
                          Radius.circular(24),
                      topRight:
                          Radius.circular(24),
                    ),

                    child: Image.asset(
                      campus.image,

                      width: double.infinity,
                      height: 200,

                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  top: 12,
                  right: 12,

                  child: GestureDetector(
                    onTap: onFavoriteTap,

                    child: Container(
                      padding:
                          const EdgeInsets.all(
                        10,
                      ),

                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,
                        borderRadius:
                            BorderRadius
                                .circular(
                          15,
                        ),
                      ),

                      child: Icon(
                        campus.isFavorite
                            ? Icons.favorite
                            : Icons
                                .favorite_border,

                        color:
                            campus.isFavorite
                                ? Colors.red
                                : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding:
                  const EdgeInsets.all(18),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          campus.name,

                          maxLines: 1,
                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              GoogleFonts
                                  .poppins(
                            fontSize: 18,
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
                          size: 20,
                        ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [

                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 18,
                      ),

                      const SizedBox(width: 5),

                      Expanded(
                        child: Text(
                          "${campus.location}, ${campus.country}",

                          maxLines: 1,

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              GoogleFonts
                                  .poppins(
                            color:
                                Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [

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
                              color: Colors.orange,
                              size: 16,
                            ),

                            const SizedBox(
                              width: 4,
                            ),

                            Text(
                              campus.rating
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

                      const Spacer(),

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
                            0xffE8F5E9,
                          ),

                          borderRadius:
                              BorderRadius
                                  .circular(
                            12,
                          ),
                        ),

                        child: Text(
                          "Verified",

                          style:
                              GoogleFonts
                                  .poppins(
                            color:
                                Colors.green,
                            fontSize: 12,
                            fontWeight:
                                FontWeight
                                    .w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Text(
                    campus.description,

                    maxLines: 2,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}