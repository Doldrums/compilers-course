import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard({
    Key? key,
    this.title,
    this.svgSrc,
    this.amountOfFiles,
    this.numOfFiles,
    this.color,
  }) : super(key: key);

  final String? title, svgSrc, amountOfFiles;
  final int? numOfFiles;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: color!),
          borderRadius: const BorderRadius.all(
            Radius.circular(defaultPadding),
          ),
          color: Colors.red.withOpacity(0.3)),
      child: Row(
        children: [
          if (svgSrc != null)
            SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                svgSrc!,
                color: color,
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Text(
                      title!,
                    ),
                  if (numOfFiles != null)
                    Text(
                      "$numOfFiles Files",
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white70),
                    ),
                ],
              ),
            ),
          ),
          if (amountOfFiles != null) Text(amountOfFiles!)
        ],
      ),
    );
  }
}
