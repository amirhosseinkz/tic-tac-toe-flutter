import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BoardTile extends StatelessWidget {
  final String value;
  final Function onTap;
  final bool isLightMode;

  const BoardTile({
    Key? key,
    required this.value,
    required this.onTap,
    required this.isLightMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 70.w,
        height: 70.h,
        decoration: BoxDecoration(
          color: isLightMode ? Colors.white : Colors.black,
          border: Border.all(
            color: value == 'O'
                ? Colors.red
                : value == 'X'
                ? Colors.green
                : isLightMode
                ? Colors.black54
                : Colors.white70,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: value.isEmpty
              ? null
              : SvgPicture.asset(
            "assets/players/$value.svg",
            width: 40.w,
            height: 40.h,
            color: value == 'O' ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }
}