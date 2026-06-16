import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register_screen.dart';
import '../../services/login_service.dart';
import '../admin/admin_dashboard_screen.dart';
import '../user/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool hidePassword = true;

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
                  "Welcome Back",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight:
                        FontWeight.bold,
                    color: Theme.of(context)
        .cardColor,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Sign in to continue exploring campuses",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
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

                      TextField(
                        controller:
                            emailController,

                        decoration:
                            InputDecoration(
                          hintText: "Email",

                          prefixIcon:
                              const Icon(
                            Icons.email_outlined,
                          ),

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

                      const SizedBox(height: 20),

                      TextField(
                        controller:
                            passwordController,
                        obscureText:
                            hidePassword,

                        decoration:
                            InputDecoration(
                          hintText:
                              "Password",

                          prefixIcon:
                              const Icon(
                            Icons.lock_outline,
                          ),

                          suffixIcon:
                              IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword =
                                    !hidePassword;
                              });
                            },
                            icon: Icon(
                              hidePassword
                                  ? Icons
                                      .visibility_off
                                  : Icons
                                      .visibility,
                            ),
                          ),

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

                      const SizedBox(height: 10),

                      Align(
                        alignment:
                            Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style:
                                GoogleFonts.poppins(
                              color:
                                  const Color(
                                      0xff2563EB),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      SizedBox(
                        width:
                            double.infinity,
                        height: 58,

                        child:
                            ElevatedButton(
                          onPressed: ()  async {

  final userData =
      await LoginService().login(
    email: emailController.text.trim(),
    password: passwordController.text.trim(),
  );

  if (userData == null) {

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Email atau password salah",
        ),
      ),
    );

    return;
  }

  String role =
      userData["role"] ?? "user";

  if (!mounted) return;

  if (role == "admin") {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            AdminDashboardScreen(),
      ),
    );

  } else {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            HomeScreen(),
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
                            "Sign In",
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

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [

                    Text(
                      "Don't have an account?",
                      style:
                          GoogleFonts.poppins(
                        color:
                            Colors.white,
                      ),
                    ),

                    TextButton(
                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const RegisterScreen(),
                          ),
                        );

                      },
                      child: Text(
                        "Sign Up",
                        style:
                            GoogleFonts.poppins(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}