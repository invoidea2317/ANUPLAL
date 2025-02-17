import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});
  Future<Map<String, dynamic>> fetchContent() async {
    // Replace with your API endpoint
    const apiUrl = "https://anup.lab5.invoidea.in/api/legal-pages/terms-and-conditions";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Decode the JSON response
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load content");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms and Conditions"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchContent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final content = snapshot.data!["data"]["content"];
            final title = content["title"];
            final description = content["description"];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Html(
                  data: description,
                  style: {
                    "p": Style(textAlign: TextAlign.justify),
                    "strong": Style(color: Colors.black),
                    "span": Style(color: Colors.black),
                  },
                ),
              ),
            );
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}
