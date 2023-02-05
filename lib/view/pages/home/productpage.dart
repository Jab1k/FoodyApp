import 'package:flutter/material.dart';
import 'package:jabikfoodyapp/view/pages/auth/splash_screen.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../../../controller/user_controller.dart';
import '../../components/custom_textform.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final TextEditingController search = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeController>()
        ..getProduct(isLimit: false)
        ..getCategory(isLimit: false)
        ..getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeController>();
    final event = context.read<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFrom(
                    controller: search,
                    label: "Search",
                    onchange: (s) {},
                    hintext: '',
                  ),
                ),
                IconButton(
                    onPressed: () {
                      event.setFilterChange();
                    },
                    icon: Icon(Icons.menu)),
                IconButton(
                    onPressed: () {
                      context.read<UserController>().logOut(() {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => SplashScreen()),
                            (route) => false);
                      });
                    },
                    icon: Icon(Icons.logout)),
              ],
            ),
          ),
          state.setFilter || (state.selectIndex == -1)
              ? const SizedBox.shrink()
              : Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 50,
                            offset: const Offset(0, 6),
                            color: const Color(0xff5A6CEA).withOpacity(0.08))
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      color: Colors.white),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child:
                      Text(state.listOfCategory[state.selectIndex].name ?? ""),
                ),
          Expanded(
            child: state.setFilter
                ? Wrap(
                    children: [
                      for (int i = 0; i < state.listOfCategory.length; i++)
                        InkWell(
                          onTap: () {
                            event.changeIndex(i);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 50,
                                      offset: const Offset(0, 6),
                                      color: const Color(0xff5A6CEA)
                                          .withOpacity(0.08))
                                ],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                color: Colors.white),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            child: Text(state.listOfCategory[i].name ?? ""),
                          ),
                        )
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        context.watch<HomeController>().listOfProduct.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(16),
                        width: double.infinity,
                        height: 90,
                        color: Colors.pinkAccent,
                        child: Row(
                          children: [
                            state.listOfProduct[index].image == null
                                ? const SizedBox.shrink()
                                : Image.network(
                                    state.listOfProduct[index].image ?? "",
                                    height: 200,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                      state.listOfProduct[index].name ?? ""),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(state.listOfProduct[index].price.toString()),
                            IconButton(
                                onPressed: () {
                                  event.changeLike(index);
                                },
                                icon: (state.listOfProduct[index].isLike)
                                    ? Icon(Icons.favorite)
                                    : Icon(Icons.favorite_border))
                          ],
                        ),
                      );
                    }),
          )
        ],
      ),
    );
  }
}
