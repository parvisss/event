import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app_forudevs/logic/bloc/event_bloc/events_bloc.dart';
import 'package:todo_app_forudevs/logic/data/models/event.dart';
import 'package:todo_app_forudevs/ui/screens/add_event_screen/widgets/form_field_widget.dart';
import 'package:todo_app_forudevs/ui/screens/add_event_screen/widgets/text_widget.dart';
import 'package:todo_app_forudevs/utils/app_constants/app_colors.dart';
import 'package:todo_app_forudevs/utils/app_constants/app_icons.dart';
import 'package:todo_app_forudevs/utils/app_constants/form_status.dart';


TextEditingController controllerName = TextEditingController();
TextEditingController controllerDescription = TextEditingController();
TextEditingController controllerLocation = TextEditingController();

// ignore: must_be_immutable
class AddEventPage extends StatefulWidget {
  AddEventPage({super.key, this.eventModel});
  Color color = AppColors.blue;

  EventModel? eventModel;

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  @override
  void initState() {
    if (widget.eventModel != null) {
      controllerName.text = widget.eventModel!.name;
      controllerDescription.text = widget.eventModel!.description;
      controllerLocation.text = widget.eventModel!.location;
      widget.color = Color(widget.eventModel!.color);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(txt: "Event Name"),
            FormFieldWidget(
              numberLine: 1,
              controller: controllerName,
              isLocation: false,
            ),
            const TextWidget(txt: "Event description"),
            FormFieldWidget(
              numberLine: 5,
              controller: controllerDescription,
              isLocation: false,
            ),
            const TextWidget(txt: "Event location"),
            FormFieldWidget(
              numberLine: 1,
              controller: controllerLocation,
              isLocation: true,
            ),
            const TextWidget(txt: "Priority Color"),
            const SizedBox(height: 10),
            //dropdown
            Row(
              children: [
                SizedBox(
                  width: 90.w,
                  child: DropdownButtonFormField<Color>(
                    icon: SvgPicture.asset(AppIcons.arrowDown,
                        height: 24.w, width: 24.w),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: AppColors.grey100,
                    ),
                    value: widget.color,
                    dropdownColor: AppColors.grey100,
                    borderRadius: BorderRadius.circular(8.r),
                    isExpanded: true,
                    hint: Container(
                      height: 16,
                      width: 16,
                      color: widget.color,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: AppColors.blue,
                        child: Container(
                          height: 16,
                          width: 16,
                          color: AppColors.blue,
                        ),
                      ),
                      DropdownMenuItem(
                        value: AppColors.red,
                        child: Container(
                          height: 16,
                          width: 16,
                          color: AppColors.red,
                        ),
                      ),
                      DropdownMenuItem(
                        value: AppColors.orange,
                        child: Container(
                          height: 16,
                          width: 16,
                          color: AppColors.orange,
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      widget.color = value!;
                    },
                  ),
                ),
                TextButton(
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: widget.eventModel == null
                            ? TimeOfDay.now()
                            : TimeOfDay(
                                minute: DateTime.parse(widget.eventModel!.day
                                        .toIso8601String())
                                    .minute,
                                hour: DateTime.parse(widget.eventModel!.day
                                        .toIso8601String())
                                    .hour,
                              ),
                      );
                    },
                    child: Text("Choose Time"))
              ],
            ),
            const Spacer(),
            //button
            SizedBox(
              width: double.infinity,
              height: 46.h,
              child: BlocListener<EventsBloc, EventsState>(
                listener: (context, state) {
                  if (state.status == FormStatus.addingSucces) {
                    BlocProvider.of<EventsBloc>(context).add(GetAllEvents());
                    controllerDescription.clear();
                    controllerLocation.clear();
                    controllerName.clear();
                  }
                },
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(AppColors.blue),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (widget.eventModel == null) {
                      BlocProvider.of<EventsBloc>(context).add(InsertNewEvent(
                        EventModel(
                          description: controllerDescription.text,
                          location: controllerLocation.text,
                          color: widget.color.value,
                          name: controllerName.text,
                          isFinished: 0,
                          day: DateTime.now(),
                        ),
                      ));
                      Navigator.pop(context);
                    } else {
                      BlocProvider.of<EventsBloc>(context)
                          .add(UpdateCurrentEvent(
                        EventModel(
                          description: controllerDescription.text,
                          location: controllerLocation.text,
                          color: widget.color.value,
                          name: controllerName.text,
                          isFinished: 0,
                          day: DateTime.now(),
                        ),
                      ));
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);
                    }
                  },
                  child: Text(
                    widget.eventModel == null ? "Add" : "Update",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
