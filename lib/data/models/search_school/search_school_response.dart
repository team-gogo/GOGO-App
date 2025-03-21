import 'package:flutter/foundation.dart';

import '../auth/additional_sign_up/additional_sign_up_response.dart';

class SearchSchoolRowModel {
  final List<School> row;

  SearchSchoolRowModel({required this.row});

  factory SearchSchoolRowModel.fromJson(Map<String, dynamic> json) {
    if (json['schoolInfo'] != null && json['schoolInfo'].length > 1) {
      List rowJson = json['schoolInfo'][1]['row'];
      List<School> row = rowJson.map((e) => School.fromJson(e)).toList();
      return SearchSchoolRowModel(row: row);
    } else {
      debugPrintThrottled('값이 없습니다');
      return SearchSchoolRowModel(row: []);
    }
  }
}
