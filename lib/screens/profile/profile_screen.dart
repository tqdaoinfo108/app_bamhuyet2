import 'package:app_bamnguyet_2/route/route_constants.dart';
import 'package:app_bamnguyet_2/screens/profile/pages/fag_screen.dart';
import 'package:app_bamnguyet_2/screens/profile/pages/support_screen.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:toastification/toastification.dart' show ToastificationType;

import '../../components/app_snackbar.dart';
import '../../components/custom_modal_bottom_sheet.dart';
import '../../components/list_tile/divider_list_tile.dart';
import '../../theme/app_theme.dart';
import '../../utils/constants.dart';
import 'components/profile_card.dart';
import 'components/profile_menu_item_list_tile.dart';
import 'pages/change_language_screen.dart';
import 'pages/operating_regulations_screen.dart';
import 'pages/policy_secure_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          GetStorage().read(userUserID) != null
              ? ProfileCard(
                  name: GetStorage().read(userFullName),
                  email: GetStorage().read(userUserName),
                  imageSrc: GetStorage().read(userImagePath),
                  // proLableText: "Sliver",
                  // isPro: true, if the user is pro
                  press: () async {
                    await Navigator.pushNamed(context, profileDetailScreen);
                    setState(() {});
                  },
                )
              : ProfileLoginCard(),
          (GetStorage().read(userTypeUser) == 4) ||
                  GetStorage().read(userUserID) == null
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "partner".trans(),
                              style: AppTheme.getTextStyle(context),
                            ),
                            Text(
                              "${NumberFormat.decimalPattern('vi').format(GetStorage().read(userUserAmount)) + " đ"}",
                              style: AppTheme.getTextStyle(context).copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: blackColor80),
                            ),
                          ],
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
          if (GetStorage().read(userUserID) != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Text(
                    "account".trans(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(height: defaultPadding / 2),
                ProfileMenuListTile(
                  text: "activity_history".trans(),
                  svgSrc: "assets/icons/Order.svg",
                  press: () {
                    Navigator.pushNamed(context, historyscreen);
                  },
                ),
                ProfileMenuListTile(
                  text: "address".trans(),
                  svgSrc: "assets/icons/Address.svg",
                  press: () {
                    Navigator.pushNamed(context, addressScreenRoute);
                  },
                ),
                ProfileMenuListTile(
                  text: "wallet".trans(),
                  svgSrc: "assets/icons/Wallet.svg",
                  press: () {
                    Navigator.pushNamed(context, walletScreen);
                  },
                  isShowDivider: false,
                ),
                ListTile(
                  onTap: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              content: Text(
                                'delete_account_description'.trans(),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge),
                                  child: Text("cancel".trans()),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelLarge),
                                  child: Text("accept".trans()),
                                  onPressed: () async {
                                    var rs =
                                        await AppServices.instance.deleteUser();
                                    if (rs) {
                                      SnackbarHelper.showSnackBar(
                                          "Thao tác thành công",
                                          ToastificationType.success);
                                      GetStorage().remove(userUserID);
                                      Navigator.popAndPushNamed(
                                          context, logInScreenRoute);
                                    } else {
                                      SnackbarHelper.showSnackBar(
                                          "Thao tác thất bại",
                                          ToastificationType.error);
                                    }
                                  },
                                ),
                              ],
                            ));
                  },
                  minLeadingWidth: 24,
                  leading: SvgPicture.asset(
                    "assets/icons/Delete.svg",
                    height: 24,
                    width: 24,
                    colorFilter: const ColorFilter.mode(
                      errorColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: Text(
                    "delete_account".trans(),
                    style:
                        TextStyle(color: errorColor, fontSize: 14, height: 1),
                  ),
                ),
                const SizedBox(height: defaultPadding),
              ],
            ),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            child: Text(
              "system".trans(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: "change_language".trans(),
            svgSrc: "assets/icons/Language.svg",
            press: () async {
              customModalBottomSheet(context, child: ChangeLanguageScreen());
            },
            isShowDivider: false,
          ),
          const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            child: Text(
              "support".trans(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: "support".trans(),
            svgSrc: "assets/icons/Help.svg",
            press: () async {
              customModalBottomSheet(context, child: SupportScreen());
              // Navigator.pushNamed(context, getHelpScreenRoute);
            },
          ),
          ProfileMenuListTile(
            text: "privacy_policy".trans(),
            svgSrc: "assets/icons/Lock.svg",
            press: () {
              customModalBottomSheet(context, child: PolicySecureScreen());
            },
            isShowDivider: true,
          ),
          ProfileMenuListTile(
            text: "activity_regulations".trans(),
            svgSrc: "assets/icons/Bookmark.svg",
            press: () {
              customModalBottomSheet(context,
                  child: OperatingRegulationsScreen());
            },
            isShowDivider: true,
          ),
          ProfileMenuListTile(
            text: "terms_of_use".trans(),
            svgSrc: "assets/icons/Standard.svg",
            press: () {
              customModalBottomSheet(context, child: FAGScreen());
            },
            isShowDivider: true,
          ),

          DividerListTile(
              minLeadingWidth: 24,
              leading: SvgPicture.asset(
                "assets/icons/FAQ.svg",
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).iconTheme.color!,
                  BlendMode.srcIn,
                ),
              ),
              title: Text(
                "application_infomation".trans(),
                style: const TextStyle(fontSize: 14, height: 1),
              ),
              press: () {},
              isShowDivider: false,
              isShowForwordArrow: false,
              trailing: Text("1.0.0",
                  style: const TextStyle(fontSize: 14, height: 1))),

          // Log Out
          if (GetStorage().read(userUserID) != null)
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
              title: Text(
                "logout".trans(),
                style: TextStyle(color: errorColor, fontSize: 14, height: 1),
              ),
            )
        ],
      ),
    );
  }
}
