import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app_forudevs/utils/app_constants/app_colors.dart';
import 'package:todo_app_forudevs/utils/app_constants/app_icons.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({
    super.key,
    required this.numberLine,
    required this.controller,
    required this.isLocation,
  });
  final int numberLine;
  final TextEditingController controller;
  final bool isLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24, top: 10),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: numberLine,
        style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: AppColors.grey900),
        decoration: InputDecoration(
          suffixIconConstraints:
              BoxConstraints(maxHeight: 17.h, maxWidth: 17.h),
          suffixIcon: isLocation
              ? SvgPicture.asset(
                  AppIcons.locationIcon,
                  colorFilter:
                      const ColorFilter.mode(AppColors.blue, BlendMode.srcIn),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(13.0),
        ),
      ),
    );
  }
}
