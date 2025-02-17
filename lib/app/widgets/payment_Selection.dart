import 'package:flutter/material.dart';

class PaymentOptionsScreen extends StatefulWidget {
  final Function(bool isCodSelected, bool isPayOnlineSelected) onPaymentOptionSelected;

  const PaymentOptionsScreen({super.key, required this.onPaymentOptionSelected});

  @override
  _PaymentOptionsScreenState createState() => _PaymentOptionsScreenState();
}

class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
  bool isCodSelected = false;
  bool isPayOnlineSelected = false;

  @override
  Widget build(BuildContext context) {
    // Define colors for the checked state
    Color checkedColor = Colors.green; // Color for the checked state
    Color checkMarkColor = Colors.white; // Color of the check mark

    return Scaffold(

      body: Column(
        children: [
          CheckboxListTile(
            title: const Text('COD (Cash on Delivery)'),
            value: isCodSelected,
            activeColor: checkedColor, // Color for the checked state
            checkColor: checkMarkColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            side: const BorderSide(color: Colors.green),// Color of the check mark
            onChanged: (bool? value) {
              if (value == true) {
                setState(() {
                  isCodSelected = true;
                  isPayOnlineSelected = false; // Deselect Pay Online
                });
              }
              widget.onPaymentOptionSelected(isCodSelected, isPayOnlineSelected);
            },
            controlAffinity: ListTileControlAffinity.trailing,
          ),
          CheckboxListTile(
            title: const Text('Pay Online'),
            value: isPayOnlineSelected,
            activeColor: checkedColor, // Color for the checked state
            checkColor: checkMarkColor,
            // Tick color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            side: const BorderSide(color: Colors.green),// Color of the check mark
            onChanged: (bool? value) {
              if (value == true) {
                setState(() {
                  isPayOnlineSelected = true;
                  isCodSelected = false; // Deselect COD
                });
              }
              widget.onPaymentOptionSelected(isCodSelected, isPayOnlineSelected);
            },
            controlAffinity: ListTileControlAffinity.trailing,
          ),
        ],
      ),
    );
  }
}
