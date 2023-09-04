class ProfilePodo {
  int? st;
  String? msg;
  String? functionName;
  ProfileData? data;

  ProfilePodo({this.st, this.msg, this.functionName, this.data});

  ProfilePodo.fromJson(Map<String, dynamic> json) {
    st = json['st'];
    msg = json['msg'];
    functionName = json['function_name'];
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['st'] = this.st;
    data['msg'] = this.msg;
    data['function_name'] = this.functionName;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  int? id;
  String? username;
  String? realUsername;
  String? email;
  bool? emailVerifiedStatus;
  String? created;

  ProfileData(
      {this.id,
      this.username,
      this.realUsername,
      this.email,
      this.emailVerifiedStatus,
      this.created});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    realUsername = json['real_username'];
    email = json['email'];
    emailVerifiedStatus = json['email_verified_status'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['real_username'] = this.realUsername;
    data['email'] = this.email;
    data['email_verified_status'] = this.emailVerifiedStatus;
    data['created'] = this.created;
    return data;
  }
}
