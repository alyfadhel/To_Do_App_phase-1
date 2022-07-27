import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:to_do_app_phase1/core/util/bloc/states.dart';
import 'package:path/path.dart' as p;
import 'package:to_do_app_phase1/features/presentation/pages/notification_services.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  late Database database;
  List<Map> all = [];
  List<Map> completed = [];
  List<Map> uncompleted = [];
  List<Map> favorites = [];
  List<Map> tasks = [];

  void initDatabase()async
  {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'tasks.db');
    debugPrint('Initialize Database');

    openAppDatabase(path: path);

    emit(InitializeAppState());
  }

  void openAppDatabase({
    required String path,
})async
  {
    openDatabase(
      path,
      version: 1,
      onCreate: (database, version) {
        debugPrint('Database Created');
        database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, startTime TEXT, endTime TEXT, remind TEXT, color TEXT, day TEXT, status TEXT)')
            .then((value) {
          debugPrint('Table Created');
        }).catchError((error) {
          debugPrint('Error when database created ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        debugPrint('Database Opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  var remindController = TextEditingController();
  var colorController = TextEditingController();
  var dayController = TextEditingController();

  Future<void> insertToDatabase({
    required String title,
    required String date,
    required String startTime,
    required String endTime,
    required String remind,
    required String color,
    required String day,

  }) async
  {
    await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks (title,date,startTime,endTime,remind,color,day,status) VALUES ("$title","$date","$startTime","$endTime","$remind","$color","$day","new")')
          .then((value) {
        debugPrint('$value Inserting Successfully');
       // NotifyHelper().displayNotification(title: title, body: remind);
        titleController.clear();
        dateController.clear();
        startTimeController.clear();
        endTimeController.clear();
        remindController.clear();
        getDataFromDatabase(database);
        emit(AppInsertToDatabaseState());
      }).catchError((error) {
        debugPrint('Error when database inserting ${error.toString()}');
      });
    });
  }



  void getDataFromDatabase(database)
  {
    all = [];
    completed = [];
    uncompleted = [];
    favorites = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {

      value.forEach((element) {
        if(element['status'] == 'all')
        {
          all.add(element);
        }else if(element['status'] == 'completed')
        {
          completed.add(element);
        }else if(element['status'] == 'uncompleted')
        {
          uncompleted.add(element);
        }else if(element['status'] == 'favorites'){
          favorites.add(element);
        }
        debugPrint(element.toString());
        all = value;
      });
      emit(AppGetDatabaseState());
    });
  }


  void upDateTodoDatabase({
    required String status,
    required int id,})async{
    await database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id])
        .then((value){
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }


  void deleteTodoDatabase({
    required int id,
  })async{
    await database.rawDelete(
        'DELETE FROM tasks WHERE id = ?', [id])
        .then((value){
      getDataFromDatabase(database);
      emit(DeleteDatabaseState());
    });
  }

  // var dayName;
  // var dateSelected;
  // Future <void> getDay(DateTime date)async
  // {
  //   dayName = DateFormat('EEEE').format(date);
  //   dateSelected = DateFormat('dd MMM,yyyy').format(date);
  //   tasks=[];
  //   for (var tasks in all) {
  //    all.add(dayName);
  //   }
  //   emit(GetDays());
  // }


  // List<Map> checkBoxState = [];
  // void changeCheckBox(bool value, int id,)
  // {
  //   all.forEach((element) {
  //     checkBoxState.add(completed[id]);
  //   });
  //  // checkBoxState = value;
  //   emit(ChangeCheckBox());
  // }



  bool checkBoxState = false;
  void changeCheckBox(bool value)
  {
    checkBoxState = value;
    emit(ChangeCheckBox());
  }











}