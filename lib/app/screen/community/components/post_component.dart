import 'package:anuplal/utils/dimensions.dart';
import 'package:anuplal/utils/images.dart';
import 'package:anuplal/utils/sizeboxes.dart';
import 'package:anuplal/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/api_services.dart';
import '../../../widgets/comment_screen.dart';
class PostComponent extends StatefulWidget {
 final  String name;
 final  String title;
 final  String description;
 final  int media_id;
 final String created_at;
 final String image;
 final String postId;
  final String userId;
  const PostComponent({super.key, required this.name, required this.title, required this.description, required this.media_id, required this.created_at, required this.image, required this.postId, required this.userId,});

  @override
  State<PostComponent> createState() => _PostComponentState();
}

class _PostComponentState extends State<PostComponent> {
  final List<dynamic> _comments = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().getComments(widget.postId)!.then((value) {
      debugPrint(value.toString());
      setState(() {
        _comments.addAll(value);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
        color: Color(0xFFF7F7F7),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name,maxLines: 1,overflow: TextOverflow.ellipsis,
                style: poppinsSemiBold.copyWith(fontSize: Dimensions.fontSize14,
              color: Theme.of(context).primaryColor),),
              Text(widget.created_at,maxLines: 1,overflow: TextOverflow.ellipsis,
                style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize12,
                    color: Theme.of(context).hintColor),),
              sizedBoxDefault(),
              Container(
                height: 200,width: Get.size.width,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                ),child: Image.network('https://anup.lab5.invoidea.in/storage/${widget.image}',fit: BoxFit.cover,),
              ),
              sizedBoxDefault(),
              Row(
                children: [
                  Text(widget.title,maxLines: 2,overflow: TextOverflow.ellipsis,
                    style: poppinsSemiBold.copyWith(fontSize: Dimensions.fontSize14,
                        color: Theme.of(context).disabledColor),),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      showCommentSheet(context, userId: widget.userId, postId: widget.postId);
                    },
                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${_comments.length}',style: poppinsMedium.copyWith(fontSize: Dimensions.fontSize14,
                            color: Theme.of(context).primaryColor),),
                        sizedBoxW5(),
                        Image.asset(Images.icComment,height: 24,width: 24,),
                      ],
                    ),
                  ),
                ],
              ),
              Text(widget.description,maxLines: 5,overflow: TextOverflow.ellipsis,
                style: poppinsRegular.copyWith(fontSize: Dimensions.fontSize14,
                    color: Theme.of(context).hintColor),),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
