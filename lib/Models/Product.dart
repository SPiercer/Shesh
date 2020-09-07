class Product {
  int id;
  String nameAr;
  String nameEn;
  String descriptionEn;
  String descriptionAr;
  String categoryId;
  String salePrice;
  List<String> colors;
  String stock;
  String image;
  String createdAt;
  String updatedAt;
  String imagePath;
  String name;
  String description;
  Map<String,dynamic> pivot;

  Product(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.descriptionEn,
      this.descriptionAr,
      this.categoryId,
      this.salePrice,
      this.colors,
      this.stock,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.imagePath,
      this.name,
      this.description,
      this.pivot});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    categoryId = json['category_id'];
    salePrice = json['sale_price'];
    colors = json['colors'];
    stock = json['stock'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imagePath = json['image_path'];
    name = json['name'];
    description = json['description'];
    pivot = json['pivot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['description_en'] = this.descriptionEn;
    data['description_ar'] = this.descriptionAr;
    data['category_id'] = this.categoryId;
    data['sale_price'] = this.salePrice;
    data['colors'] = this.colors;
    data['stock'] = this.stock;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_path'] = this.imagePath;
    data['name'] = this.name;
    data['description'] = this.description;
    data['pivot'] = this.pivot;
    return data;
  }
}

class Pivot {
  String orderId;
  String productId;
  String quantity;
  String color;

  Pivot({this.orderId, this.productId, this.quantity, this.color});

  Pivot.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['color'] = this.color;
    return data;
  }
}
