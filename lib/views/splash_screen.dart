import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:notedo_app/controllers/getx/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController splashController =
        Get.put<SplashController>(SplashController());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/Anim2.json'),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            const SizedBox(height: 30),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'NoteDo App',
                  textStyle: GoogleFonts.poppins(
                    fontSize: 24,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
              totalRepeatCount: 4,
              pause: Duration(milliseconds: 2000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ],
        ),
      ),
    );
  }
}
