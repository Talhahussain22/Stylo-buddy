import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stylo_buddy/Models/ProductModel.dart';
import 'package:stylo_buddy/Utils/Utils.dart';
import 'package:stylo_buddy/ViewModel/DataProvider.dart';
import 'package:stylo_buddy/ViewModel/ThemeProvider.dart';
import 'package:stylo_buddy/res/Components/imageContainer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context, listen: true);
    final themeprovider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text(
            "My Closet",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),

          bottom: TabBar(
            controller: _tabController,
            unselectedLabelColor:
                themeprovider.isDark ? Colors.white70 : Colors.black45,
            labelColor: themeprovider.isDark ? Colors.white : Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize:  17),
            indicatorColor: themeprovider.isDark ? Colors.white : Colors.black,
            indicatorWeight: 2,
            indicatorSize: TabBarIndicatorSize.tab,

            tabs: [Tab(text: "All"), Tab(text: "Pants"), Tab(text: "Shirts")],
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            TabBarView(
              controller: _tabController,
              children: [
                provider.getData() == null
                    ? Center(
                      child: CircularProgressIndicator(
                        color:
                            themeprovider.isDark ? Colors.white : Colors.black,
                      ),
                    )
                    : GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: provider.datalength(),
                      itemBuilder: (BuildContext context, int index) {
                        final data = provider.getData();

                        return provider.selected[index] == 0
                            ? GestureDetector(
                              onTap: () {
                                provider.toggleSelection(
                                  index,
                                  1,
                                  _currentIndex,
                                );
                                data[index].category == "shirt"
                                    ? provider.addShirt(data[index].image!)
                                    : provider.addPant(data[index].image!);
                              },
                              child: Imagecontainer(
                                imgurl: data![index].image!,
                              ),
                            )
                            : Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    provider.toggleSelection(
                                      index,
                                      0,
                                      _currentIndex,
                                    );
                                    data[index].category == "shirt"
                                        ? provider.removeShirt(
                                          data[index].image!,
                                        )
                                        : provider.removePant(
                                          data[index].image!,
                                        );
                                  },
                                  child: Container(
                                    constraints: BoxConstraints.tight(
                                      Size.fromRadius(100),
                                    ),
                                    child: Imagecontainer(
                                      imgurl: data![index].image!,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.pinkAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    size: 15,
                                    weight: 20,

                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            );
                      },
                    ),
                provider.getPants() == null
                    ? Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    )
                    : GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: provider.getPants()!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = provider.getPants();
                        return provider.selectedPantsIndex[index] == 0
                            ? GestureDetector(
                              onTap: () {
                                provider.toggleSelection(
                                  index,
                                  1,
                                  _currentIndex,
                                );
                                provider.addPant(data[index].image!);
                              },
                              child: Imagecontainer(
                                imgurl: data![index].image!,
                              ),
                            )
                            : Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    provider.toggleSelection(
                                      index,
                                      0,
                                      _currentIndex,
                                    );
                                    provider.removePant(data[index].image!);
                                  },
                                  child: Container(
                                    constraints: BoxConstraints.tight(
                                      Size.fromRadius(100),
                                    ),
                                    child: Imagecontainer(
                                      imgurl: data![index].image!,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: Colors.pinkAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    size: 15,
                                    weight: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            );
                      },
                    ),
                provider.getShirts() == null
                    ? Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    )
                    : GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: provider.getShirts()!.length,
                      itemBuilder: (BuildContext context, int index) {
                        {
                          final data = provider.getShirts();
                          return provider.selectedShirtsIndex[index] == 0
                              ? GestureDetector(
                                onTap: () {
                                  provider.toggleSelection(
                                    index,
                                    1,
                                    _currentIndex,
                                  );
                                  provider.addShirt(data[index].image!);
                                },
                                child: Imagecontainer(
                                  imgurl: data![index].image!,
                                ),
                              )
                              : Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      provider.toggleSelection(
                                        index,
                                        0,
                                        _currentIndex,
                                      );
                                      provider.removeShirt(data[index].image!);
                                    },
                                    child: Container(
                                      constraints: BoxConstraints.tight(
                                        Size.fromRadius(100),
                                      ),
                                      child: Imagecontainer(
                                        imgurl: data![index].image!,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: Colors.pinkAccent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      size: 15,
                                      weight: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              );
                        }
                      },
                    ),
              ],
            ),
            // make this button using container with proper border
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 100),
                color: Colors.green,
                onPressed: ()  {
                  if( provider.FinalSelectedShirts.isEmpty || provider.FinalSelectedPants.isEmpty)
                    {
                      Utils.ShowFlushBar(context,"Please Select both pants and shirts", Colors.red);
                    }
                  else {
                    provider.postdata({
                      "shirts": provider.FinalSelectedShirts,
                      "pants": provider.FinalSelectedPants,
                    }, context);

                    showModalBottomSheet(
                      isDismissible: false,
                      isScrollControlled: true,
                      backgroundColor:
                      themeprovider.isDark ? Colors.black : Colors.white,
                      context: context,
                      builder: (context) {
                        final dataprovider = Provider.of<DataProvider>(context);
                        return Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.9,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                              themeprovider.isDark
                                  ? Colors.white
                                  : Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 20,
                                      ),
                                      child: Text(
                                        "Done",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap:(){
                                      dataprovider.addtoDatabase(panturl: dataprovider.outfits![dataprovider.currentIndex].bestMatchingPant!, shirturl: dataprovider.outfits![dataprovider.currentIndex].shirt!, tableName: "Outfits");
                                      Utils.ShowFlushBar(context, "Successfully Added to Outfits ", Colors.green);
                        },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 20,
                                      ),
                                      child: Text(
                                        "Save Outfit",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Divider(
                                color:
                                themeprovider.isDark
                                    ? Colors.white
                                    : Colors.black38,
                              ),
                              SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20,
                                ),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.6,
                                    minWidth: double.infinity,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                          offset: Offset(4, 4),
                                        ),
                                      ],
                                    ),
                                    child:
                                    dataprovider.getOutfit() == null
                                        ? Center(
                                      child: SpinKitFadingCircle(color: Colors.black,)
                                    )
                                        : Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 50
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.network(
                                                dataprovider
                                                    .outfits![dataprovider
                                                    .currentIndex]
                                                    .shirt!,
                                                height: 200,
                                                width: 200,
                                                fit: BoxFit.cover,
                                              ),
                                              Image.network(
                                                dataprovider
                                                    .outfits![dataprovider
                                                    .currentIndex]
                                                    .bestMatchingPant!,
                                                height: 200,
                                                width: 200,
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceAround,
                                          children: [

                                            dataprovider.currentIndex > 0
                                                ? TextButton(onPressed: () {
                                              dataprovider.decrementIndex();
                                            },
                                                child: Text("Back",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.blue,
                                                      fontSize: 18),))
                                                : Text("Back", style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black54),),
                                            dataprovider.currentIndex <
                                                dataprovider.outfitlenght - 1
                                                ? TextButton(onPressed: () {
                                              dataprovider.incrementIndex();
                                            },
                                                child: Text("Next",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.blue,
                                                      fontSize: 18),))
                                                : Text("Next", style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black54),)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }},
                child: Text(
                  "Analyze",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
