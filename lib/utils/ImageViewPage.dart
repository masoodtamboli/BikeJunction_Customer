import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'MyColors.dart';

class ImageViewPage extends StatefulWidget {
  File imageFile;
  ImageViewPage(this.imageFile);
  @override
  _ImageViewPageState createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  Container(
          child: Hero(
            tag: "image",
            child: PhotoView(
              imageProvider: FileImage(widget.imageFile),
            ),
          ),
        ),
      ),
    );
  }
  Widget toolbar() {
    return Container(
      color: MyColors.screen_background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //back arrow
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                    child: Icon(
                      Icons.arrow_back,
                      size: 24.0,
                    )),
              ),
              //Header
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                child: Text(
                  "Selected Dent image",
                  style: TextStyle(
                    color: MyColors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
