import 'package:path/path.dart';
import 'package:project2/model/notes.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database _db;

  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db;
    }
    //define the path to the database
    String path = join(await getDatabasesPath(), 'MyNote.db');
    _db = await openDatabase(path, version: 1, onCreate: (Database db, int v) {
      //create all tables
      db.execute(
          "create table notes(id integer primary key autoincrement, titel varchar(50), detals text, import integer)");
    });
    return _db;
  }

  Future<int> createNote(Notes notes) async {
    Database db = await createDatabase();
    //db.rawInsert('insert into notes')
    return db.insert('notes', notes.toMap());
  }

  Future<List> allNotes() async {
    Database db = await createDatabase();
    //db.rawQuery("select * from notes")
    return db.query('notes');
  }

  Future<int> deleteNotes(int id) async {
    Database db = await createDatabase();
    return db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteNotesall() async {
    Database db = await createDatabase();
    return db.delete('notes');
  }

  Future<int> updateCourse(Notes course) async {
    Database db = await createDatabase();
    return await db.update('notes', course.toMap(),
        where: 'id = ?', whereArgs: [course.id]);
  }
}
