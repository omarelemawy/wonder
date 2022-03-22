class SponserModel {
  int  id;
  String  name;
  String  email;
  String  mobile;
  String  logo;
  String  createdAt;
  String  updatedAt;

  SponserModel(
      {this.id,
        this.name,
        this.email,
        this.mobile,
        this.logo,
        this.createdAt,
        this.updatedAt});

  SponserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    logo = json['logo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
