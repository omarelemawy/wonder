class ProfileModel {
  int id;
  String fname;
  String lname;
  String email;
  String phone;
  String emailVerifiedAt;
  String code;
  String img;
  String state;
  String rememberToken;
  String createdAt;
  String updatedAt;

  ProfileModel(
      {this.id,
        this.fname,
        this.lname,
        this.email,
        this.phone,
        this.emailVerifiedAt,
        this.code,
        this.img,
        this.state,
        this.rememberToken,
        this.createdAt,
        this.updatedAt});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['fname'];
    lname = json['lname'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    code = json['code'];
    img = json['img'];
    state = json['state'];
    rememberToken = json['remember_token'];
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
    data['email_verified_at'] = this.emailVerifiedAt;
    data['code'] = this.code;
    data['img'] = this.img;
    data['state'] = this.state;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}