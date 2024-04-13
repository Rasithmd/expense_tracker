// ignore_for_file: must_be_immutable

import 'package:expense_tracker/widget/top_background.dart';
import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget {
  AppTopBar({
    super.key,
    required this.context,
    required this.title,
    required this.height,
    required this.isVisibleBackArrow,
    required this.isVisibleAction,
    this.sortByAsc,
    this.sortByDesc,
    this.clear,
  });
  String title;
  double height;
  bool isVisibleBackArrow;
  bool isVisibleAction;
  Function? sortByAsc;
  Function? sortByDesc;
  Function? clear;

  final BuildContext context;

  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            TopBackGround(
              height: height,
            ),
            Column(
              children: [
                const SizedBox(height: 70),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isVisibleBackArrow == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child:
                                  Icon(Icons.arrow_back, color: Colors.white),
                            )
                          : Container(width: 30),
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      isVisibleAction == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: PopupMenuButton<int>(
                                icon: const Icon(
                                  Icons.filter_alt_outlined,
                                  color: Colors.white,
                                ),
                                key: _key,
                                itemBuilder: (context) {
                                  return <PopupMenuEntry<int>>[
                                    PopupMenuItem(
                                      child: Text('A-Z'),
                                      value: 0,
                                      onTap: () {
                                        sortByAsc!();
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: Text('Z-A'),
                                      value: 1,
                                      onTap: () {
                                        sortByDesc!();
                                      },
                                    ),
                                    PopupMenuItem(
                                      child: Text('clear'),
                                      value: 2,
                                      onTap: () {
                                        clear!();
                                      },
                                    ),
                                  ];
                                },
                              ),
                            )
                          : Container(
                              width: 30,
                              height: 50,
                            ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
