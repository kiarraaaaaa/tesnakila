import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewBottomSheet extends StatefulWidget {
  const ReviewBottomSheet({
    super.key,
  });

  @override
  State<ReviewBottomSheet> createState() =>
      _ReviewBottomSheetState();
}

class _ReviewBottomSheetState
    extends State<ReviewBottomSheet> {

  final TextEditingController
      reviewController =
      TextEditingController();

  double rating = 5;

  File? imageFile;

  Future<void> Future<void> pickImage() async {

  final image =
      await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
  );

  if (image != null) {

    imageBytes =
        await image.readAsBytes();

    setState(() {});
  }
} async {

    final picker = ImagePicker();

    final image =
        await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom:
            MediaQuery.of(context)
                .viewInsets
                .bottom +
            20,
      ),

      decoration: const BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          mainAxisSize:
              MainAxisSize.min,

          children: [

            Center(
              child: Container(
                height: 5,
                width: 60,

                decoration:
                    BoxDecoration(
                  color:
                      Colors.grey.shade300,

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Write a Review",

              style:
                  GoogleFonts.poppins(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Rating",

              style:
                  GoogleFonts.poppins(
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: List.generate(
                5,
                (index) {

                  return IconButton(
                    onPressed: () {
                      setState(() {
                        rating =
                            index + 1.0;
                      });
                    },

                    icon: Icon(
                      index < rating
                          ? Icons.star
                          : Icons
                              .star_border,

                      color:
                          Colors.orange,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  reviewController,

              maxLines: 5,

              decoration:
                  InputDecoration(
                hintText:
                    "Share your experience...",

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Review Image",

              style:
                  GoogleFonts.poppins(
                fontWeight:
                    FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: pickImage,

              child: Container(
                width: double.infinity,
                height: 180,

                decoration:
                    BoxDecoration(
                  color:
                      Colors.grey.shade100,

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),

                child: imageFile == null
                    ? Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [

                          const Icon(
                            Icons.image,
                            size: 50,
                            color:
                                Colors.grey,
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Text(
                            "Upload Image",

                            style:
                                GoogleFonts
                                    .poppins(),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius:
                            BorderRadius
                                .circular(
                          20,
                        ),

                        child: Image.file(
                          imageFile!,

                          fit:
                              BoxFit.cover,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: () {

                  Navigator.pop(
                    context,
                  );
                },

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(
                    0xff2563EB,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),
                  ),
                ),

                child: Text(
                  "Submit Review",

                  style:
                      GoogleFonts.poppins(
                    color:
                        Colors.white,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}