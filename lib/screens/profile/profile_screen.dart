import 'package:app_bamnguyet_2/route/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_theme.dart';
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
            name: GetStorage().read(userFullName),
            email: GetStorage().read(userUserName),
            imageSrc: GetStorage().read(userImagePath),
            // proLableText: "Sliver",
            // isPro: true, if the user is pro
            press: () {
              // Navigator.pushNamed(context, userInfoScreenRoute);
            },
          ),
          GetStorage().read(userTypeUser) == 4
              ? SizedBox()
              : InkWell(
                  onTap: () {
                    var typeUser = GetStorage().read(userTypeUser);
                    if (typeUser == 2) {
                      Navigator.pushNamed(context, requestPartnerScreen);
                    }
                    if (typeUser == 3) {
                      Navigator.pushNamed(context, requestOrganizationScreen);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    decoration: BoxDecoration(
                        color: greyColor.withOpacity(.3),
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadious)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/Wishlist.svg",
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).iconTheme.color!,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Đối tác của Hoàng Lâm",
                          style: AppTheme.getTextStyle(context),
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          "assets/icons/Arrow - Right.svg",
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).iconTheme.color!,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  )),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(
              "Tài khoản",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ProfileMenuListTile(
            text: "Lịch sử hoạt động",
            svgSrc: "assets/icons/Order.svg",
            press: () {
              Navigator.pushNamed(context, historyscreen);
            },
          ),
          ProfileMenuListTile(
            text: "Địa chỉ",
            svgSrc: "assets/icons/Address.svg",
            press: () {
              Navigator.pushNamed(context, addressScreenRoute);
            },
          ),

          const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            child: Text(
              "Hệ thống",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: "Đổi ngôn ngữ",
            svgSrc: "assets/icons/Language.svg",
            press: () async {
              await launchUrl(Uri(scheme: 'tel', path:"0862792749"));
              // Navigator.pushNamed(context, getHelpScreenRoute);
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
            press: () async {
              await launchUrl(Uri(scheme: 'tel', path:"0862792749"));
              // Navigator.pushNamed(context, getHelpScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: "Chính sách bảo mật",
            svgSrc: "assets/icons/Lock.svg",
            press: () {
              Navigator.of(context).pushNamed(fagScreen);
            },
            isShowDivider: true,
          ),
          ProfileMenuListTile(
            text: "Quy chế hoạt động",
            svgSrc: "assets/icons/Bookmark.svg",
            press: () {
              Navigator.of(context).pushNamed(fagScreen);
            },
            isShowDivider: true,
          ),
          ProfileMenuListTile(
            text: "Điều khoản sử dụng",
            svgSrc: "assets/icons/FAQ.svg",
            press: () {
              Navigator.of(context).pushNamed(fagScreen);
            },
            isShowDivider: false,
          ),
          const SizedBox(height: defaultPadding),

          ProfileMenuListTile(
            text: "Thông tin ứng dụng",
            svgSrc: "assets/icons/FAQ.svg",
            press: () {
              Navigator.of(context).pushNamed(fagScreen);
            },
            isShowDivider: false,
          ),
          // Log Out
          ListTile(
            onTap: () {
              GetStorage().remove(userUserID);
              Navigator.popAndPushNamed(context, logInScreenRoute);
            },
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
