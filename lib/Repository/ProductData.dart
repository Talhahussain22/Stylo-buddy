import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:stylo_buddy/Data/Network/NetworkServices.dart';
import 'package:stylo_buddy/Models/ProductModel.dart';
import 'package:stylo_buddy/Models/RecomendationModel.dart';
import 'package:stylo_buddy/Utils/Utils.dart';

import 'package:stylo_buddy/ViewModel/LoginAndSignUp.dart';
import 'package:stylo_buddy/res/AppUrl.dart';

class ProductData{

  NetworkServices _networkServices=NetworkServices();

  Future<List<ProductModel>> getData(BuildContext context) async
  {
    List<ProductModel> products=[];


    try
        {
          await _networkServices.FetchData(APPURL.products, Headers.header).then((value){
            for (var i in value){
              products.add(ProductModel.fromJson(i));

            }
            Utils.ShowFlushBar(context, "Welcome to Stylo Buddy", Colors.green);
          }).onError((error,StackTrace){


            Utils.ShowFlushBar(context, error.toString(), Colors.red);


          });
        } on SocketException{
      Utils.ShowFlushBar(context, "No internet connection", Colors.red);
    }

  return products;

  }


  Future<List<Outfits>?> postData(Map<String,List<String>> body) async
  {
    List<Outfits>? outfits;

    try
        {
          await _networkServices.PostData("https://uvicorn-main-production.up.railway.app/predict", body).then((value){

         RecomendationModel data=  RecomendationModel.fromJson(value);
         outfits=data.outfits;

          });

        }catch(e){
      String errorMessage=getError(e.toString());


      throw errorMessage;

    }
    return outfits;

  }


}


