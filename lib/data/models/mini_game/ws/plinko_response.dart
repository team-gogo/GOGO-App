import 'dart:convert';

class PlinkoResponse {
  final int amount;
  final List<String> path;

  PlinkoResponse({required this.amount, required this.path});

  factory PlinkoResponse.fromJson(Map<String, dynamic> json) {
    return PlinkoResponse(
      amount: json['amount'] as int,
      path: List<String>.from(json['path']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'path': path,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
