class RecomendationModel {
  List<Outfits>? outfits;

  RecomendationModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      outfits = [];
      json['result'].forEach((v) {
        outfits!.add(Outfits.fromJson(v));
      });
    }
  }


}

class Outfits {
  String? shirt;
  String? bestMatchingPant;
  String? similarityScore;

  Outfits({this.shirt, this.bestMatchingPant, this.similarityScore});

  Outfits.fromJson(Map<String, dynamic> json) {
    shirt = json['shirt'];
    bestMatchingPant = json['best_matching_pant'];
    similarityScore = json['similarity_score'];
  }


}
