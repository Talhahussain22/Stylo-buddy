import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylo_buddy/Data/local/DBHelper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stylo_buddy/ViewModel/DataProvider.dart';
import 'package:stylo_buddy/ViewModel/ThemeProvider.dart';

class Outfits extends StatelessWidget {
  const Outfits({super.key});

  @override
  Widget build(BuildContext context) {
    final dataprovider=Provider.of<DataProvider>(context);
    final themeprovider=Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(future:dataprovider.getdatabasedata(tableName: "Outfits") , builder: (context,snapshot){
        if(snapshot.data==null)
          {
            return Center(child: SpinKitFadingCircle(color: themeprovider.isDark? Colors.white:Colors.black,),);
          }
        if(!snapshot.hasData || snapshot.data!.isEmpty)
          {
            return Center(child:Text("No Outfit saved yet!",style: TextStyle(fontSize: 17),));
          }
        else
          {

            return ListView.builder(itemCount: snapshot.data!.length,itemBuilder: (context,index){
              int id=snapshot.data![index]["ID"];
              String shirtUrl=snapshot.data![index]["shirturl"];
              String pantUrl=snapshot.data![index]["panturl"];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.3,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(4, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20)

                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(shirtUrl,height: 120,fit: BoxFit.cover,),
                            Image.network(pantUrl,height: 120,fit: BoxFit.cover,)
                          ],
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(onPressed: (){
                            dataprovider.removefromDatabase(id: id, tableName: "Outfits");

                          }, icon: Icon(Icons.delete,color: Colors.red,)),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
          }
      })
    );

  }
}
