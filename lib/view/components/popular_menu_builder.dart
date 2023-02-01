import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../style/style.dart';

class MenuListView extends StatelessWidget {
  const MenuListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: ((context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                margin: const EdgeInsets.only(bottom: 30),
                height: 88.h,
                width: 380.w,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 50,
                          offset: const Offset(0, 6),
                          color: const Color(0xff5A6CEA).withOpacity(0.08))
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: Colors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    12.horizontalSpace,
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        height: 64.h,
                        width: 64.w,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://www.pngplay.com/wp-content/uploads/8/Large-Tofu-Burger-Transparent-Images.png'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    20.horizontalSpace,
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text('Spicy Burger',
                                style: Style.textStyleRegular()),
                          ),
                          4.verticalSpace,
                          Text('Title',
                              style: Style.textStyleRegular2(
                                  size: 14, textColor: const Color(0xff858C94)))
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 32, top: 22),
                      child: Text('\$25',
                          style: Style.textStyleRegular(
                              size: 29, textColor: Style.primaryColor)),
                    )
                  ],
                ),
              ),
            )));
  }
}
