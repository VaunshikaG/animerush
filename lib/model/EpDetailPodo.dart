class EpDetailPodo {
  int? st;
  String? msg;
  Data? data;

  EpDetailPodo({this.st, this.msg, this.data});

  EpDetailPodo.fromJson(Map<String, dynamic> json) {
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
  dynamic epRank;
  String? episodeName;
  String? episodeTitle;
  String? image;
  String? videoDetails;
  String? gogoStreamingUrl;
  String? webEpisodeUrl;
  StreamDetails? streamDetails;
  EpisodeLink? episodeLink;
  List<DownloadEpisodeLink>? downloadEpisodeLink;

  Data(
      {this.epRank,
      this.episodeName,
      this.episodeTitle,
      this.image,
      this.videoDetails,
      this.gogoStreamingUrl,
      this.webEpisodeUrl,
      this.streamDetails,
      this.episodeLink,
      this.downloadEpisodeLink});

  Data.fromJson(Map<String, dynamic> json) {
    epRank = json['ep_rank'];
    episodeName = json['episode_name'];
    episodeTitle = json['episode_title'];
    image = json['image'];
    videoDetails = json['video_details'];
    gogoStreamingUrl = json['gogo_streaming_url'];
    webEpisodeUrl = json['web_episode_url'];
    streamDetails = json['stream_details'] != null
        ? new StreamDetails.fromJson(json['stream_details'])
        : null;
    episodeLink = json['episode_link'] != null
        ? new EpisodeLink.fromJson(json['episode_link'])
        : null;
    if (json['download_episode_link'] != null) {
      downloadEpisodeLink = <DownloadEpisodeLink>[];
      json['download_episode_link'].forEach((v) {
        downloadEpisodeLink!.add(new DownloadEpisodeLink.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ep_rank'] = this.epRank;
    data['episode_name'] = this.episodeName;
    data['episode_title'] = this.episodeTitle;
    data['image'] = this.image;
    data['video_details'] = this.videoDetails;
    data['gogo_streaming_url'] = this.gogoStreamingUrl;
    data['web_episode_url'] = this.webEpisodeUrl;
    if (this.streamDetails != null) {
      data['stream_details'] = this.streamDetails!.toJson();
    }
    if (this.episodeLink != null) {
      data['episode_link'] = this.episodeLink!.toJson();
    }
    if (this.downloadEpisodeLink != null) {
      data['download_episode_link'] =
          this.downloadEpisodeLink!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StreamDetails {
  String? download;
  String? stream;

  StreamDetails({this.download, this.stream});

  StreamDetails.fromJson(Map<String, dynamic> json) {
    download = json['download'];
    stream = json['stream'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['download'] = this.download;
    data['stream'] = this.stream;
    return data;
  }
}

class EpisodeLink {
  String? file;
  String? label;
  String? type;

  EpisodeLink({this.file, this.label, this.type});

  EpisodeLink.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    label = json['label'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['label'] = this.label;
    data['type'] = this.type;
    return data;
  }
}

class DownloadEpisodeLink {
  String? quality;
  String? link;

  DownloadEpisodeLink({this.quality, this.link});

  DownloadEpisodeLink.fromJson(Map<String, dynamic> json) {
    quality = json['quality'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quality'] = this.quality;
    data['link'] = this.link;
    return data;
  }
}
