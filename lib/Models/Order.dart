class Order {
  int id;
  String name;
  String phone;
  String address;
  String neighborhoodId;
  String driverId;
  String status;
  String note;
  String totalPrice;
  String transactionNo;
  List<dynamic> products;
  String latitude;
  String longitude;

  Order({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.neighborhoodId,
    this.driverId,
    this.status,
    this.note,
    this.totalPrice,
    this.transactionNo,
    this.products,
    this.latitude,
    this.longitude,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    neighborhoodId = json['neighborhood_id'];
    driverId = json['driver_id'];
    status = json['status'];
    note = json['note'];
    totalPrice = json['total_price'];
    transactionNo = json['transactionNo'];
    products = json['products'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['neighborhood_id'] = this.neighborhoodId;
    data['driver_id'] = this.driverId;
    data['status'] = this.status;
    data['note'] = this.note;
    data['total_price'] = this.totalPrice;
    data['transactionNo'] = this.transactionNo;
    data['products'] = this.products;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
