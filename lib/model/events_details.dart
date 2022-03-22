class EventsDetails {
  bool status;
  int msg;
  Data data;

  EventsDetails({this.status, this.msg, this.data});

  EventsDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  EventsDetail events;

  Data({this.events});

  Data.fromJson(Map<String, dynamic> json) {
    events =
    json['events'] != null ? new EventsDetail.fromJson(json['events']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.events != null) {
      data['events'] = this.events.toJson();
    }
    return data;
  }
}

class EventsDetail {
  List<Details> details;
  Owner owner;
  List<Sponsors> sponsors;
  List<Comments> comments;

  EventsDetail({this.details, this.owner, this.sponsors, this.comments});

  EventsDetail.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details =  List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    if (json['sponsors'] != null) {
      sponsors =  List<Sponsors>();
      json['sponsors'].forEach((v) {
        sponsors.add( Sponsors.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments =  List<Comments>();
      json['comments'].forEach((v) {
        comments.add( Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    if (this.sponsors != null) {
      data['sponsors'] = this.sponsors.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  Details1 details1;
  List<Dates> dates;
  int likes;
  String siteLink;

  Details({this.details1, this.dates, this.likes,this.siteLink});

  Details.fromJson(Map<String, dynamic> json) {
    details1 =
    json['details'] != null ?  Details1.fromJson(json['details']) : null;
    if (json['dates'] != null) {
      dates =  List<Dates>();
      json['dates'].forEach((v) {
        dates.add( Dates.fromJson(v));
      });
    }
    likes = json['likes'];
    siteLink =json['site_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (details1 != null) {
      data['details'] = this.details1.toJson();
    }
    if (dates != null) {
      data['dates'] = this.dates.map((v) => v.toJson()).toList();
    }
    data['likes'] = likes;
    data['site_link'] = siteLink;
    return data;
  }
}

class Details1 {
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
  Details1(
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

  Details1.fromJson(Map<String, dynamic> json) {
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

class Owner {
  int id;
  String fname;
  String lname;
  String email;
  String phone;
  String img;
  String state;
  String description;
  String createdAt;
  String updatedAt;

  Owner(
      {this.id,
        this.fname,
        this.lname,
        this.email,
        this.phone,
        this.img,
        this.state,
        this.description,
        this.createdAt,
        this.updatedAt});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    phone = json['phone'];
    img = json['img'];
    state = json['state'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['img'] = this.img;
    data['state'] = this.state;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Sponsors {
  int id;
  String name;
  String email;
  String mobile;
  String logo;
  String createdAt;
  String updatedAt;
  Pivot pivot;

  Sponsors(
      {this.id,
        this.name,
        this.email,
        this.mobile,
        this.logo,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Sponsors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    logo = json['logo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['logo'] = this.logo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  String eventId;
  String sponserId;

  Pivot({this.eventId, this.sponserId});

  Pivot.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    sponserId = json['sponser_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['sponser_id'] = this.sponserId;
    return data;
  }
}

class Comments {
  int id;
  String body;
  String eventId;
  UserId userId;
  String createdAt;
  String updatedAt;

  Comments(
      {this.id,
        this.body,
        this.eventId,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    eventId = json['event_id'];
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['event_id'] = this.eventId;
    if (this.userId != null) {
      data['user_id'] = this.userId.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UserId {
  String name;
  String img;

  UserId({this.name, this.img});

  UserId.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['img'] = this.img;
    return data;
  }
}