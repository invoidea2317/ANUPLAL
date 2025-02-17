import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextFieldWidget extends StatelessWidget {
  final String? title;
  final String hintText;
  final TextEditingController? controller;
  final Function()? onPress;
  final String? Function(String?)? onChanged;
  final Widget? prefix;
  final Widget? suffix;
  final bool? enable;
  final bool? obscureText;
  final int? maxLine;
  final int? maxLength;

  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validation;
  final bool? isReadOnly;

  const TextFieldWidget({
    super.key,
    this.textInputType,
    this.enable,
    this.prefix,
    this.suffix,
    this.title,
    required this.hintText,
    required this.controller,
    this.onPress,
    this.maxLine,
    this.inputFormatters,
    this.obscureText,
    this.onChanged,
    this.validation, this.isReadOnly, this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: title != null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    title ?? '',
                    style: poppinsRegular,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          TextFormField(
            onTap: onPress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: textInputType ?? TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            controller: controller,
            textAlign: TextAlign.start,
            maxLines: maxLine ?? 1,
            textInputAction: TextInputAction.done,
            inputFormatters: inputFormatters,
            obscureText: obscureText ?? false,
            validator: validation,
            onChanged: onChanged,
            style: poppinsRegular,
            readOnly: isReadOnly ?? false,
            maxLength: maxLength,
            decoration: InputDecoration(
              errorStyle: const TextStyle(color: Colors.red),
              isDense: true,
              filled: false, // Set filled to false for underline
              enabled: enable ?? true,
              contentPadding: EdgeInsets.symmetric(
                  vertical: 14, horizontal: prefix != null ? 0 : 10),
              prefixIcon: prefix,
              suffixIcon: suffix,
              // Use the below properties to achieve underline decoration
              focusedBorder:  UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              enabledBorder:  UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              errorBorder:  UnderlineInputBorder(
                borderSide: BorderSide(color:  Theme.of(context).primaryColor),
              ),
              hintText: hintText,
              hintStyle: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).hintColor),
            ),
          ),
        ],
      ),
    );
  }
}