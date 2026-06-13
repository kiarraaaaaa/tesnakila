import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/auth/login_screen.dart';
import 'dart:convert';

class CustomSidebar extends StatelessWidget {
  final String userName;
  final String role;
  final String profileImage;
  final int selectedIndex;

  final Function(int) onItemTap;

  const CustomSidebar({
    super.key,
    required this.userName,
    required this.role,
    required this.profileImage,
    required this.selectedIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff0F172A),
            Color(0xff172554),
          ],
        ),
      ),

      child: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 20),

            /// LOGO
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .08),
                borderRadius:
                    BorderRadius.circular(18),
              ),

              child: Row(
                children: [

                  Container(
                    height: 50,
                    width: 50,

                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(15),

                      color: Colors.white,
                    ),

                    child: ClipRRect(
  borderRadius:
      BorderRadius.circular(15),

  child: Image.asset(
    "assets/Additional/Polosan.png",
    fit: BoxFit.cover,
  ),
),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          "NAKILA",
                          style:
                              GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        Row(
                          children: [

                            const Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 16,
                            ),

                            const SizedBox(width: 4),

                            Text(
                              "Verified App",
                              style:
                                  GoogleFonts.poppins(
                                color:
                                    Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [

                  _menuTile(
                    icon: Icons.home_rounded,
                    title: "Home",
                    index: 0,
                  ),

                  _menuTile(
                    icon: Icons.favorite_rounded,
                    title: "Favorites",
                    index: 1,
                  ),

                  _menuTile(
                    icon: Icons.person_rounded,
                    title: "Profile",
                    index: 2,
                  ),

                  _menuTile(
                    icon: Icons.info_outline_rounded,
                    title: "About App",
                    index: 3,
                  ),
                ],
              ),
            ),

            const Divider(
              color: Colors.white24,
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding:
                    const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color:
                      Colors.white.withValues(alpha: .08),

                  borderRadius:
                      BorderRadius.circular(18),
                ),

                child: Row(
                  children: [

                    CircleAvatar(
  radius: 25,

  backgroundImage:
      profileImage.isNotEmpty

          ? MemoryImage(
              base64Decode(
                profileImage,
              ),
            )

          : const AssetImage(
              "assets/Additional/Profile.png",
            ) as ImageProvider,
),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                         Row(
  mainAxisSize: MainAxisSize.min,
  children: [

    Flexible(
      child: Text(
        userName,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    const SizedBox(width: 4),

    const Icon(
      Icons.verified,
      color: Colors.blue,
      size: 16,
    ),
  ],
),

                          Text(
                            role,
                            style:
                                GoogleFonts.poppins(
                              color:
                                  Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),

              child: SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton.icon(
  onPressed: () async {

    await FirebaseAuth.instance
        .signOut();

    if (context.mounted) {

      Navigator.pushAndRemoveUntil(
        context,

        MaterialPageRoute(
          builder: (_) =>
              const LoginScreen(),
        ),

        (route) => false,
      );
    }
  },

  icon: const Icon(
    Icons.logout_rounded,
    color: Colors.white,
  ),

                  label: Text(
                    "Logout",
                    style:
                        GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(
                            0xff2563EB),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              16),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String title,
    required int index,
  }) {
    bool isSelected =
        selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(16),

        onTap: () {
          onItemTap(index);
        },

        child: AnimatedContainer(
          duration:
              const Duration(milliseconds: 250),

          padding:
              const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),

          decoration: BoxDecoration(
            color: isSelected
                ? const Color(
                    0xff2563EB)
                : Colors.transparent,

            borderRadius:
                BorderRadius.circular(16),
          ),

          child: Row(
            children: [

              Icon(
                icon,
                color: Colors.white,
              ),

              const SizedBox(width: 15),

              Text(
                title,
                style:
                    GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}