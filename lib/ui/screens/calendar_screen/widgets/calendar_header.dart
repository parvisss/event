import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_forudevs/ui/screens/calendar_screen/widgets/calendar_button.dart';
import 'package:todo_app_forudevs/utils/app_constants/app_colors.dart';
import 'package:todo_app_forudevs/utils/app_constants/app_icons.dart';
import 'package:todo_app_forudevs/utils/tools/date_time_extension.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.selectedMonth,
    required this.selectedDate,
    required this.onChange,
  });

  final DateTime selectedMonth;
  final DateTime? selectedDate;

  final ValueChanged<DateTime> onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            selectedDate == null
                ? 'None'
                : DateFormat('MMMM y').format(selectedMonth),
            style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: AppColors.textColor),
          ),
          const Spacer(),
          CalendarButton(
              onTap: () {
                onChange(selectedMonth.addMonth(-1));
              },
              assetName: AppIcons.backRow),
          const SizedBox(width: 8),
          CalendarButton(
              onTap: () {
                onChange(selectedMonth.addMonth(1));
              },
              assetName: AppIcons.nextRow),
        ],
      ),
    );
  }
}
