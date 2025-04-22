import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBHelper
{
  DBHelper._();
  static final DBHelper db=DBHelper._();


  static DBHelper getinstance()
  {
    return db;
  }

  Database? myDB;

  Future<Database> getDB() async
  {


    myDB=myDB?? await openDB();

    return myDB!;
  }

  Future<Database> openDB() async
  {

    Directory appdir=await getApplicationDocumentsDirectory();
    String path=join(appdir.path,"Products.db");

    return await openDatabase(path,onCreate: (db,version){

      db.execute("create table Outfits (ID INTEGER PRIMARY KEY ,shirturl varchar(50) not null,panturl varchar(50) not null)");
      db.execute("create table FavouriteRecomendation (ID Text PRIMARY KEY,url varchar(50) not null)");
    },
        version: 1);

  }

  void InsertIntoFavourtie({required String ID,required String url}) async
  {
    var tempdb=await getDB();
    await tempdb.insert("FavouriteRecomendation",{
      "ID":ID,"url":url
    });
  }

  Future<List<Map<String,dynamic>>> getfavouritedData() async
  {
    var tempdb=await getDB();

    return await tempdb.query("FavouriteRecomendation");
  }

  void deletefromFavourite({required String ID}) async
  {
    var tempdb=await getDB();
    await tempdb.delete("FavouriteRecomendation",where: 'ID = ?',
      whereArgs: [ID]
      );
  }

  Future<List<Map<String,dynamic>>> getallfavouritedIDS() async
  {
    var tempdb=await getDB();
    List<Map<String, dynamic>> result = await tempdb.rawQuery("SELECT ID FROM FavouriteRecomendation");
    return result;


  }

  void Insert({required String shirturl,required String panturl,required String tableName}) async
  {

    var tempdb=await getDB();
    await tempdb.insert(tableName, {"shirturl":shirturl,"panturl":panturl});

  }



  Future<List<Map<String,dynamic>>> getData(String tableName) async
  {
    var tempdb=await getDB();
    return await tempdb.query(tableName);
  }
  void Delete({required int ID,required String tableName}) async
  {
    var tempdb=await getDB();
    tempdb.delete(tableName,where: 'ID=$ID');

  }

  void cleartable(String tableName) async
  {
    var tempdb=await getDB();

    await tempdb.delete(tableName);


  }

}


  


