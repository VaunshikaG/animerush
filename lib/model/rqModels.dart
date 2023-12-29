class SignUpModel {
  String? username;
  String? email;
  String? password;
  String? webCode;
  String? deviceId;

  SignUpModel({
    this.username,
    this.email,
    this.password,
    this.webCode,
    this.deviceId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username!.trim(),
      'email': email!.trim(),
      'password': password!.trim(),
      'device_id': deviceId,
      "web_code": "AnimeRush",
    };

    return map;
  }
}

class LoginModel {
  String? username;
  String? password;
  String? webCode;
  String? deviceId;

  LoginModel({
    this.username,
    this.password,
    this.webCode,
    this.deviceId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username!.trim(),
      'password': password!.trim(),
      'device_id': deviceId,
      "web_code": "AnimeRush",
    };

    return map;
  }
}

class OtpVerfiyModel {
  String? otp;
  String? email;
  String? webCode;
  String? deviceId;

  OtpVerfiyModel({
    this.otp,
    this.email,
    this.webCode,
    this.deviceId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'otp': otp!.trim(),
      'email': email!.trim(),
      'device_id': deviceId,
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
  String? deviceId;

  ChangePasswordModel({
    this.otp,
    this.email,
    this.password,
    this.webCode,
    this.deviceId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'otp': otp!.trim(),
      'email': email!.trim(),
      'password': password!.trim(),
      'device_id': deviceId,
      "web_code": "AnimeRush",
    };

    return map;
  }
}

class SearchModel {
  String? key;
  String? val;
  String? searchKeywords;
  String? pageId;
  String? sort;
  String? genres;
  String? deviceId;

  SearchModel({
    this.key,
    this.val,
    this.searchKeywords,
    this.pageId,
    this.sort,
    this.genres,
    this.deviceId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'key': 'lkzsejhfdcao87634w76w5ejzzhdgfci37qw64egAzjgxhc',
      'val': val,
      'search-keywords': searchKeywords,
      'page_id': pageId,
      'sort': sort,
      'genres': genres,
      'device_id': deviceId,
    };

    return map;
  }
}

class ProfilePasswordModel {
  String? functionName;
  String? currentPassword;
  String? newPassword;
  String? deviceId;

  ProfilePasswordModel({
    this.functionName,
    this.currentPassword,
    this.newPassword,
    this.deviceId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'function_name': 'change-password',
      'current_password': currentPassword!.trim(),
      'new_password': newPassword!.trim(),
      'device_id': deviceId,
    };

    return map;
  }
}
