import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:sizer/sizer.dart';

class ShimmerWidget extends StatefulWidget {
  const ShimmerWidget({Key? key}) : super(key: key);

  @override
  _ShimmerWidgetState createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ListTileShimmer(
        bgColor: Colors.white,
        height: 4.h,
        isDisabledAvatar: true,
        padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
          margin: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
        // isPurplishMode: true,
      ),
      Divider(),
      ListTileShimmer(
        bgColor: Colors.white,
        height: 4.h,
        isDisabledAvatar: true,
        padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
        margin: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
        // isPurplishMode: true,
      ),
      Divider(),
    ]);
  }
}
