import 'package:anuplal/app/models/crop_doctor_model.dart';
import 'package:anuplal/app/services/api_services.dart';
import 'package:anuplal/app/widgets/custom_appbar.dart';
import 'package:anuplal/app/widgets/custom_button_widget.dart';
import 'package:anuplal/app/widgets/custom_buttons.dart';
import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CropDoctorScreen extends StatefulWidget {
  const CropDoctorScreen({super.key});

  @override
  State<CropDoctorScreen> createState() => _CropDoctorScreenState();
}

class _CropDoctorScreenState extends State<CropDoctorScreen> {

  CropDoctorModel cropDoctorModel = CropDoctorModel();

  @override
  void initState() {

     ApiService().getCropDoctor().then((value) {
       if(value.toString().trim()!="Failed to load get crop doctor") {
        setState(() {
          cropDoctorModel = value;
        });
        debugPrint("Crop Doctor Model: ${cropDoctorModel.toJson()}");
      }
    });
    super.initState();
  }

  Future<void> openWhatsAppChat(String phoneNumber) async {
    String formattedNumber = phoneNumber.startsWith('+91') ? phoneNumber : '+91$phoneNumber';
    String url = "https://wa.me/$formattedNumber"; // Keep this for web, but check with whatsapp:// scheme for direct app opening

    await launchUrl(Uri.parse(url));
  }
  Future<void> makeACall(String phoneNumber) async {
    String formattedNumber = phoneNumber.startsWith('+91') ? phoneNumber : '+91$phoneNumber';
     // Keep this for web, but check with whatsapp:// scheme for direct app opening
     debugPrint("Formatted Number: $formattedNumber");
    await launchUrl(Uri(
      scheme: 'tel',
      path: phoneNumber,
    ));
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: CustomAppBar(
            isBackButtonExist: true,
            title: 'Crop Doctor',
            menuWidget: Row(
              children: [
                CustomNotificationButton(
                  tap: () {},
                ),
                sizedBoxW10(),
                CustomCartButton(
                  tap: () {},
                ),
              ],
            ),
            isPostButtonExist: false,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Got crop concerns?',style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
              sizedBox4(),
              Text('Our crop doctors are here to diagnose issues, recommend treatments, and ensure your crops thrive. Just a click away!',
                style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,color: Theme.of(context).hintColor),),
              Image.asset(Images.icCropDoctor,height: 180,),
            ],
          ),
        ),
        bottomNavigationBar: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
            child: Column(children: [
              CustomButtonWidget(
                isBold: false,
                buttonText: " Message issue",
                transparent: true,
                icon: Icons.chat,
                onPressed: () {
                  openWhatsAppChat(cropDoctorModel.whatsappNumber.toString());
                },
              ),
              sizedBoxDefault(),
              CustomButtonWidget(
                isBold: false,
                buttonText: "Call the Expert",
                gradient: const LinearGradient(
                  colors: [Color(0xff739a2b), Color(0xff4c5829)],
                  stops: [0.2, 1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                useGradient: true,
                icon: Icons.call,
                onPressed: () {
                  makeACall(cropDoctorModel.expertMobileNumber.toString());
                },
              ),
            ],),
          ),
        ),
      ),
    );
  }
}
