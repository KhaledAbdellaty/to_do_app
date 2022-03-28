import '../database/constants.dart';

class TaskModel {
  int? id, isCompleted, color, remind;
  String? title, note, date, startTime, endTime, repeat;

  TaskModel(
      {this.id,
      this.isCompleted,
      this.color,
      this.remind,
      this.title,
      this.note,
      this.date,
      this.startTime,
      this.endTime,
      this.repeat});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnId: id,
      columnTitle: title,
      columnNote: note,
      columnDate: date,
      columnStartTime: startTime,
      columnEndTime: endTime,
      columnRepeat: repeat,
      columnColor: color,
      columnIsCompleted: isCompleted,
      // columnRemind: remind,

    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }


  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map[columnId],
      isCompleted: map[columnIsCompleted],
      color: map[columnColor],
      remind: map[columnRemind],
      title: map[columnTitle],
      note: map[columnNote],
      date: map[columnDate],
      startTime: map[columnStartTime],
      endTime: map[columnEndTime],
      repeat: map[columnRepeat],
    );
  }
  Map<String, dynamic> toChange() {
    var map = <String, dynamic>{
      columnId: id,
      columnTitle: title,
      columnNote: note,
      columnIsCompleted: isCompleted,
      // columnDate: date,
      // columnStartTime: startTime,
      // columnEndTime: endTime,
      // columnRepeat: repeat,
      // columnColor: color,

      // columnRemind: remind,

    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

}
