import 'package:flutter/material.dart';
import 'package:stylo_buddy/Data/local/DBHelper.dart';
import 'package:stylo_buddy/Models/RecomendationModel.dart';
import 'package:stylo_buddy/Models/TrendingOutfitModel.dart';
import 'package:stylo_buddy/Repository/TrendingData.dart';

class TrendingData extends ChangeNotifier
{
  Trendingdata _api=Trendingdata();
  List<Outfit>? outfits;
  List<Map<String,dynamic>>? allfavProducts;
  List<String> favouriteIDs=[];
  List<Map<String,dynamic>>? dataforfavouritePage;

  void fetchData(BuildContext context) async
  {

    favouriteIDs.clear();

    if(outfits!=null)
      {
        outfits!.clear();
        notifyListeners();

      }
    getandSaveProductinDB();
    await _api.getData(context).then((value){

        outfits=value;

        notifyListeners();


    });

  }
  int getoutfitlenght()=>outfits!.length;
  List<Outfit>? getOutfits()=>outfits;


  void getandSaveProductinDB() async
  {
    var tempdb=DBHelper.getinstance();
    allfavProducts=await tempdb.getallfavouritedIDS();

    for(var i in allfavProducts!)
    {
      favouriteIDs.add(i["ID"]);

    }

  }





  List<String> getfavouritedProducts(){

    return favouriteIDs;
  }

  void Insert({required String id,required String url}) async
  {
    var tempdb=DBHelper.getinstance();
    tempdb.InsertIntoFavourtie(ID: id, url: url);
    favouriteIDs.add(id);
    notifyListeners();
  }



  void getData()  async
  {
    var tempdb=DBHelper.getinstance();

    dataforfavouritePage = List<Map<String, dynamic>>.from(await tempdb.getfavouritedData());

    notifyListeners();
  }

  List<Map<String,dynamic>>? dataofFavoritePage()=>dataforfavouritePage;

  void delete({required String id}) async
  {
    var tempdb=DBHelper.getinstance();
    tempdb.deletefromFavourite(ID: id);
    favouriteIDs.remove(id);
    notifyListeners();
  }

  void deleteformfavorite({required String id,required int index}) async
  {
    var tempdb=DBHelper.getinstance();
    tempdb.deletefromFavourite(ID: id);

    dataforfavouritePage!.removeAt(index);

    notifyListeners();
  }




}