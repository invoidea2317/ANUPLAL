import 'dart:convert';
import 'dart:developer';

import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../helper/route_helper.dart';
import '../../models/product_model_new/product_model_new.dart';
import '../../services/api_services.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  final String lat;
  final String long;

  const SearchScreen({super.key, required this.lat, required this.long});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ProductResponse productResponse = ProductResponse(products: []);
  bool isLoading = false;


  Future<Map<String, dynamic>> fetchContent(
      {required String lat,
      required String long,
      required String title}) async {

    setState(() {
      isLoading = true;
      productResponse = ProductResponse(products: []);
    });

    // Replace with your API endpoint
    const apiUrl = "https://anup.lab5.invoidea.in/api/search-product";

    var body = {"latitude": lat, "longitude": long, "title": title};

    final response = await http.post(Uri.parse(apiUrl), body: body);

    if (response.statusCode == 200) {
      // Decode the JSON response
      Map<String, dynamic> data = json.decode(response.body);
      log("${json.decode(response.body)}", name: "fetchContent");
      setState(() {
        productResponse =
            ProductResponse.fromMap(data["data"] as Map<String, dynamic>);
        isLoading = false;
      });
      // productResponse = ProductResponse.fromJson(data["data"]["products"].toString());
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load content");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Search Screen"),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      if(value.trim().isEmpty){
                        return;
                      } else {
                      fetchContent(
                          lat: widget.lat, long: widget.long, title: value.trim());}
                    },
                    decoration: const InputDecoration(
                      enabled: true,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(),
                      hintText: "Search",
                    ),
                  ),
                ),
                Visibility(
                  visible: productResponse.products.isNotEmpty && !isLoading,
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1))
                                ]),
                            child: ListTile(
                              onTap: () {
                                debugPrint("Product Clicked");
                                Get.find<HomeScreenController>().fetchParticularDetails(controller, productResponse.products[index].id.toString(), productResponse.products[index].shopId.toString());
                                Get.toNamed(RouteHelper.getProductDetailRoute());
                              },
                              leading: Image.network(
                                  "${ApiService().imageBaseUrlMain}${productResponse.products[index].media?.src ?? ""}"),
                              title: Text(productResponse.products[index].name),
                              subtitle: Text(
                               "₹ ${productResponse.products[index].price}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: productResponse.products.length),
                ),

                Visibility(
                  visible: productResponse.products.isEmpty && isLoading,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),


                Visibility(
                  visible: productResponse.products.isEmpty && !isLoading,
                  child: const Center(
                    child: Text("No data available"),
                  ),
                )

              ],
            ));
      }
    );
  }
}
