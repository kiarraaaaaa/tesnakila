import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

 Uint8List? imageBytes;
XFile? selectedImage;

  bool isLoading = false;

  Future<void> pickImage() async {

  final image =
      await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

  if (image != null) {

    imageBytes =
        await image.readAsBytes();

    setState(() {

      selectedImage = image;
    });
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

      String imageBase64 = "";

if (imageBytes != null) {

  imageBase64 =
      base64Encode(
    imageBytes!,
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

        reviewImage:
            imageBase64,

        rating: rating,

        createdAt:
            DateTime.now(),
      );

      await ReviewService()
          .addReview(
        review: review,
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

            if (selectedImage !=
                null)

              ClipRRect(
                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),
                if (imageBytes != null)

  ClipRRect(
    borderRadius:
        BorderRadius.circular(16),

    child: Image.memory(
      imageBytes!,
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  ),

            const SizedBox(
              height: 20,
            ),

            OutlinedButton.icon(
              onPressed:
                  pickImage,

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