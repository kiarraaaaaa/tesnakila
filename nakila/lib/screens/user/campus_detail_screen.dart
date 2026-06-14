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
            expandedHeight: 220,
            
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
  padding: const EdgeInsets.all(20),

      child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(
  children: [

    Text(
      campus.name,
      style: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),

    const SizedBox(width: 8),

    const Icon(
      Icons.verified,
      color: Colors.blue,
      size: 20,
    ),
  ],
),
Row(
  children: [

    const Icon(
      Icons.location_on,
      size: 18,
      color: Colors.grey,
    ),

    const SizedBox(width: 5),

    Text(
      "${campus.location}, ${campus.country}",
    ),
  ],
),
const SizedBox(height: 8),

Row(
  children: [

    const Icon(
      Icons.school,
      size: 18,
      color: Colors.blue,
    ),

    const SizedBox(width: 5),

    Text(
      "Top Ranked University",
    ),
  ],
),
const SizedBox(height: 15),

Wrap(
  spacing: 10,
  children: [

    Chip(
      avatar: Icon(
        Icons.public,
        size: 16,
      ),
      label: Text(
        campus.country,
      ),
    ),

    Chip(
      avatar: Icon(
        Icons.school,
        size: 16,
      ),
      label: Text(
        campus.foundedYear,
      ),
    ),

    Chip(
      avatar: Icon(
        Icons.workspace_premium,
        size: 16,
      ),
      label: Text(
        "Verified",
      ),
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
                    padding: EdgeInsets.symmetric(
  vertical: 12,
  horizontal: 16,
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
                      fontSize: 18,
                    ),
                  ),


                 const SizedBox(height: 10),


SizedBox(
  width: double.infinity,

  child: Text(
    campus.description,

    style:
        GoogleFonts.poppins(
      height: 1.7,
    ),
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

                  SizedBox(
  width: double.infinity,
  child: Text(
    campus.history,
    style: GoogleFonts.poppins(
      height: 1.7,
    ),
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
      (achievement) => Padding(
        padding:
            const EdgeInsets.symmetric(
          vertical: 4,
        ),

        child: Row(
          children: [

            const Icon(
              Icons.emoji_events,
              color: Colors.amber,
              size: 18,
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                achievement,
               ),
            ),
          ],
        ),
      ),
    )
    .toList(),

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

        decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(20),

  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ],
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
  alignment: Alignment.centerLeft,

  child: SizedBox(

    child: Container(
      margin:
          const EdgeInsets.only(
        bottom: 15,
      ),

      padding:
          const EdgeInsets.all(
        16,
      ),

      decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(20),

  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ],
),
    
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Row(
                  children: [

                    CircleAvatar(
  radius: 22,

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
  "${review.createdAt.day}/${review.createdAt.month}/${review.createdAt.year}",

  style:
      GoogleFonts.poppins(
    fontSize: 12,
    color: Colors.grey,
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

                if (review.reviewImages.isNotEmpty)

  Padding(
    padding: const EdgeInsets.only(
      top: 10,
    ),

    child: SizedBox(
      height: 90,
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
              right: 8,
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

                width: 90,
                height: 90,

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
    ),
  ),
  
          );
        },
      ).toList(),
    );
  },
),

                  const SizedBox(height: 30),

                  Center(
  child: SizedBox(
    width: 250,
    height: 50,

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

                  ),
                ]
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
            fontSize: 15,
          ),
        ),

        const SizedBox(height: 5),

        Text(title),
      ],
    );
  }
}