import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylo_buddy/Data/local/DBHelper.dart';
import 'package:stylo_buddy/Models/ProductModel.dart';
import 'package:stylo_buddy/Models/RecomendationModel.dart';
import 'package:stylo_buddy/Repository/ProductData.dart';
import 'package:stylo_buddy/Utils/Utils.dart';
import 'package:stylo_buddy/ViewModel/LoginAndSignUp.dart';

class DataProvider extends ChangeNotifier
{
  ProductData _api=ProductData();
  List<ProductModel>? _data;
  List<ProductModel>? _shirts;
  List<ProductModel>? _pants;
  List<int> selected=[];
  List<int> selectedShirtsIndex=[];
  List<int> selectedPantsIndex=[];
  bool isfetch=false;
  List<Outfits>? outfits;

  int outfitlenght=0;
  int currentIndex=0;

  List<String> FinalSelectedShirts=[];
  List<String> FinalSelectedPants=[];


  Future<bool> hasInternetConnection() async {
    try {
      final response = await http.get(Uri.parse("https://www.google.com"));

      return response.statusCode == 200;
    } catch (_) {

      return false;
    }
  }


  Future FetchData(BuildContext context) async
    {

    if(await hasInternetConnection())
      {

      try
          {
            await _api.getData(context).then((Value){

              _data=Value;



              if(_data!.isNotEmpty)
              {

                selected.addAll(List.filled(_data!.length, 0));
                filterdata();
                isfetch=true;
                notifyListeners();
              }


            }).onError((error,Stacktrace){


              String errorMsg=getError(error.toString());
              Utils.ShowFlushBar(context,errorMsg ,Colors.red);
            });


          } on SocketException
      {

        Utils.ShowFlushBar(context, "No internet connection", Colors.red);

      }
    }
    else
    {
      return;
    }
    }

    Future postdata(Map<String,List<String>> body,BuildContext context) async
  {

    currentIndex=0;
    outfitlenght=0;

    if(outfits!=null)
      {
        outfits=null;

        notifyListeners();
      }


    if(!await hasInternetConnection())
      {
        Utils.ShowFlushBar(context,"check your internet connection and try again",Colors.red);
        return;
      }
    try
        {

          await _api.postData(body).then((value){

            if(value!.isNotEmpty)
              {
                value.sort((a,b)=>double.parse(b.similarityScore!).compareTo(double.parse(a.similarityScore!)));

                outfits=value;
                outfitlenght=outfits!.length;

                notifyListeners();
              }


          });
        }catch(e){
          Utils.ShowFlushBar(context,e.toString(), Colors.red);
    }

  }


  void incrementIndex()
  {
    currentIndex+=1;
    notifyListeners();
  }

  void decrementIndex()
  {
    currentIndex-=1;
    notifyListeners();
  }

  void filterdata()
  {
    _shirts=_data!.where((item)=>item.category=="shirt").toList();
    selectedShirtsIndex.addAll(List.filled(_shirts!.length, 0));
    _pants=_data!.where((item)=>item.category=="pant").toList();
    selectedPantsIndex.addAll(List.filled(_pants!.length, 0));

  }
  void addPant(String pant)
  {
    if(!FinalSelectedPants.contains(pant))
      {
        FinalSelectedPants.add(pant);
      }
  }
  void removePant(String pant)
  {
    FinalSelectedPants.remove(pant);
  }

  void addShirt(String shirt)
  {
    if(!FinalSelectedShirts.contains(shirt))
      {
        FinalSelectedShirts.add(shirt);
      }

  }

  void removeShirt(String shirt)
  {
    FinalSelectedShirts.remove(shirt);
  }

  List<List> ReturnSelectedShirtsAndPants(BuildContext context)
  {
    if(FinalSelectedShirts.isEmpty || FinalSelectedPants.isEmpty)
      {
        Utils.ShowFlushBar(context, "Select both pant and shirt", Colors.red);

      }
    return [FinalSelectedShirts,FinalSelectedPants];
  }

  List<ProductModel>? getData()
  {


    return _data;

  }

  bool IsFetched()=>isfetch;



  void toggleSelection(int index,int val,int tabindex)
  {
    switch(tabindex)
    {
      case 0:
        selected[index]=val;

      case 1:
        selectedPantsIndex[index]=val;

      case 2:
        selectedShirtsIndex[index]=val;
    }
    notifyListeners();
  }

  List<Outfits>? getOutfit()=>outfits;

  List<ProductModel>? getShirts()=>_shirts;
  List<ProductModel>? getPants()=>_pants;


  int datalength()=>_data!.length;


  void removefromDatabase({required int id, required String tableName}) async{

    var tempdb=DBHelper.getinstance();
    tempdb.Delete(ID: id, tableName:tableName );

    notifyListeners();
  }

  void addtoDatabase({required String panturl,required String shirturl,required String tableName})async{
    var tempdb=DBHelper.getinstance();
    tempdb.Insert(shirturl: shirturl, panturl: panturl, tableName: tableName);

  }

  Future<List<Map<String,dynamic>>> getdatabasedata({required String tableName}) async
  {

    var tempdb=DBHelper.getinstance();

    return await tempdb.getData(tableName);
  }
}