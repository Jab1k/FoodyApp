import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../model/product_model.dart';

class ProductController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List listOfCategory = [];
  List listOfType = ["KG", "PC"];
  int selectCategoryIndex = 0;
  int selectTypeIndex = 0;
  bool isLoading = true;
  bool isSaveLoading = false;
  QuerySnapshot? res;
  String imagePath = "";
  final ImagePicker _image = ImagePicker();

  getCategory() async {
    isLoading = true;
    notifyListeners();
    res = await firestore.collection("category").get();
    listOfCategory.clear();
    res?.docs.forEach((element) {
      listOfCategory.add(element["name"]);
    });
    isLoading = false;
    notifyListeners();
  }

  setCategory(String category) {
    selectCategoryIndex = listOfCategory.indexOf(category);
  }

  setType(String type) {
    selectTypeIndex = listOfType.indexOf(type);
  }

  createProduct(
      {required String name,
      required String desc,
      required String price}) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("avatars/${DateTime.now().toString()}");
    await storageRef.putFile(File(imagePath));

    String url = await storageRef.getDownloadURL();
    isSaveLoading = true;
    notifyListeners();
    await firestore.collection("products").add(ProductModel(
            name: name,
            desc: desc,
            image: url,
            price: double.tryParse(price) ?? 0,
            category: res?.docs[selectCategoryIndex].id,
            type: listOfType[selectTypeIndex])
        .toJson());
    isSaveLoading = false;
    notifyListeners();
  }

  addCategory({required String name, required VoidCallback onSuccess}) async {
    await firestore.collection("category").add({"name": name});
    onSuccess();
  }

  getImageGallery() {
    _image.pickImage(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        CroppedFile? cropperImage =
            await ImageCropper().cropImage(sourcePath: value.path);
        imagePath = cropperImage?.path ?? "";
        notifyListeners();
      }
    });
    notifyListeners();
  }

  getImageCamera() {
    _image.pickImage(source: ImageSource.camera).then((value) async {
      if (value != null) {
        CroppedFile? cropperImage =
            await ImageCropper().cropImage(sourcePath: value.path);
        imagePath = cropperImage?.path ?? "";
        notifyListeners();
      }
    });
    notifyListeners();
  }
}
