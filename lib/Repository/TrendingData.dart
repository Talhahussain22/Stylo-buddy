import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylo_buddy/Data/Network/NetworkServices.dart';
import 'package:stylo_buddy/Models/TrendingOutfitModel.dart';
import 'package:stylo_buddy/Utils/Utils.dart';
import 'package:stylo_buddy/res/AppUrl.dart';

class Trendingdata{

  NetworkServices _networkServices=NetworkServices();

  Future<List<Outfit>?> getData(BuildContext context) async
  {
    List<Outfit>? outfits;


    try
    {
      await _networkServices.FetchData(APPURL.trendingProducts, {'Content-Type': "application/json"}).then((value){
        TrendingOutfitModel data=TrendingOutfitModel.fromJson(value);
        outfits=data.outfits;

      }).onError((error,StackTrace){

        Utils.ShowFlushBar(context, error.toString(), Colors.red);


      });
    } on SocketException{
      Utils.ShowFlushBar(context, "No internet connection", Colors.red);
    }

    return outfits;

  }}