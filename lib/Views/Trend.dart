import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:stylo_buddy/Models/TrendingOutfitModel.dart';
import 'package:stylo_buddy/ViewModel/TrendingData.dart';
import 'package:stylo_buddy/ViewModel/ThemeProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:stylo_buddy/Views/favouritePage.dart';

class Trend extends StatefulWidget {


  Trend({super.key});

  @override
  State<Trend> createState() => _TrendState();
}

class _TrendState extends State<Trend> {
  TrendingData dataprovider = TrendingData();

  @override
  void initState() {

    super.initState();
    final provider=Provider.of<TrendingData>(context,listen: false);
    Future.microtask((){
      provider.fetchData(context);
    });
  }

  @override
  Widget build(BuildContext context) {

  final themeprovider = Provider.of<ThemeProvider>(context);
  final trendingdataprovider=Provider.of<TrendingData>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return Favouritepage();
            }));
          },
          icon: FaIcon(FontAwesomeIcons.solidHeart,color: Colors.red,),)
        ],
      ),
      body:trendingdataprovider.outfits==null || trendingdataprovider.outfits!.isEmpty?Center(child: SpinKitFadingCircle(color: themeprovider.isDark? Colors.white:Colors.black,),):

            ListView.builder(
              itemCount: trendingdataprovider.getoutfitlenght(),
              itemBuilder: (context, index) {
                List<String> favourties=trendingdataprovider.getfavouritedProducts();
                List<Outfit> data=trendingdataprovider.getOutfits()!;
                String id=data[index].productID!;
                bool isfavourite=favourties.contains(id);

                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: double.infinity),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Image.network(data[index].imageUrl!,height: 500,fit: BoxFit.fitWidth),
                      ),
                    ),
                    IconButton(onPressed: ()async{

                      if(isfavourite)
                        {
                          trendingdataprovider.delete(id: id);
                        }
                      else
                        {
                          trendingdataprovider.Insert(id:data[index].productID!, url: data[index].imageUrl!);
                        }


                    }, icon: FaIcon(isfavourite ?FontAwesomeIcons.solidHeart:FontAwesomeIcons.heart,color: Colors.red,size: 30,))
                  ],
                );
              },
            ));
          }

  }

