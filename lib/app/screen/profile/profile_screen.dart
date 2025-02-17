import 'dart:io';

import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/app/widgets/custom_buttons.dart';
import 'package:anuplal/app/widgets/custom_network_image.dart';
import 'package:anuplal/app/widgets/underline_textfield.dart';
import 'package:anuplal/controller/address_controller.dart';
import 'package:anuplal/controller/profile_controller.dart';
import 'package:anuplal/utils/app_constants.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../helper/route_helper.dart';
import '../../models/profile_model.dart';
import '../../services/api_services.dart';
import '../MapsScreen/maps_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _usernameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _deliveryController = TextEditingController();

  ProfileController profileController = Get.put(ProfileController());

  Future<void> _setInitialLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, you may want to handle this
      return;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _getAddressFromLatLng(Get.find<ProfileController>().profile.latitude,Get.find<ProfileController>().profile.longitude);
  }

  Future<void> _getAddressFromLatLng(String? latitude,String? longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
       double.parse(latitude ?? ""),
        double.parse(longitude ?? ""),
      );
      Placemark place = placemarks[0];
      setState(() {
        _deliveryController.text =
        "${place.street}, ${place.locality}, ${place.country}";
      });
      Get.find<AddressController>().setLong(longitude.toString());
      Get.find<AddressController>().setLat(latitude.toString());
      Get.find<AddressController>().setAddress("${place.street}, ${place.locality}, ${place.country}");
    } catch (e) {
      print(e);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setInitialLocation();
    profileController.getProfileInfo(profileController);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileScreenController) {
      if (profileScreenController.profile.phone.isEmpty &&
          _deliveryController.text.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      _usernameController.text = profileScreenController.profile.name;
      _phoneController.text = profileScreenController.profile.phone;
      _emailController.text = profileScreenController.profile.email ?? "";

      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(125),
            child: CustomAppBar(
              title: 'Account', isBackButtonExist: true, menuWidget: Row(
              children: [
                CustomButtonWidget(
                  width: 75,
                  height: 25,
                  isBold: false,
                  buttonText: 'Save',
                  onPressed: () {
                    User user = User(
                      id: profileScreenController.profile.id,
                      phone: _phoneController.text,
                      email: _emailController.text,
                      name: _usernameController.text,
                      phoneVerified: true,
                      emailVerified: true,
                      isActive: true,
                      profilePhoto: profileScreenController.profile
                          .profilePhoto,
                      dateOfBirth: '',
                      country: '',
                      phoneCode: '',
                      latitude: Get.find<AddressController>().lat,
                      longitude: Get.find<AddressController>().long,
                    );
                    dynamic val = ApiService().updateProfileApi(
                        profileScreenController, user);
                  },
                ),
                SizedBox(width: 10,),
              ],
            ),),
          ),
          body: SingleChildScrollView(
              child: GetBuilder<ProfileController>(builder: (profileControl) {
                return Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Column(
                    children: [
                      sizedBox20(),
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage("assets/images/Avatar.png"),
                      ),
                      // Center(
                      //   child: Container(
                      //     height: 150,
                      //     width: 150,
                      //     clipBehavior: Clip.hardEdge,
                      //     decoration: BoxDecoration(shape: BoxShape.circle,
                      //       border: Border.all(width: 0.5,
                      //         color: Theme
                      //             .of(context)
                      //             .primaryColor
                      //             .withOpacity(0.40),),
                      //       color: Theme
                      //           .of(context)
                      //           .primaryColor
                      //           .withOpacity(0.1),
                      //     ),
                      //     // alignment: Alignment.center,
                      //     child: profileControl.pickedImage != null ? Image.file(
                      //       File(profileControl.pickedImage!.path,), height: 90,
                      //       width: 90,
                      //       fit: BoxFit.cover,
                      //     ) : Stack(
                      //       children: [
                      //         Container(
                      //             height: 150,
                      //             width: 150,
                      //             clipBehavior: Clip.hardEdge,
                      //             decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               color: Theme
                      //                   .of(context)
                      //                   .primaryColor
                      //                   .withOpacity(0.1),
                      //             ),
                      //             child:
                      //             CustomNetworkImageWidget(
                      //               imagePadding: Dimensions.paddingSize40,
                      //               height: 150,
                      //               width: 150,
                      //               image: profileScreenController.profile.profilePhoto,
                      //               placeholder: Images.icGallery,
                      //               fit: BoxFit.cover,)
                      //         ),
                      //         // Image.asset(Images.profilePlaceholder,)
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      sizedBoxDefault(),
                      TextFieldWidget(
                        hintText: 'Username', controller: _usernameController,),
                      TextFieldWidget(
                        hintText: 'Email Address',
                        controller: _emailController,),

                      GetBuilder<AddressController>(
                          builder: (logic) {
                            return TextFieldWidget(
                              onPress: () {
                                debugPrint("Phone number pressed");
                                Get.to(() => MapScreen());
                              },
                              isReadOnly: true,
                              hintText: 'Delivery location',
                              controller: logic.addressController,
                              suffix: Icon(Icons.location_on_sharp, color: Theme
                                  .of(context)
                                  .primaryColor,),);
                          }),

                    ],
                  ),
                );
              })
          ),
          // bottomNavigationBar: Padding(
          //   padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          //   child: SingleChildScrollView(
          //     child: CustomButtonWidget(buttonText: 'Logout',
          //       color: Colors.red,
          //       borderSideColor: Colors.red,
          //       onPressed: () async {
          //         await ApiService().logOutApi();
          //       },),
          //   ),
          // ),
        ),
      );
    });
  }
}
