import 'package:flutter/material.dart';
import 'package:prueba_tecnica_01/images.dart';

class Phone {
  final String name;
  final String title;
  final String image;
  final String desc;
  final Color color01;
  final Color color02;

  Phone(
      {required this.name,
      required this.color01,
      required this.color02,
      required this.title,
      required this.image,
      required this.desc});
}

final List<Phone> phones = [
  Phone(
      name: 'Iphone',
      title: 'Iphone',
      image: Images.iphone01,
      color01: const Color(0xFF33453f),
      color02: const Color(0xFF292223),
      desc: 'sadadjsaodjsdjasjdiasjdas'),
  Phone(
      name: 'Iphone',
      title: 'Huawei',
      image: Images.huawei01,
      color01: Colors.black,
      color02: const Color(0xFF292223),
      desc: 'sadadjsaodjsdjasjdiasjdas'),
  Phone(
      name: 'Iphone',
      title: 'Alcatel',
      image: Images.alcatel01,
      color01: const Color(0xFF99775d),
      color02: const Color(0xFF292223),
      desc: 'sadadjsaodjsdjasjdiasjdas'),
  Phone(
      name: 'Iphone',
      title: 'Samsung',
      image: Images.samsung01,
      color01: Colors.blue,
      color02: const Color(0xFF292223),
      desc: 'sadadjsaodjsdjasjdiasjdas')
];
