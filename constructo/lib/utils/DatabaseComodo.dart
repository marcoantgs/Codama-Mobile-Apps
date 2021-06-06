import 'package:constructo/models/comodo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';



class DataBaseComodo{

  
  static const String createDataBase = "CREATE TABLE comodos(id INTEGER PRIMARY KEY, titulo TEXT, descricao TEXT, valorTotal REAL,  tipoComodo TEXT )";
  static const String insertDataBase = "INSERT INTO Test(id, titulo, descricao) VALUES(?, ?, ?, ?)";
  static const String nomeDataBase = "comodos.db";
  static const String nomeTabela = "comodos";

  DataBaseComodo(){}
        

  Future<Database> _getdatabase() async{
      return openDatabase(
        join(await getDatabasesPath(),nomeDataBase),
        onCreate: (db, version) {
          db.execute(createDataBase);
        },
        version: 1,
      );
  }

  Future Criar (Comodo novoComodo) async{
    try{
      final Database db = await _getdatabase();
      await db.insert(nomeTabela, novoComodo.toMap(),);
    }
    catch(ex){
      print(ex);
      return;
    }
  }
  
  Future<List<Comodo>> getComodo() async{
    try{
      final Database db = await _getdatabase();
      final List<Map<String, dynamic>> maps = await db.query(nomeTabela);
      
      
    }
    catch(ex){ 
      print(ex);
      return new List<Comodo>();    
    }
    
  }
  

  Future Atualizar (Comodo atualizarComodo) async{
    final Database db = await _getdatabase();
    await db.update (
      nomeTabela, atualizarComodo.toMap(), where: "id = ?", whereArgs: [atualizarComodo.id]
    );

  }
  Future Deletar (Comodo deletarComodo) async{
    final Database db = await _getdatabase();
    await db.delete (
      nomeTabela, where: "id = ?", whereArgs: [deletarComodo.id]
    );

  }
  

}