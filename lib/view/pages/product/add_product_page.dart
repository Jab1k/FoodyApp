import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../controller/product_controller.dart';
import '../../components/custom_textform.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameTextEditController = TextEditingController();
  final TextEditingController descTextEditController = TextEditingController();
  final TextEditingController priceTextEditController = TextEditingController();
  final TextEditingController newCategoryTextEditController =
      TextEditingController();
  final TextEditingController categoryTextEditController =
      TextEditingController();
  final TextEditingController typeEditController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductController>().getCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddProduct"),
      ),
      body: context.watch<ProductController>().isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    32.verticalSpace,
                    CustomTextFrom(
                      controller: nameTextEditController,
                      label: "name",
                      hintext: '',
                    ),
                    32.verticalSpace,
                    CustomTextFrom(
                      controller: descTextEditController,
                      label: "desc",
                      hintext: '',
                    ),
                    32.verticalSpace,
                    CustomTextFrom(
                      controller: priceTextEditController,
                      label: "price",
                      keyboardType: TextInputType.number,
                      hintext: '',
                    ),
                    32.verticalSpace,
                    DropdownButtonFormField(
                      value: context
                          .watch<ProductController>()
                          .listOfCategory
                          .first,
                      items: context
                          .watch<ProductController>()
                          .listOfCategory
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (s) {
                        context
                            .read<ProductController>()
                            .setCategory(s.toString());
                      },
                      decoration: const InputDecoration(
                        labelText: "Category",
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                    32.verticalSpace,
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: CustomTextFrom(
                                    label: "New Category",
                                    controller: newCategoryTextEditController,
                                    hintext: '',
                                  ),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<ProductController>()
                                              .addCategory(
                                                  name:
                                                      newCategoryTextEditController
                                                          .text
                                                          .toLowerCase(),
                                                  onSuccess: () {
                                                    Navigator.pop(context);
                                                    context
                                                        .read<
                                                            ProductController>()
                                                        .getCategory();
                                                  });
                                        },
                                        child: Text("Save"))
                                  ],
                                );
                              });
                        },
                        child: Text("Add Category")),
                    32.verticalSpace,
                    DropdownButtonFormField(
                      value:
                          context.watch<ProductController>().listOfType.first,
                      items: context
                          .watch<ProductController>()
                          .listOfType
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (s) {
                        context.read<ProductController>().setType(s.toString());
                      },
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        labelText: "type",
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                    32.verticalSpace,
                    ElevatedButton(
                        onPressed: () {
                          context.read<ProductController>().createProduct(
                              name: nameTextEditController.text,
                              desc: descTextEditController.text,
                              price: priceTextEditController.text);
                        },
                        child: context.watch<ProductController>().isSaveLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Save")),
                    100.verticalSpace
                  ],
                ),
              ),
            ),
    );
  }
}
