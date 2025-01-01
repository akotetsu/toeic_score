import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

class ToeicResult {
  ToeicResult({
    required this.total,
    required this.reading,
    required this.listening,
    required this.date,
  }) : id = uuid.v4();

  final String id;
  final int total;
  final int reading;
  final int listening;
  final DateTime date;
  //後にスコアの取り扱いで型が原因で地獄みるかも

  String get formattedDate {
    return formatter.format(date);
  }
}