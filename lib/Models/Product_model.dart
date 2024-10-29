//for get product & details
class ProductModel {
  String? name;
  String? description;
  String? image;
  int? price;
  int? oldPrice; // Renamed to follow Dart naming conventions
  int? id;
  int? discount;
  final List<dynamic> images;

  ProductModel.fromJson({required Map<String, dynamic> data})
      : images = List<dynamic>.from(data['images'] ?? []), // Initialize images directly
        name = data['name']?.toString(),
        description = data['description']?.toString(),
        price = data['price'] != null ? (data['price'] as num).toInt() : null,
        image = data['image']?.toString(),
        oldPrice = data['old_price'] != null ? (data['old_price'] as num).toInt() : null,
        id = data['id'] != null ? (data['id'] as num).toInt() : null,
        discount = data['discount'] != null ? (data['discount'] as num).toInt() : null;
}



