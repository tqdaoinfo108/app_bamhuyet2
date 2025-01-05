import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants.dart';
import 'components/profile_card.dart';
import 'components/profile_menu_item_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ProfileCard(
            name: "Nguyễn Tuấn Vũ",
            email: "tuanvu06@gmail.com",
            imageSrc:
                "https://scontent.fsgn5-14.fna.fbcdn.net/v/t1.6435-9/34274734_212219806169161_5146378634684006400_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeGB9NUVvJEYaFlSIQ3HTAZwgWJi8vEDHB-BYmLy8QMcHwrDLaQ6roNnx7zYWy17Zi0xKsH9y518y2KQQc9tGqql&_nc_ohc=NO46MmuwIkcQ7kNvgESsL2q&_nc_zt=23&_nc_ht=scontent.fsgn5-14.fna&_nc_gid=ARH61F4WGPtFKfmdLL1Sccp&oh=00_AYBVvv_-cVsXt3ANsllemkal7SUIPJYFw9VtcqrXg3mfcg&oe=679A402C",
            // proLableText: "Sliver",
            // isPro: true, if the user is pro
            press: () {
              // Navigator.pushNamed(context, userInfoScreenRoute);
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(
              "Tài khoản",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ProfileMenuListTile(
            text: "Yêu thích",
            svgSrc: "assets/icons/Wishlist.svg",
            press: () {},
          ),
          ProfileMenuListTile(
            text: "Địa chỉ",
            svgSrc: "assets/icons/Address.svg",
            press: () {
              // Navigator.pushNamed(context, addressesScreenRoute);
            },
          ),

          const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            child: Text(
              "Hỗ trợ",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: "Hỗ trợ",
            svgSrc: "assets/icons/Help.svg",
            press: () {
              // Navigator.pushNamed(context, getHelpScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: "FAQ",
            svgSrc: "assets/icons/FAQ.svg",
            press: () {},
            isShowDivider: false,
          ),
          const SizedBox(height: defaultPadding),

          // Log Out
          ListTile(
            onTap: () {},
            minLeadingWidth: 24,
            leading: SvgPicture.asset(
              "assets/icons/Logout.svg",
              height: 24,
              width: 24,
              colorFilter: const ColorFilter.mode(
                errorColor,
                BlendMode.srcIn,
              ),
            ),
            title: const Text(
              "Đăng xuất",
              style: TextStyle(color: errorColor, fontSize: 14, height: 1),
            ),
          )
        ],
      ),
    );
  }
}
