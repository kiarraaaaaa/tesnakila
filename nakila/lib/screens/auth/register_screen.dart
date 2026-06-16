import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nakila/services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmController =
      TextEditingController();

  bool isLoading = false;
  bool hidePassword = true;
  bool hideConfirm = true;
  String selectedRole = "user";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff2563EB),
              Color(0xff60A5FA),
            ],
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),

            child: Column(
              children: [

                const SizedBox(height: 20),

                Hero(
                  tag: "campus_image",
                  child: Image.asset(
                    "assets/Additional/Polosan.png",
                    height: 220,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Create Account",
                  style:
                      GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight:
                        FontWeight.bold,
                    color: Theme.of(context)
        .cardColor,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Start exploring your dream campus",
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.poppins(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  padding:
                      const EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    color: Theme.of(context)
        .cardColor,
                    borderRadius:
                        BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withValues(alpha: 0.1),
                        blurRadius: 20,
                      )
                    ],
                  ),

                  child: Column(
                    children: [

                      _buildField(
                        controller:
                            nameController,
                        hint:
                            "Full Name",
                        icon:
                            Icons.person_outline,
                      ),

                      const SizedBox(height: 18),

                      _buildField(
                        controller:
                            emailController,
                        hint: "Email",
                        icon:
                            Icons.email_outlined,
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller:
                            passwordController,
                        obscureText:
                            hidePassword,

                        decoration:
                            InputDecoration(
                          prefixIcon:
                              const Icon(
                            Icons.lock_outline,
                          ),

                          suffixIcon:
                              IconButton(
                            icon: Icon(
                              hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                hidePassword =
                                    !hidePassword;
                              });
                            },
                          ),

                          hintText:
                              "Password",

                          filled: true,
                          fillColor:
                              Colors.grey.shade100,

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    15),
                            borderSide:
                                BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller:
                            confirmController,
                        obscureText:
                            hideConfirm,

                        decoration:
                            InputDecoration(
                          prefixIcon:
                              const Icon(
                            Icons.lock_outline,
                          ),

                          suffixIcon:
                              IconButton(
                            icon: Icon(
                              hideConfirm
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                hideConfirm =
                                    !hideConfirm;
                              });
                            },
                          ),

                          hintText:
                              "Confirm Password",

                          filled: true,
                          fillColor:
                              Colors.grey.shade100,

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    15),
                            borderSide:
                                BorderSide.none,
                          ),
                        ),
                      ),
const SizedBox(height: 25),

Align(
  alignment: Alignment.centerLeft,
  child: Text(
    "Select Role",
    style: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  ),
),

const SizedBox(height: 15),

Row(
  children: [

    Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedRole = "user";
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: selectedRole == "user"
                ? const Color(0xff2563EB)
                : Colors.grey.shade100,

            borderRadius:
                BorderRadius.circular(18),

            border: Border.all(
              color: selectedRole == "user"
                  ? const Color(0xff2563EB)
                  : Colors.grey.shade300,
            ),
          ),

          child: Column(
            children: [

              Icon(
                Icons.school,
                size: 35,
                color: selectedRole == "user"
                    ? Colors.white
                    : Colors.black87,
              ),

              const SizedBox(height: 10),

              Text(
                "User",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: selectedRole == "user"
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    ),

    const SizedBox(width: 15),

    Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedRole = "admin";
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            color: selectedRole == "admin"
                ? const Color(0xff2563EB)
                : Colors.grey.shade100,

            borderRadius:
                BorderRadius.circular(18),

            border: Border.all(
              color: selectedRole == "admin"
                  ? const Color(0xff2563EB)
                  : Colors.grey.shade300,
            ),
          ),

          child: Column(
            children: [

              Icon(
                Icons.admin_panel_settings,
                size: 35,
                color: selectedRole == "admin"
                    ? Colors.white
                    : Colors.black87,
              ),

              const SizedBox(height: 10),

              Text(
                "Admin",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: selectedRole == "admin"
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ],
),

const SizedBox(height: 30),

                      const SizedBox(height: 30),

                      SizedBox(
                        width:
                            double.infinity,
                        height: 58,

                        child:
                            ElevatedButton(
                          onPressed: () async {

  if (passwordController.text !=
      confirmController.text) {

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content:
            Text("Password tidak sama"),
      ),
    );

    return;
  }

  setState(() {
    isLoading = true;
  });

  String? result =
      await AuthService().register(
    name: nameController.text.trim(),
    email: emailController.text.trim(),
    password:
        passwordController.text.trim(),
    role: selectedRole,
  );

  setState(() {
    isLoading = false;
  });

  if (result == null) {

  ScaffoldMessenger.of(context)
      .showSnackBar(
    const SnackBar(
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
      content: Text(
        "Registrasi berhasil 🎉",
      ),
    ),
  );

  await Future.delayed(
    const Duration(seconds: 2),
  );

  if (!mounted) return;

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) =>
          const LoginScreen(),
    ),
  );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const LoginScreen(),
      ),
    );

  } else {

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(result),
      ),
    );

  }
},
                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                const Color(
                                    0xff2563EB),

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      18),
                            ),
                          ),
                          child: Text(
                            "Create Account",
                            style:
                                GoogleFonts.poppins(
                              color:
                                  Colors.white,
                              fontWeight:
                                  FontWeight
                                      .w600,
                              fontSize: 16,
                            ),
                            
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [

                    Text(
                      "Already have an account?",
                      style:
                          GoogleFonts.poppins(
                        color:
                            Colors.white,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context);
                      },
                      child: Text(
                        "Sign In",
                        style:
                            GoogleFonts.poppins(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,

      decoration: InputDecoration(
        prefixIcon: Icon(icon),

        hintText: hint,

        filled: true,
        fillColor: Colors.grey.shade100,

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}