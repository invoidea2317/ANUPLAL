import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileComponents extends StatelessWidget {
  final List<String> title;
  final List<String> components;
  final List<Function> componentsFunctions;

  const ProfileComponents(
      {super.key,
      required this.title,
      required this.components,
      required this.componentsFunctions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: title.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        title[index],
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.4000000059604645),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF1F1F1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: components.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 0.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        components[index],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.arrow_forward_ios),
                                        onPressed: componentsFunctions[index]
                                            as void Function()?,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                    visible: index != components.length - 1,
                                    child: Divider())
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
