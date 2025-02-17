import 'dart:io';

import 'package:anuplal/app/services/api_services.dart';
import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/helper/route_helper.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../controller/address_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../models/profile_model.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_network_image.dart';
import '../../widgets/underline_textfield.dart';
import '../MapsScreen/maps_screen.dart';

class LocationPickScreen extends StatefulWidget {
  const LocationPickScreen({super.key});

  @override
  State<LocationPickScreen> createState() => _LocationPickScreenState();
}

class _LocationPickScreenState extends State<LocationPickScreen> {
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
    _getAddressFromLatLng(position);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      setState(() {
        _deliveryController.text =
        "${place.street}, ${place.locality}, ${place.country}";
      });
      Get.find<AddressController>().setLong(position.longitude.toString());
      Get.find<AddressController>().setLat(position.latitude.toString());
      Get.find<AddressController>().setAddress(
          "${place.street}, ${place.locality}, ${place.country}");
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

      return SafeArea(
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(125),
            child: CustomAppBar(
              title: 'Register',
              isBackButtonExist: false,
            ),
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
                      sizedBoxDefault(),
                      TextFieldWidget(
                        hintText: 'Name',
                        controller: _usernameController,
                      ),
                      TextFieldWidget(
                        hintText: 'Email Address',
                        controller: _emailController,
                      ),

                      GetBuilder<AddressController>(
                          builder: (logic) {
                            return TextFieldWidget(
                              onPress: () {
                                Get.to(() => MapScreen());
                              },
                              isReadOnly: true,
                              hintText: 'Delivery location',
                              controller: logic.addressController,
                              suffix: Icon(
                                Icons.location_on_sharp,
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                              ),
                            );
                          }),
                    ],
                  ),
                );
              })),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: SingleChildScrollView(
              child: CustomButtonWidget(
                buttonText: 'Save',
                onPressed: () async {
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
                    latitude: Get
                        .find<AddressController>()
                        .lat,
                    longitude: Get
                        .find<AddressController>()
                        .long,
                  );
                  dynamic val = await ApiService().updateProfileApi(
                      profileScreenController, user, 1);
                  if (val != null && val == true) {
                    Get.toNamed(RouteHelper.dashboard);
                  } else {

                  }
                  // Get.back();
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
