class CommonResponse {
  int? st;
  String? msg;

  CommonResponse({this.st, this.msg});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    st = json['st'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['st'] = this.st;
    data['msg'] = this.msg;
    return data;
  }
}
