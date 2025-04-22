import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stylo_buddy/ViewModel/ThemeProvider.dart';
import 'package:stylo_buddy/ViewModel/TrendingData.dart';
import 'package:stylo_buddy/Views/GeneralPage.dart';

class Favouritepage extends StatefulWidget {
  const Favouritepage({super.key});

  @override
  State<Favouritepage> createState() => _FavouritepageState();
}

class _FavouritepageState extends State<Favouritepage> {

  @override
  void initState() {
    super.initState();
    Future.microtask((){
      final provider=Provider.of<TrendingData>(context,listen: false);

      provider.getData();
    });
  }
  @override
  Widget build(BuildContext context) {

    final themeprovider=Provider.of<ThemeProvider>(context);
    final provider=Provider.of<TrendingData>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return Generalpage();
          }));
        }, icon: Icon(Icons.arrow_back)),
      ),
      body:provider.dataofFavoritePage()==null?SpinKitFadingCircle(color: themeprovider.isDark?Colors.white:Colors.black,):provider.dataofFavoritePage()!.isEmpty?Center(child: Text("No favourited item!"),):ListView.builder(itemCount: provider.dataofFavoritePage()!.length,itemBuilder:(context,index){
        List<Map<String,dynamic>> data=provider.dataofFavoritePage()!;
        String id=data[index]["ID"];
        return Stack(
          alignment: Alignment.topRight,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Image.network(data[index]["url"],height: 500,fit: BoxFit.fitWidth),
              ),
            ),
            IconButton(onPressed: ()async{

                provider.deleteformfavorite(id: id,index: index);

            }, icon: FaIcon(Icons.delete,color: Colors.red,size: 30,))
          ],
        );
      }),
    );
  }
}
