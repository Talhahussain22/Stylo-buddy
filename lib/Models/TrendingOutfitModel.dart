class TrendingOutfitModel {
  List<Outfit>? outfits;

  TrendingOutfitModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      outfits = [];
      json['products'].forEach((v) {
        outfits!.add(Outfit.fromJson(v));
      });
    }
  }


}

class Outfit {
  String? productID;
  String? imageUrl;
  String? time;

  Outfit({this.productID, this.imageUrl, this.time});

  Outfit.fromJson(Map<String, dynamic> json) {
    productID = json['product_id'];
    imageUrl = json['image_url'];
    time= json['timestamp'];
  }


}
