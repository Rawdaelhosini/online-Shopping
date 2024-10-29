class ProductDetails {
  String? name;
  String? description;
  String? image;
  int? price;
  int?old_price;
  int? id;
  int? discount;
  List<String>? images;
  // final List<dynamic> images;

   ProductDetails.fromjson( {required Map<String,dynamic>data}){
    name= data['name'].toString();
    description= data['description'].toString();
    price= data['price'].toInt();
    image= data['image'].toString();
    old_price = data['old_price'].toInt();
    id= data['id'].toInt();
    discount= data['discount'].toInt();
    images = data['images']?? [];
    //  images: data["images"] ?? [];
    
  }
}