import 'dart:io';

import 'package:emddi_bus/bus_stop.dart';
import 'package:emddi_bus/route.dart';
import 'package:flutter/material.dart';

const LIST_ADDRESS = [
  "Ngõ 44, Triều Khúc, Thanh Xuân",
  "Ngõ 44, Triều Khúc, Thanh Xuân",
  "Ngõ 44, Triều Khúc, Thanh Xuân",
  "Ngõ 44, Triều Khúc, Thanh Xuân",
  "Ngõ 44, Triều Khúc, Thanh Xuân",
];
const LIST_OPTION = [
  "Trang chủ",
  "Tra cứu",
  "Tin buýt",
  "Vé tháng",
  "Mua tem",
  "Tìm đường offline",
  "Ý kiến KH",
  "Trợ giúp"
];
const LIST_ICON_OPTION = [
  Icons.home,
  Icons.search,
  Icons.event_note,
  Icons.card_membership,
  Icons.card_membership,
  Icons.search,
  Icons.feedback,
  Icons.help_outline
];

String OTP = "";
String PHONE = "";
String PATH_AVATAR = 'images/avatar.png';
File FILE_AVATAR;
List<RouterBus> LIST_ROUTE = [];
List<BusStop> LIST_BUS_STOP = [];