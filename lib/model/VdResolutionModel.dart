class VdResolutionModel {
  String? s360p;
  String? s480p;
  String? s720p;
  String? s1080p;

  VdResolutionModel({this.s360p, this.s480p, this.s720p, this.s1080p});

  VdResolutionModel.fromJson(Map<String, dynamic> json) {
    s360p = json['360p'];
    s480p = json['480p'];
    s720p = json['720p'];
    s1080p = json['1080p'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['360p'] = this.s360p;
    data['480p'] = this.s480p;
    data['720p'] = this.s720p;
    data['1080p'] = this.s1080p;
    return data;
  }
}
