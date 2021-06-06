import 'package:constructo/models/comodo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';


class DBProvider{
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async{
    return await openDatabase(
      join(await getDatabasesPath(),'comodos.db' ),
      onCreate: (db, version) async{
        await db.execute('''
          CREATE TABLE comodos(
            id TEXT PRIMARY KEY, titulo TEXT, descricao TEXT
          )


        ''');
        

      },
      version: 1
    );
  }
  novoComodo(Comodo novoComodo) async{
    final db = await database;


    var res = await db.rawInsert(
      'INSERT INTO Test(id, titulo, descricao) VALUES(?, ?, ?)',
      [novoComodo.id, novoComodo.titulo, novoComodo.descricao]);

    return res;

   
  }
  
  Future<dynamic> getComodo() async{
    final db = await database;
    var res = await db.query("comodo");
    if(res.length == 0){
      return null;

    }else{
      var resMap = res[0];
      return resMap.isNotEmpty ? resMap : null;
    }

  }
}

