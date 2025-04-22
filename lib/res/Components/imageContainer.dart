import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Imagecontainer extends StatelessWidget {
  String imgurl;
  Imagecontainer({super.key,required this.imgurl});
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3,vertical: 3),
      child: Container(
        height: 80,
        width: 60,
        decoration: BoxDecoration(
          color: Color.fromRGBO(210, 210, 210, 1.0),
          borderRadius: BorderRadius.circular(10),


        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imgurl,
            placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Colors.black,)),
            errorWidget: (context, url, error) => Image.asset('asset/images/noimage.jpg'),
            fit: BoxFit.cover,
          )
        ),


      ),
    );
    
  }
}
