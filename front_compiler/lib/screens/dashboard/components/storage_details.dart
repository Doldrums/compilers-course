import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "StackTrace",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          StorageInfoCard(
            svgSrc: "assets/icons/error-filled-svgrepo-com.svg",
            title: "Compile Error",
            color: Colors.redAccent,
          ),
          StorageInfoCard(
            title: "Line 5: Char 5: error: non-void function does not return a value [-Werror,-Wreturn-type]}\n1 error generated.",
            color: Colors.redAccent.shade400,
          ),
        ],
      ),
    );
  }
}
