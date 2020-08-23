import 'package:flutter/foundation.dart';



class OrderModel{
  final String userId;
  final String number;
  final String title;
  final String details;
  final String date;
  final String category;
  final String price;

  final String userName;
  final String domainId;
  final String status;
  final String payed;
  final List investUsers;
  final String attach;
  final List attachments;
  final String investPercentage;


  OrderModel({
    @required this.userId,
    @required this.number,
    @required this.title,
    @required this.details,
    @required this.category,
    @required this.date,
    @required this.price,
    this.userName,
    this.status,
    this.attach,
    this.attachments,
    this.domainId,
    this.investPercentage,
    this.investUsers,
    this.payed
  });

  @override
  String toString() {
    return "id: $userId\nname: $userName\n";
  }

}