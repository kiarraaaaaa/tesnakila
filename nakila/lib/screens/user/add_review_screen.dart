import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nakila/services/activity_service.dart';

import '../../models/campus_model.dart';
import '../../models/review_model.dart';

import '../../services/review_service.dart';

class AddReviewScreen extends StatefulWidget {
  final CampusModel campus;

  const AddReviewScreen({
    super.key,
    required this.campus,
  });

  @override
  State<AddReviewScreen> createState() =>
      _AddReviewScreenState();
}

class _AddReviewScreenState
    extends State<AddReviewScreen> {

  final TextEditingController
      reviewController =
          TextEditingController();

  double rating = 5;

 List<Uint8List> imageList = [];
List<XFile> selectedImages = [];

  bool isLoading = false;

  Future<void> pickImages() async {

  final images =
      await ImagePicker().pickMultiImage();

  if (images.isNotEmpty) {

    selectedImages = images;

    imageList.clear();

    for (var image in images) {

      imageList.add(
        await image.readAsBytes(),
      );
    }

    setState(() {});
  }
}

  Future<void> submitReview() async {

    if (reviewController.text
        .trim()
        .isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final uid =
          FirebaseAuth
              .instance
              .currentUser!
              .uid;

      final userDoc =
          await FirebaseFirestore
              .instance
              .collection(
                "users",
              )
              .doc(uid)
              .get();

      final user =
          userDoc.data()!;

     List<String> reviewImages = [];

for (var image in imageList) {

  reviewImages.add(
    base64Encode(image),
  );
}

      final reviewId =
          DateTime.now()
              .millisecondsSinceEpoch
              .toString();

      final review =
          ReviewModel(
        id: reviewId,

        campusId:
            widget.campus.id,

        userId: uid,

        userName:
            user["name"] ??
                "User",

        userImage:
            user["photoUrl"] ??
                "",

        reviewText:
            reviewController.text,

        reviewImages:
            reviewImages,

        rating: rating,

        createdAt:
            DateTime.now(),
      );

      await ReviewService()
          .addReview(
        review: review,
      );
await ActivityService()
    .addActivity(
  title:
      "${user["name"]} Reviewed ${widget.campus.name}",
  type:
      "review",
);
      if (mounted) {

        Navigator.pop(
          context,
        );
      }

    } catch (e) {

      debugPrint(
        e.toString(),
      );
    }

    if (mounted) {

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(
        0xffF8FAFC,
      ),

      appBar: AppBar(
        title:
            const Text(
          "Write Review",
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(
          20,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              "Rating",

              style:
                  GoogleFonts.poppins(
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Row(
              children:
                  List.generate(
                5,

                (index) {

                  return IconButton(
                    onPressed: () {

                      setState(() {

                        rating =
                            index +
                                1;
                      });
                    },

                    icon: Icon(
                      Icons.star,

                      color:
                          index <
                                  rating
                              ? Colors
                                  .orange
                              : Colors
                                  .grey,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            TextField(
              controller:
                  reviewController,

              maxLines: 5,

              decoration:
                  InputDecoration(
                hintText:
                    "Write your review...",

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

           if (imageList.isNotEmpty)

SizedBox(
  height: 120,

  child: ListView.builder(
    scrollDirection:
        Axis.horizontal,

    itemCount:
        imageList.length,

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
            imageList[index],

            width: 120,
            height: 120,

            fit: BoxFit.cover,
          ),
        ),
      );
    },
  ),
),

            const SizedBox(
              height: 20,
            ),

            OutlinedButton.icon(
              onPressed:
                  pickImages,

              icon: const Icon(
                Icons.photo,
              ),

              label: const Text(
                "Add Photo",
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            SizedBox(
              width:
                  double.infinity,

              height: 55,

              child:
                  ElevatedButton(
                onPressed:
                    isLoading
                        ? null
                        : submitReview,

                child: isLoading

                    ? const CircularProgressIndicator()

                    : const Text(
                        "Submit Review",
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}