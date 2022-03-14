import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static const String _databaseName = "MyDatabase,db";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }


  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE typeCar (
            Id INTEGER PRIMARY KEY,
            Descripcion TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE car (
            idCar INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            idTypeCar INTEGER NOT NULL,
            mantenimientoKM DOUBLE NOT NULL,
            ultimoKM DOUBLE NOT NULL,
            placa TEXT NOT NULL
          )
          ''');
  }


  //TYPE CAR

  Future<int> inserTypeCar(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('typeCar', row);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsTypeCar() async {
    Database db = await instance.database;
    return await db.query('typeCar');
  }


  //CAR
  Future<int> inserCar(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('car', row);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsCar() async {
    Database db = await instance.database;
    return await db.rawQuery('''
        SELECT c.idCar, c.idTypeCar, c.mantenimientoKM, c.ultimoKM, c.placa, t.Descripcion from car as c
        inner join typeCar as t on t.Id = c.idTypeCar
        ''');
  }

  Future<int?> validarPlacaIngresar({required String placa}) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM car AS c WHERE c.placa = $placa'));
  }

  Future<int?> validarPlacaEditar({required String placa, required int id}) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM car AS c WHERE c.placa = $placa AND c.idCar != $id'));
  }

  Future<int> updateCar(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['idCar'];
    return await db.update('car', row, where: 'idCar = ?', whereArgs: [id]);
  }

  Future<int> deleteCar(int id) async {
    Database db = await instance.database;
    return await db.delete('car', where: 'idCar = ?', whereArgs: [id]);
  }
}