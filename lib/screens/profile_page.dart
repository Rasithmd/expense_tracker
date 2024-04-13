import 'package:expense_tracker/model/user_model.dart';
import 'package:expense_tracker/utils/const.dart';
import 'package:expense_tracker/widget/app_top_bar.dart';
import 'package:expense_tracker/widget/logout_popup.dart';
import 'package:expense_tracker/widget/profile_address_card.dart';
import 'package:expense_tracker/widget/profile_menu_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool remainder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                AppTopBar(
                  context: context,
                  title: 'Profile',
                  height: 0.3,
                  isVisibleBackArrow: false,
                  isVisibleAction: false,
                ),
                Positioned(
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 210),
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: UserModel.singleUser.profile == ''
                                  ? const DecorationImage(
                                      image:
                                          AssetImage("images/user_profile.png"),
                                    )
                                  : DecorationImage(
                                      image: NetworkImage(
                                          UserModel.singleUser.profile),
                                      fit: BoxFit.cover)),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                                radius: 14,
                                child:
                                    Image.asset("images/icons/edit-icon.png")))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              UserModel.singleUser.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2A232D),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ProfileAddressCard(
              mobileNumber: UserModel.singleUser.number,
              mailId: UserModel.singleUser.emailId,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Reminder",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xDB343333),
                        ),
                      ),
                      Container(
                        child: buildSwitch(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ProfileMenuWidget(
              text: "Logout",
              avatar: IconPath.logout,
              onTap: () {
                logOutPopUp(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSwitch() {
    return Transform.scale(
        alignment: Alignment.centerRight,
        scale: 0.8,
        child: Switch.adaptive(
            activeColor: Color.fromARGB(255, 136, 134, 134),
            value: remainder,
            onChanged: (value) => setState(() => remainder = value)));
  }
}
