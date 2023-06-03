import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// Product model that user will see
class BuildProductItemContainer extends StatelessWidget {
  const BuildProductItemContainer({
    Key? key,
    required this.productName,
    required this.productDetail,
    required this.onTap,
  }) : super(key: key);

  final String productName;
  final String productDetail;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      color: Colors.grey,
      margin: EdgeInsets.all(5.sp),
      child: ListTile(
        onTap: onTap,
        title: Text(productName),
        subtitle: Text(productDetail),
      ),
    );
  }
}
