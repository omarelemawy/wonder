class FavoriteModel {
  List<FavEvents> events;

  FavoriteModel({this.events});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events =  List<FavEvents>();
      json['events'].forEach((v) {
        events.add( FavEvents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.events != null) {
      data['events'] = this.events.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavEvents {
  int id;
  String titleAr;
  String titleEn;
  String descriptionAr;
  String descriptionEn;
  String cover;
  String lng;
  String lat;
  String price;
  String addressId;
  String vendorId;
  String categoryId;
  String qr;
  String createdAt;
  String updatedAt;
  String type;
  String url;

  FavEvents(
      {this.id,
        this.titleAr,
        this.titleEn,
        this.descriptionAr,
        this.descriptionEn,
        this.cover,
        this.lng,
        this.lat,
        this.price,
        this.addressId,
        this.vendorId,
        this.categoryId,
        this.qr,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.url});

  FavEvents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['title_ar'];
    titleEn = json['title_en'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    cover = json['cover'];
    lng = json['lng'];
    lat = json['lat'];
    price = json['price'];
    addressId = json['address_id'];
    vendorId = json['vendor_id'];
    categoryId = json['category_id'];
    qr = json['qr'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title_ar'] = this.titleAr;
    data['title_en'] = this.titleEn;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['cover'] = this.cover;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['price'] = this.price;
    data['address_id'] = this.addressId;
    data['vendor_id'] = this.vendorId;
    data['category_id'] = this.categoryId;
    data['qr'] = this.qr;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}