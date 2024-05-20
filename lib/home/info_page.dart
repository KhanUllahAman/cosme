import 'package:cosme/home/product_home_list/product_home_lists.dart';
import 'package:cosme/widget/text%20and%20icon/big_text.dart';
import 'package:cosme/widget/text%20and%20icon/extended_text.dart';
import 'package:flutter/material.dart';
import '../utils/color.dart';
import '../widget/text and icon/app_icon.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.clear,
                  ontap: () {
                    print("Tapped on the clear icon");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainProduct()));
                  },
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                  child: BigText(
                    size: 18,
                    text: "Everything is here for your beauty needs",
                  ),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
              ),
            ),
            backgroundColor: AppColor.mainColor,
            expandedHeight: 500,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/face.png",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              Container(
                child: ExtendedText(
                    text:
                        "Indulge in the ritual of skincare, where each product whispers secrets of renewal to your skin. From cleansing to moisturizing, every step is a graceful move towards radiance and confidence. With the precision of an artist, blend foundation seamlessly for a flawless canvas. Adorn lips with hues ranging from soft pink to bold crimson, expressing your unique beauty. Step into the world, your beauty becomes a proclamation of your inner light shining brightly."),
                margin: EdgeInsets.only(
                  left: 20,
                ),
              ),
            ]),
          )
        ],
      ),

      // child: Text,
    );
  }
}
