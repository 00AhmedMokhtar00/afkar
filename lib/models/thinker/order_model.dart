import 'package:flutter/cupertino.dart';



class OrderModel{
  final String number;
  final String title;
  final String details;
  final String date;
  final String category;
  final String price;
  final bool hasOffers;

  OrderModel({
    @required this.number,
    @required this.title,
    @required this.details,
    @required this.category,
    @required this.date,
    @required this.price,
    this.hasOffers = false
  });

}