// ignore_for_file: must_be_immutable

import 'package:expense_tracker/utils/const.dart';
import 'package:flutter/material.dart';

class ProfileAddressCard extends StatefulWidget {
  ProfileAddressCard({
    super.key,
    required this.mobileNumber,
    required this.mailId,
    this.location,
  });

  String mobileNumber;
  String? location;
  String mailId;

  @override
  State<ProfileAddressCard> createState() => _ProfileAddressCardState();
}

class _ProfileAddressCardState extends State<ProfileAddressCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        width: double.infinity,
        padding: const EdgeInsets.only(
          left: 10,
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Container(
                  padding: const EdgeInsets.only(
                    bottom: 4, // Space between underline and text
                  ),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Color(0xFFFF9A71),
                    width: 1.1, // Underline thickness
                  ))),
                  child: const Text(
                    "Personal Info",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xDB343333),
                    ),
                  ),
                )),
            ListTile(
              leading: Image.asset(
                IconPath.phone,
                height: 14,
              ),
              title: Text(
                widget.mobileNumber,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff696161),
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                IconPath.mail,
                height: 12,
              ),
              title: Text(
                widget.mailId,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff696161),
                ),
              ),
            ),
            if (widget.location != null)
              ListTile(
                leading: Image.asset(
                  IconPath.location,
                  height: 17,
                ),
                title: Text(
                  widget.location!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff696161),
                  ),
                ),
              ),
          ],
        ));
  }
}
