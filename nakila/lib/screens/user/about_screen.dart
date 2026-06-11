import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xffF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        title: Text(
          "About NAKILA",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(25),

              decoration: BoxDecoration(
                gradient:
                    const LinearGradient(
                  colors: [
                    Color(0xff1E40AF),
                    Color(0xff3B82F6),
                  ],
                ),

                borderRadius:
                    BorderRadius.circular(
                  25,
                ),
              ),

              child: Column(
                children: [

                  const Icon(
                    Icons.school,
                    size: 70,
                    color: Colors.white,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Text(
                    "NAKILA",

                    style:
                        GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Discover Your Dream University",

                    textAlign:
                        TextAlign.center,

                    style:
                        GoogleFonts.poppins(
                      color:
                          Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "About Application",

              style:
                  GoogleFonts.poppins(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "NAKILA is a university discovery platform designed to help students explore the world's best universities. Users can browse campus information, read reviews, save favorites, and find the right university for their future.",

              style:
                  GoogleFonts.poppins(
                height: 1.8,
                color:
                    Colors.black87,
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "Meet The Team",

              style:
                  GoogleFonts.poppins(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _teamCard(
              image:
                  "assets/User/bella.jpg",

              name: "Bella",

              role:
                  "UI/UX Designer",
            ),

            const SizedBox(height: 15),

            _teamCard(
              image:
                  "assets/User/kiarra.jpg",

              name: "Kiarra",

              role:
                  "Project Manager",
            ),

            const SizedBox(height: 15),

            _teamCard(
              image:
                  "assets/User/nabila.jpg",

              name: "Nabila",

              role:
                  "Website Developer",
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                20,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),

              child: Column(
                children: [

                  Text(
                    "Version",

                    style:
                        GoogleFonts
                            .poppins(
                      color:
                          Colors.grey,
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Text(
                    "1.0.0",

                    style:
                        GoogleFonts
                            .poppins(
                      fontWeight:
                          FontWeight
                              .bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _teamCard({
    required String image,
    required String name,
    required String role,
  }) {

    return Container(
      padding:
          const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(
              alpha: .05,
            ),
            blurRadius: 12,
          ),
        ],
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 30,
            backgroundImage:
                AssetImage(image),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Row(
                  children: [

                    Text(
                      name,

                      style:
                          GoogleFonts
                              .poppins(
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                      width: 5,
                    ),

                    const Icon(
                      Icons.verified,
                      size: 16,
                      color:
                          Colors.blue,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  role,

                  style:
                      GoogleFonts
                          .poppins(
                    color:
                        Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}