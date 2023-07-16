class SignUpModel {
  String? username;
  String? email;
  String? password;
  String? webCode;

  SignUpModel({
    this.username,
    this.email,
    this.password,
    this.webCode,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username,
      'email': email,
      'password': password,
      "web_code": "AnimeRush",
    };

    return map;
  }
}

class LoginModel {
  String? username;
  String? password;
  String? webCode;

  LoginModel({
    this.username,
    this.password,
    this.webCode,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username,
      'password': password,
      "web_code": "AnimeRush",
    };

    return map;
  }
}

class OtpVerfiyModel {
  String? otp;
  String? email;
  String? webCode;

  OtpVerfiyModel({
    this.otp,
    this.email,
    this.webCode,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': otp,
      'email': email,
      "web_code": "AnimeRush",
    };

    return map;
  }
}

class ChangePasswordModel {
  String? otp;
  String? email;
  String? password;
  String? webCode;

  ChangePasswordModel({
    this.otp,
    this.email,
    this.password,
    this.webCode,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'otp': otp,
      'email': email,
      'password': password,
      "web_code": "AnimeRush",
    };

    return map;
  }
}
