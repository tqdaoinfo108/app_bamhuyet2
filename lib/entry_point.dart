import 'package:animations/animations.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/custom_modal_bottom_sheet.dart';
import 'components/entry_point_popup.dart';
import 'screens/find_job/find_job_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'utils/constants.dart';
import 'package:badges/badges.dart' as badges;

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  final List _pages = const [
    HomeScreen(),
    FindJobScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;

  String fullName = "";
  String phone = "";
  String type = "Trở thành cộng tác viên, chi nhánh";
  int typeID = 4;
  String count = "0";
  @override
  void initState() {
    super.initState();
    if (mounted) {
      initProfile();
    }
  }

  initProfile() async {
    var temp = await AppServices.instance.getProfile();

    if (temp != null && mounted) {
      setState(() {
        fullName = temp.data!.fullName;
        phone = temp.data!.userName;
        if (temp.data!.typeUserID != 4) {
          type = temp.data!.typeUserID == 2 ? "Cộng tác viên" : "Tổ chức";
        } else {
          type = "Trở thành cộng tác viên, chi nhánh";
        }
        typeID = temp.data!.typeUserID;
      });
    }

    var temp2 = await AppServices.instance.getCountBooking();
    if (mounted) {
      setState(() {
        count = temp2 ?? "0";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        colorFilter: ColorFilter.mode(
            color ??
                Theme.of(context).iconTheme.color!.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
            BlendMode.srcIn),
      );
    }

    return Scaffold(
      appBar: AppBar(
        // pinned: true,
        // floating: true,
        // snap: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: const SizedBox(),
        leadingWidth: 0,
        centerTitle: false,
        title: _currentIndex == 2
            ? null
            : InkWell(
                onTap: typeID != 4
                    ? null
                    : () {
                        customModalBottomSheet(context,
                            child: EntryPointPopupWidget());
                      },
                child: SizedBox(
                  height: kToolbarHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Chào " + (fullName.isEmpty ? phone : fullName),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : blackColor,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.groups_3_outlined, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            type,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : blackColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
        // title: SvgPicture.asset(
        //   "assets/logo/Shoplon.svg",
        //   colorFilter: ColorFilter.mode(
        //       Theme.of(context).iconTheme.color!, BlendMode.srcIn),
        //   height: 20,
        //   width: 100,
        // ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, notificationsScreenRoute);
            },
            icon: SvgPicture.asset(
              "assets/icons/Notification.svg",
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  BlendMode.srcIn),
            ),
          ),
        ],
      ),
      // body: _pages[_currentIndex],
      body: PageTransitionSwitcher(
        duration: defaultDuration,
        transitionBuilder: (child, animation, secondAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondAnimation,
            child: child,
          );
        },
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: defaultPadding / 2),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF101015),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
              if (index == 0) {
                initProfile();
              }
            }
          },
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          // selectedLabelStyle: TextStyle(color: primaryColor),
          selectedFontSize: 12,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Category.svg"),
              activeIcon:
                  svgIcon("assets/icons/Category.svg", color: primaryColor),
              label: "Trang chủ",
            ),
            BottomNavigationBarItem(
              icon: badges.Badge(
                badgeStyle: BadgeStyle(badgeColor: primaryColor, padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                badgeContent: Text(
                  '$count+',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
                child: svgIcon("assets/icons/document.svg"),
              ),
              activeIcon: badges.Badge(
                badgeStyle: BadgeStyle(badgeColor: primaryColor, padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2)),
                badgeContent: Text(
                  '$count+',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
                child:
                    svgIcon("assets/icons/document.svg", color: primaryColor),
              ),
              label: "Nhận việc",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Profile.svg"),
              activeIcon:
                  svgIcon("assets/icons/Profile.svg", color: primaryColor),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
