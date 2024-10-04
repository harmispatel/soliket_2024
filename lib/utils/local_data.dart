// import 'dart:convert';
//
// import 'package:flutter/services.dart';
//
// import '../../../models/seller/dropdown_master.dart';
//
// class LocalData {
//   static List<DropdownData> clothSizeTemp = [];
//   static const String categoryList = 'assets/json_data/category_list.json';
//   static const String targetList = 'assets/json_data/target_list.json';
//   static const String clothSizeList = 'assets/json_data/cloth_size.json';
//   static const String shoesSizeList = 'assets/json_data/shoes_size.json';
//   static const String hairSizeList = 'assets/json_data/hair_size.json';
//
//   static Future<List<DropdownData>> getCategory() async {
//     return await processData(categoryList);
//   }
//
//   static Future<List<DropdownData>> getTarget() async {
//     return await processData(targetList);
//   }
//
//   static Future<List<DropdownData>> getClothSize() async {
//     return await processData(clothSizeList);
//   }
//
//   static Future<List<DropdownData>> getShoeSize() async {
//     return await processData(shoesSizeList);
//   }
//
//   static Future<List<DropdownData>> getHairSize() async {
//     return await processData(hairSizeList);
//   }
//
//   // static Future<String> getSizeById(int id) async {
//   //   if (clothSizeTemp.isEmpty) {
//   //     clothSizeTemp = await getClothSize();
//   //   }
//   //   return clothSizeTemp.where((element) => element.id == id).first.name ??
//   //       "--";
//   // }
//
//   static Future<List<DropdownData>> processData(String fileName) async {
//     String data = await rootBundle.loadString(fileName);
//     List list = jsonDecode(data);
//     List<DropdownData> listData = [];
//     for (var v in list) {
//       listData.add(DropdownData.fromJson(v));
//     }
//     return listData;
//   }
// }
