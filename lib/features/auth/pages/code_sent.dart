import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:krishi_vikas/utils/colors.dart';
import 'package:page_transition/page_transition.dart';
import '../../../components/my_buttons.dart';
import '../models/user_model.dart';
import '../services/auth_services.dart';
import 'verify_email.dart';

final loadingProvider = StateProvider.autoDispose<bool>((ref) => false);

class CodeSent extends ConsumerWidget {
  CodeSent({super.key, required this.userData});
  UserModel userData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80.h),
                Text("Code Sent!",
                    style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(height: 40.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "A six digits code has been sent to your email ${userData.email}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.h, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 40.h),
                MyOutlinedButton(
                  text: "Change Email",
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 20.h),
                FilledButton(
                  onPressed: () async {
                    HapticFeedback.mediumImpact();
                    ref.read(loadingProvider.notifier).state = true;

                    // Submit token to the user
                    await AuthService().sendOTP(userData);

                    ref.read(loadingProvider.notifier).state = false;
                    Navigator.push(
                        context,
                        PageTransition(
                            child: VerifyEmail(userData: userData),
                            type: PageTransitionType.rightToLeftWithFade,
                            curve: Curves.easeInOutBack,
                            duration: const Duration(milliseconds: 500)));
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor: primary_green,
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Center(
                    child: Consumer(builder: (context, ref, child) {
                      bool loading = ref.watch(loadingProvider);
                      return loading
                          ? SpinKitCircle(color: Colors.white,)
                          : const Text("Get OTP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold));
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
