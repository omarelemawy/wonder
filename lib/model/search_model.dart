class SearchModel {
  Details details;
  List<Dates> dates;
  int likes;

  SearchModel({this.details, this.dates, this.likes});

  SearchModel.fromJson(Map<String, dynamic> json) {
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    if (json['dates'] != null) {
      dates = new List<Dates>();
      json['dates'].forEach((v) {
        dates.add(new Dates.fromJson(v));
      });
    }
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    if (this.dates != null) {
      data['dates'] = this.dates.map((v) => v.toJson()).toList();
    }
    data['likes'] = this.likes;
    return data;
  }
}

class Details {
  int id;
  String titleAr;
  String titleEn;
  String descriptionAr;
  String descriptionEn;
  String cover;
  String lng;
  String lat;
  String price;
  int addressId;
  String vendorId;
  String categoryId;
  String qr;
  String createdAt;
  String updatedAt;
  String type;
  String url;

  Details(
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

  Details.fromJson(Map<String, dynamic> json) {
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

class Dates {
  int id;
  String startDate;
  String endDate;
  String eventId;
  String createdAt;
  String updatedAt;
  String maxCapacity;
  String availableSeats;

  Dates(
      {this.id,
        this.startDate,
        this.endDate,
        this.eventId,
        this.createdAt,
        this.updatedAt,
        this.maxCapacity,
        this.availableSeats});

  Dates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    eventId = json['event_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    maxCapacity = json['max_capacity'];
    availableSeats = json['available_seats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['event_id'] = this.eventId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['max_capacity'] = this.maxCapacity;
    data['available_seats'] = this.availableSeats;
    return data;
  }
}