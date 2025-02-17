import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;

  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool isExpanded = false;
  bool isOverflowing = false;

  final int maxLines = 3; // Define the number of max lines

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkOverflow();
    });
  }

  void _checkOverflow() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width - 70); // Adjust based on padding

    if (textPainter.didExceedMaxLines) {
      setState(() {
        isOverflowing = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text,
                  maxLines: isExpanded ? null : maxLines,
                  overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                if (isOverflowing) // Show "More" and "Close" only if the text overflows
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded; // Toggle the state
                      });
                    },
                    child: Text(
                      isExpanded ? "Less" : "More",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
