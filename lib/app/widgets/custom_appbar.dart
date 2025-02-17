import 'package:anuplal/utils/styles.dart';
import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import '../../utils/sizeboxes.dart';
import '../screen/PostInformation/post_information.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final bool? isPostButtonExist;
  final Function? onBackPressed;
  final Widget? menuWidget;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.isBackButtonExist = false,
    this.menuWidget, this.isPostButtonExist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // toolbarHeight: 200, // You can adjust this height as needed
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor.withOpacity(0.07),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(Dimensions.radius30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              child: Column(
                children: [
                  sizedBox30(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(Images.logo, width: 140),
                                Spacer(),
                                if (menuWidget != null)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSizeDefault),
                                    child: menuWidget!,
                                  ),
                              ],
                            ),
                            SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                if (onBackPressed != null) {
                                  onBackPressed!();
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child: Row(
                                children: [
                                  isBackButtonExist
                                      ? GestureDetector(
                                          onTap: () {
                                            if (onBackPressed != null) {
                                              onBackPressed!();
                                            } else {
                                              Navigator.pop(context);
                                            }
                                          },
                                        child: Icon(
                                           Icons.arrow_back,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                      )
                                      : const SizedBox(width: 0, height: 0),
                                  isBackButtonExist
                                      ? SizedBox(width: 10,)
                                      : const SizedBox(width: 0, height: 0),
                                  Text(
                                    title!,
                                    style: poppinsMedium.copyWith(
                                      color:
                                          Theme.of(context).secondaryHeaderColor,
                                      fontSize: Dimensions.fontSizeDefault,
                                    ),
                                  ),
                                  Spacer(),
                                  Visibility(
                                    visible: isPostButtonExist ?? false,
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      child: ElevatedButton(onPressed: (){
                                        Get.to(() => PostInformation());
                                      }, child: Text("Add Post")),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      centerTitle: false,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).cardColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(100); // Adjusted to match the expanded height
}
