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
  DownloadEpisodeLink? downloadEpisodeLink;
  AllResponce? allResponce;

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
      this.downloadEpisodeLink,
      this.allResponce});

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
    downloadEpisodeLink = json['download_episode_link'] != null
        ? new DownloadEpisodeLink.fromJson(json['download_episode_link'])
        : null;
    allResponce = json['all_responce'] != null
        ? new AllResponce.fromJson(json['all_responce'])
        : null;
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
      data['download_episode_link'] = this.downloadEpisodeLink!.toJson();
    }
    if (this.allResponce != null) {
      data['all_responce'] = this.allResponce!.toJson();
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

/*
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
*/

class DownloadEpisodeLink {
  DownloadEpisodeLink();

  DownloadEpisodeLink.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class AllResponce {
  String? embdLink;
  String? streamsbLink;
  String? xstreamcdnLink;
  String? doodstreamLink;
  String? downloadLink;

  AllResponce(
      {this.embdLink,
        this.streamsbLink,
        this.xstreamcdnLink,
        this.doodstreamLink,
        this.downloadLink});

  AllResponce.fromJson(Map<String, dynamic> json) {
    embdLink = json['embd_link'];
    streamsbLink = json['streamsb_link'];
    xstreamcdnLink = json['xstreamcdn_link'];
    doodstreamLink = json['doodstream_link'];
    downloadLink = json['download_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['embd_link'] = this.embdLink;
    data['streamsb_link'] = this.streamsbLink;
    data['xstreamcdn_link'] = this.xstreamcdnLink;
    data['doodstream_link'] = this.doodstreamLink;
    data['download_link'] = this.downloadLink;
    return data;
  }
}
