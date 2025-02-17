import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/app/widgets/custom_textfield.dart';
import 'package:anuplal/helper/route_helper.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/authentication_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _phoneController = TextEditingController();

  // final  _passwordController= TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                Images.authBg,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    // Ensures content is compact
                    children: [
                      Text(
                        'LOGIN',
                        style: poppinsSemiBold.copyWith(
                            fontSize: Dimensions.fontSize24,
                            color: Theme.of(context).primaryColor),
                      ),
                      sizedBox10(),
                      Text(
                        'Verify Your Number to Login',
                        style: poppinsMedium.copyWith(
                            fontSize: Dimensions.fontSize14,
                            color: Theme.of(context)
                                .disabledColor
                                .withOpacity(0.70)),
                      ),
                      CustomTextField(
                        isNumber: true,
                        inputType: TextInputType.number,
                        controller: _phoneController,
                        isPhone: true,
                        hintText: "Enter your mobile number here",
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Phone No';
                          } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Please enter a valid 10-digit Phone No';
                          }
                          return null;
                        },
                      ),
                      sizedBox30(),
                      const SizedBox(height: 20),
                      Obx(
                        () => loginController.isLoading.value
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(),
                              ],
                            )
                            : CustomButtonWidget(
                                buttonText: "Continue",
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff739a2b),
                                    Color(0xff4c5829)
                                  ],
                                  stops: [0.2, 1],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                useGradient: true,
                                onPressed: () {
                                  loginController.login(_phoneController.text);
                                  Obx(() => Text(
                                        loginController.loginResponse.isNotEmpty
                                            ? 'Response: ${loginController.loginResponse}'
                                            : '',
                                      ));
                                  // if (_formKey.currentState!.validate()) {
                                  //   Get.toNamed(
                                  //       RouteHelper.getOtpVerificationRoute(
                                  //           _phoneController.text));
                                  // }
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: Dimensions.paddingSize50,
                left: Dimensions.paddingSize75,
                right: Dimensions.paddingSize75,
                child: Image.asset(
                  Images.logo,
                  height: 140,
                )),
          ],
        ),
      ),
    );
  }
}
