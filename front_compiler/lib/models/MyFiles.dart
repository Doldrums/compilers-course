
import 'package:flutter/material.dart';

import '../constants.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "CPU Load",
    svgSrc: "assets/icons/cpu-charge-svgrepo-com.svg",
    totalStorage: "Idle 86%",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Memory used",
    svgSrc: "assets/icons/memory-card-svgrepo-com.svg",
    totalStorage: "13.9GB",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Energy Impact",
    svgSrc: "assets/icons/energy-green-leaf-svgrepo-com.svg",
    totalStorage: "Time on AC: 0:33",
    color: Color(0xFFA4FFC4),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Disk",
    svgSrc: "assets/icons/disk-storage-svgrepo-com.svg",
    totalStorage: "525.3GB",
    color: Color(0xFFE55000),
    percentage: 78,
  ),
];
