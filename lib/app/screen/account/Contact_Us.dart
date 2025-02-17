import 'package:anuplal/app/models/contactUsModel.dart';
import 'package:anuplal/app/services/api_services.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_appbar.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  late ContactInfo contactInfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().getContactInfo().then((value) {
      if (value.toString().trim() != "Failed to load get contact us") {
        debugPrint("Contact Us Model: $value");
        setState(() {
          contactInfo = value;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(125),
            child: CustomAppBar(
              title: 'Contact Us',
              isBackButtonExist: true,
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/contactUsScreenLogo.png'),
                    width: 86,
                  ),
                ],
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: const Color(0x33739A2B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment:   CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                       const Image(image: AssetImage('assets/images/locationIcon.png'),width: 20,),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Address',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0.08,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                         "Lorem ipsum dolor sit amet, consectet adipisc elit. Sed do eiusmod tempor incididunt ut labore et",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        const Image(image: AssetImage('assets/images/email.png'),width: 20,),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Email',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0.08,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          contactInfo.email,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        const Image(image: AssetImage('assets/images/phone.png'),width: 20,),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0.08,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          contactInfo.phone,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Follow On',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 16,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                height: 0.08,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  // Add action here
                                },
                                child: Image.asset("assets/images/Facebook.png",scale: 3,)),
                            const SizedBox(width: 10,),
                            GestureDetector(
                                onTap: () {
                                  // Add action here
                                },
                                child: Image.asset("assets/images/Instagram.png",scale: 3,)),
                            const SizedBox(width: 10,),
                            GestureDetector(
                                onTap: () {
                                  // Add action here
                                },
                                child: Image.asset("assets/images/Twitter.png",scale: 3,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
              const SizedBox(
                height: 130,
              ),
            ],
          )),
    );
  }
}
//img_crop_doctor.png
