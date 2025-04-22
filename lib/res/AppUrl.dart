import 'package:flutter_dotenv/flutter_dotenv.dart';
class APPURL
{
  static String baseUrl=dotenv.get("baseUrl");
  static String products=dotenv.get("products");
  static String trendingProducts=dotenv.get("trendingProducts");

}

class Headers
{
  static String apikey=dotenv.get("apikey");

  static String authorization=dotenv.get("authorization");
  static String contenttype=dotenv.get("contenttype");
  static Map<String,String> header={"apikey":apikey,
                                     "Authorization":"Bearer $apikey",
    'Content-Type': contenttype};
}