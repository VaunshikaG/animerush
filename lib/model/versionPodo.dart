class VersionPodo {
  int? st;
  String? msg;
  Data? data;

  VersionPodo({this.st, this.msg, this.data});

  VersionPodo.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? domain;
  String? apkUrl;
  String? version;
  bool? showLogin;
  String? webCode;
  String? description;
  String? mainColor;
  String? subColor;
  String? logo;
  String? fevicon;
  String? email;
  String? discord;
  String? donationLink;
  String? twitterLink;
  String? teleLink;

  Data(
      {this.name,
      this.domain,
      this.apkUrl,
      this.version,
      this.showLogin,
      this.webCode,
      this.description,
      this.mainColor,
      this.subColor,
      this.logo,
      this.fevicon,
      this.email,
      this.discord,
      this.donationLink,
      this.twitterLink,
      this.teleLink});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    domain = json['domain'];
    apkUrl = json['apk_url'];
    version = json['version'];
    showLogin = json['show_login'];
    webCode = json['web_code'];
    description = json['description'];
    mainColor = json['main_color'];
    subColor = json['sub_color'];
    logo = json['logo'];
    fevicon = json['fevicon'];
    email = json['email'];
    discord = json['discord'];
    donationLink = json['donation_link'];
    twitterLink = json['twitter_link'];
    teleLink = json['tele_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['domain'] = this.domain;
    data['apk_url'] = this.apkUrl;
    data['version'] = this.version;
    data['show_login'] = this.showLogin;
    data['web_code'] = this.webCode;
    data['description'] = this.description;
    data['main_color'] = this.mainColor;
    data['sub_color'] = this.subColor;
    data['logo'] = this.logo;
    data['fevicon'] = this.fevicon;
    data['email'] = this.email;
    data['discord'] = this.discord;
    data['donation_link'] = this.donationLink;
    data['twitter_link'] = this.twitterLink;
    data['tele_link'] = this.teleLink;
    return data;
  }
}
