import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_forudevs/logic/data/models/event.dart';
import 'package:todo_app_forudevs/logic/data/repositories/database_repository.dart';
import 'package:todo_app_forudevs/main.dart';
import 'package:todo_app_forudevs/utils/app_constants/form_status.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc()
      : super(EventsState(
          newEvent: null,
          events: const [],
          message: '',
          status: FormStatus.pure,
        )) {
    on<GetAllEvents>(getAllEvents);
    on<InsertNewEvent>(insertNewEvent);
    on<UpdateCurrentEvent>(updateEvent);
    on<DeleteEvent>(deleteEvent);
  }

  getAllEvents(GetAllEvents event, emit) async {
    emit(state.copyWith(status: FormStatus.getting));
    List<EventModel> events = await geti<DatabaseRepository>().getAllList();
    emit(state.copyWith(
      status: FormStatus.success,
      events: events,
    ));
  }

  insertNewEvent(InsertNewEvent event, emit) async {
    emit(state.copyWith(status: FormStatus.adding));
    await geti<DatabaseRepository>().insertToDatabase(event: event.eventModel);
    emit(state.copyWith(
      status: FormStatus.addingSucces,
    ));
  }

  updateEvent(UpdateCurrentEvent event, emit) {
    emit(state.copyWith(status: FormStatus.adding));
    geti<DatabaseRepository>().updateEvent(eventModel: event.eventModel);
    emit(state.copyWith(
      status: FormStatus.addingSucces,
    ));
    add(GetAllEvents());
  }

  deleteEvent(DeleteEvent event, emit) {
    geti<DatabaseRepository>().deleteEventById(id: event.eventModel.id!);
    emit(state.copyWith(status: FormStatus.deleted));
    add(GetAllEvents());
  }
}
