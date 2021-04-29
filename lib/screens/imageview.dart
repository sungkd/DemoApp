import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {

  final dynamic imgUrl;

  const ImageView({this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Pet Detail'),
        centerTitle: true,
      ),
      body: CachedNetworkImage(
        placeholder: (context, url) => CircularProgressIndicator(
          backgroundColor: Colors.grey[600],
          strokeWidth: 2,
        ),
        imageUrl: imgUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
