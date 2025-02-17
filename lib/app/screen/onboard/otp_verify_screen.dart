import 'dart:async';
import 'package:anuplal/helper/route_helper.dart';
import 'package:get/get.dart';
import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../controller/authentication_controller.dart';



class OtpVerificationScreen extends StatefulWidget {
  final String? phoneNo;
  OtpVerificationScreen({super.key, this.phoneNo});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  Timer? _timer;
  int _remainingTime = 60;
  bool _isResendEnabled = false;
  final LoginController loginController = Get.put(LoginController());


  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isResendEnabled = false;
      _remainingTime = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _isResendEnabled = true;
          _timer?.cancel();
        }
      });
    });
  }

  void _resendOtp() {
    if (_isResendEnabled) {
      _startTimer();
    }
  }


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
                  padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Ensures content is compact
                    children: [
                      Text('VERIFY OTP',style: poppinsSemiBold.copyWith(
                          fontSize: Dimensions.fontSize24,
                          color: Theme.of(context).primaryColor
                      ),),
                      sizedBox10(),
                      Text('Verify OTP Received on Your Number',style: poppinsMedium.copyWith(
                          fontSize: Dimensions.fontSize14,
                          color: Theme.of(context).disabledColor.withOpacity(0.70)
                      ),),
                      sizedBox10(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSize25),
                        child: PinCodeTextField(
                          length: 4,
                          appContext: context,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.slide,
                          controller: _otpController,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            fieldHeight: 50,
                            fieldWidth: 50,
                            borderWidth: 1,
                            activeBorderWidth: 1,
                            inactiveBorderWidth: 1,
                            errorBorderWidth: 1,
                            selectedBorderWidth: 1,
                            borderRadius: BorderRadius.circular(Dimensions.radius10),
                            selectedColor: Theme.of(context).primaryColor.withOpacity(0.1),
                            selectedFillColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            inactiveColor: Theme.of(context).primaryColor,
                            activeColor: Theme.of(context).primaryColor,
                            activeFillColor: Colors.white,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          validator: (value) {
                            if (_otpController.text.length != 4) {
                              return 'Please enter a valid 4-digit OTP';
                            }
                            return null;
                          },
                          beforeTextPaste: (text) => true,
                        ),
                      ),
                      GestureDetector(
                        onTap: _isResendEnabled ? _resendOtp : null,
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "If you didn’t receive a code. ",
                                  style: poppinsRegular.copyWith(
                                    fontSize: Dimensions.fontSize12,
                                    color: Theme.of(context).disabledColor.withOpacity(0.40),
                                  ),
                                ),
                                TextSpan(
                                  text: _isResendEnabled
                                      ? "Resend"
                                      : "Resend in $_remainingTime seconds",
                                  style: poppinsBold.copyWith(
                                    fontSize: Dimensions.fontSize12,
                                    color: _isResendEnabled
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      sizedBox30(),
                      sizedBox30(),
                      Obx(
                            () => loginController.isLoading.value
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                          ],
                        )
                            :   CustomButtonWidget(
                              buttonText: "Continue",
                              gradient: const LinearGradient(
                                colors: [Color(0xff739a2b), Color(0xff4c5829)],
                                stops: [0.2, 1],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              useGradient: true,
                              onPressed: () {
                                if(_formKey.currentState!.validate()) {
                                  loginController.otpVerify(widget.phoneNo!,_otpController.text);


                                }
                              },
                            ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Positioned(top: Dimensions.paddingSize50,
                left: Dimensions.paddingSize75,right: Dimensions.paddingSize75,
                child: Image.asset(Images.logo,height: 140,)),
          ],
        ),
      ),
    );
  }
}

