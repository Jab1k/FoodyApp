import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/style.dart';

class AkciyaListView extends StatelessWidget {
  const AkciyaListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(left: 12),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: ((context, index) => Container(
              margin: EdgeInsets.only(right: 15),
              height: 180.h,
              width: 380.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24.r)),
                  gradient: Style.linearGradient),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  14.verticalSpace,
                  Image.network(
                    'https://www.pizzaupten.com/wp-content/uploads/2022/02/pizza.png',
                    height: 151.h,
                    width: 166.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      30.verticalSpace,
                      Text('Special Deal for',
                          style: Style.textStyleRegular(
                              size: 23, textColor: Style.whiteColor)),
                      Text('December',
                          style: Style.textStyleRegular(
                              size: 23, textColor: Style.whiteColor)),
                      14.verticalSpace,
                      Container(
                        width: 120.w,
                        height: 37.h,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius:
                                BorderRadius.all(Radius.circular(32))),
                        child: Center(
                          child: Text('Buy Now',
                              style: Style.textStyleRegular(
                                  size: 14, textColor: Style.whiteColor)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
