import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_forudevs/logic/bloc/event_bloc/events_bloc.dart';
import 'package:todo_app_forudevs/ui/screens/add_event_screen/add_event_page.dart';
import 'package:todo_app_forudevs/ui/screens/calendar_screen/widgets/calendar_widget.dart';
import 'package:todo_app_forudevs/ui/screens/calendar_screen/widgets/event_widget.dart';
import 'package:todo_app_forudevs/utils/app_constants/app_colors.dart';
import 'package:todo_app_forudevs/utils/app_constants/app_icons.dart';
import 'package:todo_app_forudevs/utils/app_constants/form_status.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

final dayFormatter = DateFormat('EEEE'); // Formatter for the day of the week
final dateFormatter = DateFormat('d MMMM y'); // Formatter for the full date
final now = DateTime.now();

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    final formattedDay = dayFormatter.format(now); // Example: Sunday
    final formattedDate =
        dateFormatter.format(now); // Example: 28 September 2021

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            Text(
              formattedDay,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: AppColors.textColor,
              ),
            ),
            Text(
              formattedDate,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        actions: [
          SvgPicture.asset(
            AppIcons.notification,
            width: 28.w,
            height: 28.h,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const CalendarWidget(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Schedule",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: AppColors.textColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEventPage(),
                        ),
                      );
                    },
                    child: Container(
                      height: 30.h,
                      width: 102.w,
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Text(
                          "+ Add Event",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
              BlocBuilder<EventsBloc, EventsState>(
                builder: (context, state) {
                  if (state.status == FormStatus.success) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.events.length,
                      itemBuilder: (context, index) {
                        return EventWidget(
                          eventModel: state.events[index],
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
