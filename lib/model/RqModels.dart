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
      'username': username!.trim(),
      'email': email!.trim(),
      'password': password!.trim(),
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
      'username': username!.trim(),
      'password': password!.trim(),
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
      'username': otp!.trim(),
      'email': email!.trim(),
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
      'otp': otp!.trim(),
      'email': email!.trim(),
      'password': password!.trim(),
      "web_code": "AnimeRush",
    };

    return map;
  }
}

class SearchModel {
  String? key;
  String? val;
  String? pageId;
  String? sort;
  String? genres;

  SearchModel({
    this.key,
    this.val,
    this.pageId,
    this.sort,
    this.genres,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'key': 'lkzsejhfdcao87634w76w5ejzzhdgfci37qw64egAzjgxhc',
      'val': val!.trim(),
      'page_id': pageId!.trim(),
      'sort': sort!.trim(),
      'genres': genres!.trim(),
    };

    return map;
  }
}

class WatchListModel {
  String? functionName;
  String? type;

  WatchListModel({
    this.functionName,
    this.type,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'function_name': 'watch_list',
      'type': type!.trim(),
    };

    return map;
  }
}
