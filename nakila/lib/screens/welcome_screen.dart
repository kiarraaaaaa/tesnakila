import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff0F172A),
              Color(0xff1E40AF),
              Color(0xff3B82F6),
            ],
          ),
        ),

        child: SafeArea(
          child: Stack(
            children: [

              Positioned(
                top: -120,
                right: -80,
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: .08),
                  ),
                ),
              ),

              Positioned(
                bottom: -120,
                left: -80,
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: .06),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                ),

                child: Column(
                  children: [

                    SizedBox(
                      height: size.height * .06,
                    ),

                    Hero(
                      tag: "campus_image",
                      child: Image.asset(
                        "assets/Additional/Polosan.png",
                        height: size.height * .33,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "NAKILA",
                      style: GoogleFonts.poppins(
                        color: Theme.of(context)
        .cardColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 4,
                      ),
                    ),

                    const Spacer(),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),

                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .12),
                        borderRadius:
                            BorderRadius.circular(30),

                        border: Border.all(
                          color: Colors.white.withValues(alpha: .15),
                        ),
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Find Your Dream Campus",
                            style:
                                GoogleFonts.poppins(
                              color: Theme.of(context)
        .cardColor,
                              fontSize: 30,
                              fontWeight:
                                  FontWeight.bold,
                              height: 1.2,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            "Explore top universities, compare campuses, discover scholarships and build your future with NAKILA.",
                            style:
                                GoogleFonts.poppins(
                              color:
                                  Colors.white70,
                              fontSize: 14,
                              height: 1.7,
                            ),
                          ),

                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            height: 58,

                            child: ElevatedButton(
                              onPressed: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const LoginScreen(),
                                  ),
                                );

                              },

                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.white,

                                foregroundColor:
                                    const Color(
                                        0xff1E40AF),

                                elevation: 0,

                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          18),
                                ),
                              ),

                              child: Text(
                                "Get Started",
                                style:
                                    GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}