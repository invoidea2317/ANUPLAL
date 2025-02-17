import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/material.dart';


class BottomNavItem extends StatelessWidget {
  final String img;
  final Function? tap;
  final bool isSelected;
  final String title;


  const BottomNavItem({super.key, required this.img, this.tap, this.isSelected = false, required this.title,});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:  GestureDetector(
            onTap:tap as void Function()?,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(Dimensions.paddingSize8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? Theme.of(context).cardColor : Theme.of(context).primaryColor
                      ),
                      child: Image.asset(img,height: 28,width: 28,color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).cardColor)),
                  Text(title,style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize10,color:isSelected ? Theme.of(context).cardColor : Theme.of(context).cardColor ),)
                ],
              ),
            ))
    );
  }
}
