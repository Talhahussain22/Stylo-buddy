class ProductModel
{
  int? id;
  String? image;
  String? category;

  ProductModel.fromJson(Map<String,dynamic> data )
  {
    id=data['id'];
    image=data['images'];
    category=data['category'];

  }
}