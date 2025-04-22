import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';
import 'package:stylo_buddy/Data/AppException.dart';
import 'package:stylo_buddy/Utils/Utils.dart';
import 'package:stylo_buddy/ViewModel/LoginAndSignUp.dart';
class NetworkServices
{

  Future FetchData(String url,Map<String,String> header) async
  {
    dynamic Jsonresponse;
    try{

      final response=await http.get(Uri.parse(url),headers: header);

      Jsonresponse=ReturnResponse(response);
    }

    catch(e)
    {
      String errorMessage=getError(e.toString());


      throw errorMessage;
    }

    return Jsonresponse;

  }

  Future PostData(String url,Map<String,List<String>> body) async
  {
    dynamic JsonResponse;
    try
        {
          Map<String,String> newlst={};

          body.forEach((key,value)=>newlst[key]=value.join(","));

          final response=await http.post(Uri.parse(url),body: jsonEncode(newlst), headers: {
            'Content-Type': 'application/json',
          },);

          JsonResponse=ReturnResponse(response);

        }
    catch(e)
    {

      String errorMessage=getError(e.toString());


      throw errorMessage;
    }

    return JsonResponse;
  }


  dynamic ReturnResponse(Response response)
  {
    final statuscode=response.statusCode;
    switch(statuscode)
    {
      case 200:
        return jsonDecode(response.body);
      case 400:
          throw BadRequestException("Unable to fetch");
      case 404:
        throw UnauthorizedException("unauthorized request");
      default:
        throw FetchDataException(
            "Error occured while communication with server with status code of $statuscode");



    }

  }
}