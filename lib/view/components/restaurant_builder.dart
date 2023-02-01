import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/style.dart';

class RestaurantListview extends StatelessWidget {
  const RestaurantListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only( left: 24),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: ((context, index) => Container(
              margin: EdgeInsets.only(left: 10.w),
              width: 160.w,
              height: 184.h,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 50,
                        offset: const Offset(0, 6),
                        color: const Color(0xff5A6CEA).withOpacity(0.08))
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(24))),
              child: Column(
                children: [
                  24.verticalSpace,
                  const Icon(Icons.restart_alt),
                  24.verticalSpace,
                  Text('Restaurant name',
                      style: Style.textStyleRegular(
                          size: 18, textColor: Style.blackColor)),
                  4.verticalSpace,
                  Text('15 min',
                      style: Style.textStyleRegular2(
                          size: 14, textColor: const Color(0xff6D7580))),
                ],
              ),
            )));
  }
}
