import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final Function? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final bool isLoading;
  final bool isBold;
  final Color? borderSideColor;
  final bool useGradient; // Flag to indicate if gradient should be used
  final LinearGradient? gradient; // Gradient property

  const CustomButtonWidget({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.transparent = false,
    this.margin,
    this.width,
    this.height,
    this.fontSize,
    this.radius = 10,
    this.icon,
    this.color,
    this.textColor,
    this.isLoading = false,
    this.isBold = true,
    this.borderSideColor,
    this.useGradient = false, // Default is false
    this.gradient, // Gradient
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: useGradient
          ? Colors.transparent // If gradient is used, background is transparent
          : onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
          ? Colors.transparent
          : color ?? Theme.of(context).primaryColor,
      minimumSize: Size(width ?? Dimensions.webMaxWidth, height ?? 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: useGradient
            ? BorderSide.none // No border if gradient is used
            : BorderSide(
          color: borderSideColor ?? Theme.of(context).primaryColor, // Border color
          width: 1, // Border width
        ),
      ),
    );

    return Center(
      child: SizedBox(
        width: width ?? Dimensions.webMaxWidth,
        child: Padding(
          padding: margin ?? const EdgeInsets.all(0),
          child: Container(
            decoration: useGradient
                ? BoxDecoration(
              gradient: gradient ??
                  LinearGradient(
                    colors: [Color(0xffd78f67), Color(0xffbb4a19)],
                    stops: const [0, 1],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
              borderRadius: BorderRadius.circular(radius),
            )
                : null, // No decoration if gradient is not used
            child: TextButton(
              onPressed: isLoading ? null : onPressed as void Function()?,
              style: flatButtonStyle,
              child: isLoading
                  ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    ),
                    const SizedBox(width: Dimensions.paddingSize10),
                    Text('Loading', style: poppinsMedium.copyWith(color: Colors.white)),
                  ],
                ),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Icon(
                        icon,
                        color: transparent
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).cardColor,
                        size: Dimensions.fontSizeDefault,
                      ),
                    ),
                  sizedBoxW5(),
                  Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    style: isBold
                        ? poppinsBold.copyWith(
                      color: textColor ??
                          (transparent ? Theme.of(context).primaryColor : Colors.white),
                      fontSize: fontSize ?? Dimensions.fontSize18,
                    )
                        : poppinsRegular.copyWith(
                      color: textColor ??
                          (transparent ? Theme.of(context).primaryColor : Colors.white),
                      fontSize: fontSize ?? Dimensions.fontSize18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
