import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: 58,

      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color(0xff2563EB),

          elevation: 5,

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(18),
          ),
        ),

        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child:
                    CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style:
                    GoogleFonts.poppins(
                  color: Theme.of(context)
        .cardColor,
                  fontSize: 16,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
      ),
    );
  }
}