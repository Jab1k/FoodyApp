import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../controller/home_controller.dart';
import '../style/style.dart';

class MenuListView extends StatelessWidget {
  const MenuListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: context.watch<HomeController>().listOfProduct.length,
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
                      child: context
                                  .watch<HomeController>()
                                  .listOfProduct[index]
                                  .image ==
                              null
                          ? const SizedBox.shrink()
                          : Image.network(
                              context
                                      .watch<HomeController>()
                                      .listOfProduct[index]
                                      .image ??
                                  "",
                              height: 64,
                              width: 64,
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
                            child: Text(context
                                    .watch<HomeController>()
                                    .listOfProduct[index]
                                    .name ??
                                ""),
                          ),
                          4.verticalSpace,
                          Text(
                              context
                                      .watch<HomeController>()
                                      .listOfProduct[index]
                                      .type ??
                                  "",
                              style: Style.textStyleRegular2(
                                  size: 14, textColor: const Color(0xff858C94)))
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 32, top: 22),
                      child: Text(
                          context
                                  .watch<HomeController>()
                                  .listOfProduct[index]
                                  .price
                                  ?.toInt()
                                  .toString() ??
                              "",
                          style: Style.textStyleRegular(
                              size: 29, textColor: Style.primaryColor)),
                    )
                  ],
                ),
              ),
            )));
  }
}
