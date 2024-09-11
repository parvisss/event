import 'package:todo_app_forudevs/logic/data/database_service/local_database.dart';
import 'package:todo_app_forudevs/logic/data/models/event.dart';

class DatabaseRepository {
  Future<List<EventModel>> getAllList() => LocalDatabase.getList();
  Future insertToDatabase({required EventModel event}) =>
      LocalDatabase.insertToDatabase(event);

  Future deleteEventById({required int id}) => LocalDatabase.deleteTaskById(id);

  Future updateEvent({required EventModel eventModel}) =>
      LocalDatabase.updateTaskById(eventModel);
}
