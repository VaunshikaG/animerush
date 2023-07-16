class LoginPodo {
  int? st;
  String? msg;
  Data? data;

  LoginPodo({this.st, this.msg, this.data});

  LoginPodo.fromJson(Map<String, dynamic> json) {
    st = json['st'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['st'] = this.st;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? username;
  String? email;
  bool? verified;
  bool? emailVerifiedStatus;
  String? created;
  String? jwtToken;

  Data(
      {this.id,
        this.username,
        this.email,
        this.verified,
        this.emailVerifiedStatus,
        this.created,
        this.jwtToken});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    verified = json['verified'];
    emailVerifiedStatus = json['email_verified_status'];
    created = json['created'];
    jwtToken = json['jwt_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['verified'] = this.verified;
    data['email_verified_status'] = this.emailVerifiedStatus;
    data['created'] = this.created;
    data['jwt_token'] = this.jwtToken;
    return data;
  }
}
