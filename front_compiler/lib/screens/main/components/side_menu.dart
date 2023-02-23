import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

var parser = EmojiParser();

final sampleTree = TreeNode.root()
  ..addAll([
    TreeNode(key: "${parser.get('cactus').code} Scripts")
      ..addAll([
        TreeNode(key: "Example1"),
        TreeNode(key: "SomeDraft"),
        TreeNode(key: "AnotherExample")
      ]),
  ]);

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'interpreter__',
                  style: GoogleFonts.titilliumWeb(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: defaultPadding / 2,
                    ),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Row(
                      children: const [
                        Text("Clojure"),
                        const Spacer(),
                        Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18,),
              ],
            ),
          ),
          DrawerListTile(
            title: "${parser.get('coffee').code} Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "${parser.get('fire').code} Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "${parser.get('sparkles').code} Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: TreeView.simple(
                key: UniqueKey(),
                tree: sampleTree,
                onItemTap: (item) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Item tapped: ${item.key}"),
                      duration: const Duration(milliseconds: 750),
                    ),
                  );
                },
                builder: (context, level, item) => AbsorbPointer(
                      ignoringSemantics: true,
                      child: ListTile(
                        onTap: () {},
                        horizontalTitleGap: 0.0,
                        leading: SvgPicture.asset(
                          item.isExpanded
                              ? 'assets/icons/minus-sign-on-a-square-outline.svg'
                              : 'assets/icons/add-108.svg',
                          color: Colors.white54,
                          height: 16,
                        ),
                        title: Text(
                          item.key,
                          style: const TextStyle(color: Colors.white54),
                        ),
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
