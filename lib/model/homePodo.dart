class HomePodo {
  int? st;
  String? msg;
  List<IsSpotlightData>? isSpotlightData;
  List<TopStreamingData>? topStreamingData;
  List<LatestMoviesData>? latestMoviesData;
  List<LatestSpecialData>? latestSpecialData;
  List<LatestOnasData>? latestOnasData;
  List<LatestOvasData>? latestOvasData;
  List<RecentlyAddedSubData>? recentlyAddedSubData;
  List<RecentlyAddedDubData>? recentlyAddedDubData;

  HomePodo(
      {this.st,
      this.msg,
      this.isSpotlightData,
      this.topStreamingData,
      this.latestMoviesData,
      this.latestSpecialData,
      this.latestOnasData,
      this.latestOvasData,
      this.recentlyAddedSubData,
      this.recentlyAddedDubData});

  HomePodo.fromJson(Map<String, dynamic> json) {
    st = json['st'];
    msg = json['msg'];
    if (json['is_spotlight_data'] != null) {
      isSpotlightData = <IsSpotlightData>[];
      json['is_spotlight_data'].forEach((v) {
        isSpotlightData!.add(IsSpotlightData.fromJson(v));
      });
    }
    if (json['top_streaming_data'] != null) {
      topStreamingData = <TopStreamingData>[];
      json['top_streaming_data'].forEach((v) {
        topStreamingData!.add(TopStreamingData.fromJson(v));
      });
    }
    if (json['latest_movies_data'] != null) {
      latestMoviesData = <LatestMoviesData>[];
      json['latest_movies_data'].forEach((v) {
        latestMoviesData!.add(LatestMoviesData.fromJson(v));
      });
    }
    if (json['latest_special_data'] != null) {
      latestSpecialData = <LatestSpecialData>[];
      json['latest_special_data'].forEach((v) {
        latestSpecialData!.add(LatestSpecialData.fromJson(v));
      });
    }
    if (json['latest_onas_data'] != null) {
      latestOnasData = <LatestOnasData>[];
      json['latest_onas_data'].forEach((v) {
        latestOnasData!.add(LatestOnasData.fromJson(v));
      });
    }
    if (json['latest_ovas_data'] != null) {
      latestOvasData = <LatestOvasData>[];
      json['latest_ovas_data'].forEach((v) {
        latestOvasData!.add(LatestOvasData.fromJson(v));
      });
    }
    if (json['recently_added_sub_data'] != null) {
      recentlyAddedSubData = <RecentlyAddedSubData>[];
      json['recently_added_sub_data'].forEach((v) {
        recentlyAddedSubData!.add(RecentlyAddedSubData.fromJson(v));
      });
    }
    if (json['recently_added_dub_data'] != null) {
      recentlyAddedDubData = <RecentlyAddedDubData>[];
      json['recently_added_dub_data'].forEach((v) {
        recentlyAddedDubData!.add(RecentlyAddedDubData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['st'] = this.st;
    data['msg'] = this.msg;
    if (this.isSpotlightData != null) {
      data['is_spotlight_data'] =
          this.isSpotlightData!.map((v) => v.toJson()).toList();
    }
    if (this.topStreamingData != null) {
      data['top_streaming_data'] =
          this.topStreamingData!.map((v) => v.toJson()).toList();
    }
    if (this.latestMoviesData != null) {
      data['latest_movies_data'] =
          this.latestMoviesData!.map((v) => v.toJson()).toList();
    }
    if (this.latestSpecialData != null) {
      data['latest_special_data'] =
          this.latestSpecialData!.map((v) => v.toJson()).toList();
    }
    if (this.latestOnasData != null) {
      data['latest_onas_data'] =
          this.latestOnasData!.map((v) => v.toJson()).toList();
    }
    if (this.latestOvasData != null) {
      data['latest_ovas_data'] =
          this.latestOvasData!.map((v) => v.toJson()).toList();
    }
    if (this.recentlyAddedSubData != null) {
      data['recently_added_sub_data'] =
          this.recentlyAddedSubData!.map((v) => v.toJson()).toList();
    }
    if (this.recentlyAddedDubData != null) {
      data['recently_added_dub_data'] =
          this.recentlyAddedDubData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IsSpotlightData {
  int? id;
  String? name;
  String? japaneseName;
  String? englishName;
  String? thumbnail;
  String? image;
  String? imageHighQuality;
  String? aniImage;
  String? banner;
  String? type;
  String? animeWatchType;
  String? status;
  bool? active;
  String? episodes;
  String? episodesTillNow;
  String? ratingAge;
  String? duration;
  String? description;
  String? airedYear;
  String? premiered;
  int? views;
  List<Categories>? categories;
  List<Studios>? studios;
  List<Producers>? producers;
  ScheduleEp? scheduleEp;

  IsSpotlightData(
      {this.id,
      this.name,
      this.japaneseName,
      this.englishName,
      this.thumbnail,
      this.image,
      this.imageHighQuality,
      this.aniImage,
      this.banner,
      this.type,
      this.animeWatchType,
      this.status,
      this.active,
      this.episodes,
      this.episodesTillNow,
      this.ratingAge,
      this.duration,
      this.description,
      this.airedYear,
      this.premiered,
      this.views,
      this.categories,
      this.studios,
      this.producers,
      this.scheduleEp});

  IsSpotlightData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    japaneseName = json['japanese_name'];
    englishName = json['english_name'];
    thumbnail = json['thumbnail'];
    image = json['image'];
    imageHighQuality = json['image_high_quality'];
    aniImage = json['ani_image'];
    banner = json['banner'];
    type = json['type'];
    animeWatchType = json['anime_watch_type'];
    status = json['status'];
    active = json['active'];
    episodes = json['episodes'];
    episodesTillNow = json['episodes_till_now'];
    ratingAge = json['rating_age'];
    duration = json['duration'];
    description = json['description'];
    airedYear = json['aired_year'];
    premiered = json['premiered'];
    views = json['views'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['studios'] != null) {
      studios = <Studios>[];
      json['studios'].forEach((v) {
        studios!.add(Studios.fromJson(v));
      });
    }
    if (json['producers'] != null) {
      producers = <Producers>[];
      json['producers'].forEach((v) {
        producers!.add(Producers.fromJson(v));
      });
    }
    scheduleEp = json['schedule_ep'] != null
        ? ScheduleEp.fromJson(json['schedule_ep'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['japanese_name'] = this.japaneseName;
    data['english_name'] = this.englishName;
    data['thumbnail'] = this.thumbnail;
    data['image'] = this.image;
    data['image_high_quality'] = this.imageHighQuality;
    data['ani_image'] = this.aniImage;
    data['banner'] = this.banner;
    data['type'] = this.type;
    data['anime_watch_type'] = this.animeWatchType;
    data['status'] = this.status;
    data['active'] = this.active;
    data['episodes'] = this.episodes;
    data['episodes_till_now'] = this.episodesTillNow;
    data['rating_age'] = this.ratingAge;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['aired_year'] = this.airedYear;
    data['premiered'] = this.premiered;
    data['views'] = this.views;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.studios != null) {
      data['studios'] = this.studios!.map((v) => v.toJson()).toList();
    }
    if (this.producers != null) {
      data['producers'] = this.producers!.map((v) => v.toJson()).toList();
    }
    if (this.scheduleEp != null) {
      data['schedule_ep'] = this.scheduleEp!.toJson();
    }
    return data;
  }
}

class Categories {
  int? anime;
  int? category;
  String? categoryName;
  String? categoryNameVal;

  Categories(
      {this.anime, this.category, this.categoryName, this.categoryNameVal});

  Categories.fromJson(Map<String, dynamic> json) {
    anime = json['anime'];
    category = json['category'];
    categoryName = json['category_name'];
    categoryNameVal = json['category_name_val'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['anime'] = this.anime;
    data['category'] = this.category;
    data['category_name'] = this.categoryName;
    data['category_name_val'] = this.categoryNameVal;
    return data;
  }
}

class Studios {
  int? anime;
  int? studio;
  String? name;
  String? nameVal;

  Studios({this.anime, this.studio, this.name, this.nameVal});

  Studios.fromJson(Map<String, dynamic> json) {
    anime = json['anime'];
    studio = json['studio'];
    name = json['name'];
    nameVal = json['name_val'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['anime'] = this.anime;
    data['studio'] = this.studio;
    data['name'] = this.name;
    data['name_val'] = this.nameVal;
    return data;
  }
}

class Producers {
  Producers();

  Producers.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return data;
  }
}

class ScheduleEp {
  String? name;
  String? day;
  String? date;
  String? time;
  bool? isShow;

  ScheduleEp({this.name, this.day, this.date, this.time, this.isShow});

  ScheduleEp.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    day = json['day'];
    date = json['date'];
    time = json['time'];
    isShow = json['is_show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['day'] = this.day;
    data['date'] = this.date;
    data['time'] = this.time;
    data['is_show'] = this.isShow;
    return data;
  }
}

class TopStreamingData {
  int? id;
  String? name;
  String? japaneseName;
  String? englishName;
  String? thumbnail;
  String? image;
  String? imageHighQuality;
  String? aniImage;
  String? banner;
  String? type;
  String? animeWatchType;
  String? status;
  bool? active;
  String? episodes;
  String? episodesTillNow;
  String? ratingAge;
  String? duration;
  String? description;
  String? airedYear;
  String? premiered;
  int? views;
  List<Categories>? categories;
  List<Studios>? studios;
  List<Producers>? producers;
  ScheduleEp? scheduleEp;

  TopStreamingData(
      {this.id,
      this.name,
      this.japaneseName,
      this.englishName,
      this.thumbnail,
      this.image,
      this.imageHighQuality,
      this.aniImage,
      this.banner,
      this.type,
      this.animeWatchType,
      this.status,
      this.active,
      this.episodes,
      this.episodesTillNow,
      this.ratingAge,
      this.duration,
      this.description,
      this.airedYear,
      this.premiered,
      this.views,
      this.categories,
      this.studios,
      this.producers,
      this.scheduleEp});

  TopStreamingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    japaneseName = json['japanese_name'];
    englishName = json['english_name'];
    thumbnail = json['thumbnail'];
    image = json['image'];
    imageHighQuality = json['image_high_quality'];
    aniImage = json['ani_image'];
    banner = json['banner'];
    type = json['type'];
    animeWatchType = json['anime_watch_type'];
    status = json['status'];
    active = json['active'];
    episodes = json['episodes'];
    episodesTillNow = json['episodes_till_now'];
    ratingAge = json['rating_age'];
    duration = json['duration'];
    description = json['description'];
    airedYear = json['aired_year'];
    premiered = json['premiered'];
    views = json['views'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['studios'] != null) {
      studios = <Studios>[];
      json['studios'].forEach((v) {
        studios!.add(Studios.fromJson(v));
      });
    }
    if (json['producers'] != null) {
      producers = <Producers>[];
      json['producers'].forEach((v) {
        producers!.add(Producers.fromJson(v));
      });
    }
    scheduleEp = json['schedule_ep'] != null
        ? ScheduleEp.fromJson(json['schedule_ep'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['japanese_name'] = this.japaneseName;
    data['english_name'] = this.englishName;
    data['thumbnail'] = this.thumbnail;
    data['image'] = this.image;
    data['image_high_quality'] = this.imageHighQuality;
    data['ani_image'] = this.aniImage;
    data['banner'] = this.banner;
    data['type'] = this.type;
    data['anime_watch_type'] = this.animeWatchType;
    data['status'] = this.status;
    data['active'] = this.active;
    data['episodes'] = this.episodes;
    data['episodes_till_now'] = this.episodesTillNow;
    data['rating_age'] = this.ratingAge;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['aired_year'] = this.airedYear;
    data['premiered'] = this.premiered;
    data['views'] = this.views;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.studios != null) {
      data['studios'] = this.studios!.map((v) => v.toJson()).toList();
    }
    if (this.producers != null) {
      data['producers'] = this.producers!.map((v) => v.toJson()).toList();
    }
    if (this.scheduleEp != null) {
      data['schedule_ep'] = this.scheduleEp!.toJson();
    }
    return data;
  }
}

class LatestMoviesData {
  int? id;
  String? name;
  String? japaneseName;
  String? englishName;
  String? thumbnail;
  String? image;
  String? imageHighQuality;
  String? aniImage;
  String? banner;
  String? type;
  String? animeWatchType;
  String? status;
  bool? active;
  String? episodes;
  String? episodesTillNow;
  String? ratingAge;
  String? duration;
  String? description;
  String? airedYear;
  String? premiered;
  int? views;
  List<Categories>? categories;
  List<Studios>? studios;
  List<Producers>? producers;
  ScheduleEp? scheduleEp;

  LatestMoviesData(
      {this.id,
      this.name,
      this.japaneseName,
      this.englishName,
      this.thumbnail,
      this.image,
      this.imageHighQuality,
      this.aniImage,
      this.banner,
      this.type,
      this.animeWatchType,
      this.status,
      this.active,
      this.episodes,
      this.episodesTillNow,
      this.ratingAge,
      this.duration,
      this.description,
      this.airedYear,
      this.premiered,
      this.views,
      this.categories,
      this.studios,
      this.producers,
      this.scheduleEp});

  LatestMoviesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    japaneseName = json['japanese_name'];
    englishName = json['english_name'];
    thumbnail = json['thumbnail'];
    image = json['image'];
    imageHighQuality = json['image_high_quality'];
    aniImage = json['ani_image'];
    banner = json['banner'];
    type = json['type'];
    animeWatchType = json['anime_watch_type'];
    status = json['status'];
    active = json['active'];
    episodes = json['episodes'];
    episodesTillNow = json['episodes_till_now'];
    ratingAge = json['rating_age'];
    duration = json['duration'];
    description = json['description'];
    airedYear = json['aired_year'];
    premiered = json['premiered'];
    views = json['views'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['studios'] != null) {
      studios = <Studios>[];
      json['studios'].forEach((v) {
        studios!.add(Studios.fromJson(v));
      });
    }
    if (json['producers'] != null) {
      producers = <Producers>[];
      json['producers'].forEach((v) {
        producers!.add(Producers.fromJson(v));
      });
    }
    scheduleEp = json['schedule_ep'] != null
        ? ScheduleEp.fromJson(json['schedule_ep'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['japanese_name'] = this.japaneseName;
    data['english_name'] = this.englishName;
    data['thumbnail'] = this.thumbnail;
    data['image'] = this.image;
    data['image_high_quality'] = this.imageHighQuality;
    data['ani_image'] = this.aniImage;
    data['banner'] = this.banner;
    data['type'] = this.type;
    data['anime_watch_type'] = this.animeWatchType;
    data['status'] = this.status;
    data['active'] = this.active;
    data['episodes'] = this.episodes;
    data['episodes_till_now'] = this.episodesTillNow;
    data['rating_age'] = this.ratingAge;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['aired_year'] = this.airedYear;
    data['premiered'] = this.premiered;
    data['views'] = this.views;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.studios != null) {
      data['studios'] = this.studios!.map((v) => v.toJson()).toList();
    }
    if (this.producers != null) {
      data['producers'] = this.producers!.map((v) => v.toJson()).toList();
    }
    if (this.scheduleEp != null) {
      data['schedule_ep'] = this.scheduleEp!.toJson();
    }
    return data;
  }
}

class LatestSpecialData {
  int? id;
  String? name;
  String? japaneseName;
  String? englishName;
  String? thumbnail;
  String? image;
  String? imageHighQuality;
  String? aniImage;
  String? banner;
  String? type;
  String? animeWatchType;
  String? status;
  bool? active;
  String? episodes;
  String? episodesTillNow;
  String? ratingAge;
  String? duration;
  String? description;
  String? airedYear;
  String? premiered;
  int? views;
  List<Categories>? categories;
  List<Studios>? studios;
  List<Producers>? producers;
  ScheduleEp? scheduleEp;

  LatestSpecialData(
      {this.id,
      this.name,
      this.japaneseName,
      this.englishName,
      this.thumbnail,
      this.image,
      this.imageHighQuality,
      this.aniImage,
      this.banner,
      this.type,
      this.animeWatchType,
      this.status,
      this.active,
      this.episodes,
      this.episodesTillNow,
      this.ratingAge,
      this.duration,
      this.description,
      this.airedYear,
      this.premiered,
      this.views,
      this.categories,
      this.studios,
      this.producers,
      this.scheduleEp});

  LatestSpecialData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    japaneseName = json['japanese_name'];
    englishName = json['english_name'];
    thumbnail = json['thumbnail'];
    image = json['image'];
    imageHighQuality = json['image_high_quality'];
    aniImage = json['ani_image'];
    banner = json['banner'];
    type = json['type'];
    animeWatchType = json['anime_watch_type'];
    status = json['status'];
    active = json['active'];
    episodes = json['episodes'];
    episodesTillNow = json['episodes_till_now'];
    ratingAge = json['rating_age'];
    duration = json['duration'];
    description = json['description'];
    airedYear = json['aired_year'];
    premiered = json['premiered'];
    views = json['views'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['studios'] != null) {
      studios = <Studios>[];
      json['studios'].forEach((v) {
        studios!.add(Studios.fromJson(v));
      });
    }
    if (json['producers'] != null) {
      producers = <Producers>[];
      json['producers'].forEach((v) {
        producers!.add(Producers.fromJson(v));
      });
    }
    scheduleEp = json['schedule_ep'] != null
        ? ScheduleEp.fromJson(json['schedule_ep'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['japanese_name'] = this.japaneseName;
    data['english_name'] = this.englishName;
    data['thumbnail'] = this.thumbnail;
    data['image'] = this.image;
    data['image_high_quality'] = this.imageHighQuality;
    data['ani_image'] = this.aniImage;
    data['banner'] = this.banner;
    data['type'] = this.type;
    data['anime_watch_type'] = this.animeWatchType;
    data['status'] = this.status;
    data['active'] = this.active;
    data['episodes'] = this.episodes;
    data['episodes_till_now'] = this.episodesTillNow;
    data['rating_age'] = this.ratingAge;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['aired_year'] = this.airedYear;
    data['premiered'] = this.premiered;
    data['views'] = this.views;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.studios != null) {
      data['studios'] = this.studios!.map((v) => v.toJson()).toList();
    }
    if (this.producers != null) {
      data['producers'] = this.producers!.map((v) => v.toJson()).toList();
    }
    if (this.scheduleEp != null) {
      data['schedule_ep'] = this.scheduleEp!.toJson();
    }
    return data;
  }
}

class LatestOnasData {
  int? id;
  String? name;
  String? japaneseName;
  String? englishName;
  String? thumbnail;
  String? image;
  String? imageHighQuality;
  String? aniImage;
  String? banner;
  String? type;
  String? animeWatchType;
  String? status;
  bool? active;
  String? episodes;
  String? episodesTillNow;
  String? ratingAge;
  String? duration;
  String? description;
  String? airedYear;
  String? premiered;
  int? views;
  List<Categories>? categories;
  List<Studios>? studios;
  List<Producers>? producers;
  ScheduleEp? scheduleEp;

  LatestOnasData(
      {this.id,
      this.name,
      this.japaneseName,
      this.englishName,
      this.thumbnail,
      this.image,
      this.imageHighQuality,
      this.aniImage,
      this.banner,
      this.type,
      this.animeWatchType,
      this.status,
      this.active,
      this.episodes,
      this.episodesTillNow,
      this.ratingAge,
      this.duration,
      this.description,
      this.airedYear,
      this.premiered,
      this.views,
      this.categories,
      this.studios,
      this.producers,
      this.scheduleEp});

  LatestOnasData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    japaneseName = json['japanese_name'];
    englishName = json['english_name'];
    thumbnail = json['thumbnail'];
    image = json['image'];
    imageHighQuality = json['image_high_quality'];
    aniImage = json['ani_image'];
    banner = json['banner'];
    type = json['type'];
    animeWatchType = json['anime_watch_type'];
    status = json['status'];
    active = json['active'];
    episodes = json['episodes'];
    episodesTillNow = json['episodes_till_now'];
    ratingAge = json['rating_age'];
    duration = json['duration'];
    description = json['description'];
    airedYear = json['aired_year'];
    premiered = json['premiered'];
    views = json['views'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['studios'] != null) {
      studios = <Studios>[];
      json['studios'].forEach((v) {
        studios!.add(Studios.fromJson(v));
      });
    }
    if (json['producers'] != null) {
      producers = <Producers>[];
      json['producers'].forEach((v) {
        producers!.add(Producers.fromJson(v));
      });
    }
    scheduleEp = json['schedule_ep'] != null
        ? ScheduleEp.fromJson(json['schedule_ep'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['japanese_name'] = this.japaneseName;
    data['english_name'] = this.englishName;
    data['thumbnail'] = this.thumbnail;
    data['image'] = this.image;
    data['image_high_quality'] = this.imageHighQuality;
    data['ani_image'] = this.aniImage;
    data['banner'] = this.banner;
    data['type'] = this.type;
    data['anime_watch_type'] = this.animeWatchType;
    data['status'] = this.status;
    data['active'] = this.active;
    data['episodes'] = this.episodes;
    data['episodes_till_now'] = this.episodesTillNow;
    data['rating_age'] = this.ratingAge;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['aired_year'] = this.airedYear;
    data['premiered'] = this.premiered;
    data['views'] = this.views;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.studios != null) {
      data['studios'] = this.studios!.map((v) => v.toJson()).toList();
    }
    if (this.producers != null) {
      data['producers'] = this.producers!.map((v) => v.toJson()).toList();
    }
    if (this.scheduleEp != null) {
      data['schedule_ep'] = this.scheduleEp!.toJson();
    }
    return data;
  }
}

class LatestOvasData {
  int? id;
  String? name;
  String? japaneseName;
  String? englishName;
  String? thumbnail;
  String? image;
  String? imageHighQuality;
  String? aniImage;
  String? banner;
  String? type;
  String? animeWatchType;
  String? status;
  bool? active;
  String? episodes;
  String? episodesTillNow;
  String? ratingAge;
  String? duration;
  String? description;
  String? airedYear;
  String? premiered;
  int? views;
  List<Categories>? categories;
  List<Studios>? studios;
  List<Producers>? producers;
  ScheduleEp? scheduleEp;

  LatestOvasData(
      {this.id,
      this.name,
      this.japaneseName,
      this.englishName,
      this.thumbnail,
      this.image,
      this.imageHighQuality,
      this.aniImage,
      this.banner,
      this.type,
      this.animeWatchType,
      this.status,
      this.active,
      this.episodes,
      this.episodesTillNow,
      this.ratingAge,
      this.duration,
      this.description,
      this.airedYear,
      this.premiered,
      this.views,
      this.categories,
      this.studios,
      this.producers,
      this.scheduleEp});

  LatestOvasData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    japaneseName = json['japanese_name'];
    englishName = json['english_name'];
    thumbnail = json['thumbnail'];
    image = json['image'];
    imageHighQuality = json['image_high_quality'];
    aniImage = json['ani_image'];
    banner = json['banner'];
    type = json['type'];
    animeWatchType = json['anime_watch_type'];
    status = json['status'];
    active = json['active'];
    episodes = json['episodes'];
    episodesTillNow = json['episodes_till_now'];
    ratingAge = json['rating_age'];
    duration = json['duration'];
    description = json['description'];
    airedYear = json['aired_year'];
    premiered = json['premiered'];
    views = json['views'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['studios'] != null) {
      studios = <Studios>[];
      json['studios'].forEach((v) {
        studios!.add(Studios.fromJson(v));
      });
    }
    if (json['producers'] != null) {
      producers = <Producers>[];
      json['producers'].forEach((v) {
        producers!.add(Producers.fromJson(v));
      });
    }
    scheduleEp = json['schedule_ep'] != null
        ? ScheduleEp.fromJson(json['schedule_ep'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['japanese_name'] = this.japaneseName;
    data['english_name'] = this.englishName;
    data['thumbnail'] = this.thumbnail;
    data['image'] = this.image;
    data['image_high_quality'] = this.imageHighQuality;
    data['ani_image'] = this.aniImage;
    data['banner'] = this.banner;
    data['type'] = this.type;
    data['anime_watch_type'] = this.animeWatchType;
    data['status'] = this.status;
    data['active'] = this.active;
    data['episodes'] = this.episodes;
    data['episodes_till_now'] = this.episodesTillNow;
    data['rating_age'] = this.ratingAge;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['aired_year'] = this.airedYear;
    data['premiered'] = this.premiered;
    data['views'] = this.views;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.studios != null) {
      data['studios'] = this.studios!.map((v) => v.toJson()).toList();
    }
    if (this.producers != null) {
      data['producers'] = this.producers!.map((v) => v.toJson()).toList();
    }
    if (this.scheduleEp != null) {
      data['schedule_ep'] = this.scheduleEp!.toJson();
    }
    return data;
  }
}

class RecentlyAddedSubData {
  int? id;
  String? name;
  String? japaneseName;
  String? englishName;
  String? thumbnail;
  String? image;
  String? imageHighQuality;
  String? aniImage;
  String? banner;
  String? type;
  String? animeWatchType;
  String? status;
  bool? active;
  String? episodes;
  String? episodesTillNow;
  String? ratingAge;
  String? duration;
  String? description;
  String? airedYear;
  String? premiered;
  int? views;
  List<Categories>? categories;
  List<Studios>? studios;
  List<Producers>? producers;
  ScheduleEp? scheduleEp;

  RecentlyAddedSubData(
      {this.id,
      this.name,
      this.japaneseName,
      this.englishName,
      this.thumbnail,
      this.image,
      this.imageHighQuality,
      this.aniImage,
      this.banner,
      this.type,
      this.animeWatchType,
      this.status,
      this.active,
      this.episodes,
      this.episodesTillNow,
      this.ratingAge,
      this.duration,
      this.description,
      this.airedYear,
      this.premiered,
      this.views,
      this.categories,
      this.studios,
      this.producers,
      this.scheduleEp});

  RecentlyAddedSubData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    japaneseName = json['japanese_name'];
    englishName = json['english_name'];
    thumbnail = json['thumbnail'];
    image = json['image'];
    imageHighQuality = json['image_high_quality'];
    aniImage = json['ani_image'];
    banner = json['banner'];
    type = json['type'];
    animeWatchType = json['anime_watch_type'];
    status = json['status'];
    active = json['active'];
    episodes = json['episodes'];
    episodesTillNow = json['episodes_till_now'];
    ratingAge = json['rating_age'];
    duration = json['duration'];
    description = json['description'];
    airedYear = json['aired_year'];
    premiered = json['premiered'];
    views = json['views'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['studios'] != null) {
      studios = <Studios>[];
      json['studios'].forEach((v) {
        studios!.add(Studios.fromJson(v));
      });
    }
    if (json['producers'] != null) {
      producers = <Producers>[];
      json['producers'].forEach((v) {
        producers!.add(Producers.fromJson(v));
      });
    }
    scheduleEp = json['schedule_ep'] != null
        ? ScheduleEp.fromJson(json['schedule_ep'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['japanese_name'] = this.japaneseName;
    data['english_name'] = this.englishName;
    data['thumbnail'] = this.thumbnail;
    data['image'] = this.image;
    data['image_high_quality'] = this.imageHighQuality;
    data['ani_image'] = this.aniImage;
    data['banner'] = this.banner;
    data['type'] = this.type;
    data['anime_watch_type'] = this.animeWatchType;
    data['status'] = this.status;
    data['active'] = this.active;
    data['episodes'] = this.episodes;
    data['episodes_till_now'] = this.episodesTillNow;
    data['rating_age'] = this.ratingAge;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['aired_year'] = this.airedYear;
    data['premiered'] = this.premiered;
    data['views'] = this.views;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.studios != null) {
      data['studios'] = this.studios!.map((v) => v.toJson()).toList();
    }
    if (this.producers != null) {
      data['producers'] = this.producers!.map((v) => v.toJson()).toList();
    }
    if (this.scheduleEp != null) {
      data['schedule_ep'] = this.scheduleEp!.toJson();
    }
    return data;
  }
}

class RecentlyAddedDubData {
  int? id;
  String? name;
  String? japaneseName;
  String? englishName;
  String? thumbnail;
  String? image;
  String? imageHighQuality;
  String? aniImage;
  String? banner;
  String? type;
  String? animeWatchType;
  String? status;
  bool? active;
  String? episodes;
  String? episodesTillNow;
  String? ratingAge;
  String? duration;
  String? description;
  String? airedYear;
  String? premiered;
  int? views;
  List<Categories>? categories;
  List<Studios>? studios;
  List<Producers>? producers;
  ScheduleEp? scheduleEp;

  RecentlyAddedDubData(
      {this.id,
      this.name,
      this.japaneseName,
      this.englishName,
      this.thumbnail,
      this.image,
      this.imageHighQuality,
      this.aniImage,
      this.banner,
      this.type,
      this.animeWatchType,
      this.status,
      this.active,
      this.episodes,
      this.episodesTillNow,
      this.ratingAge,
      this.duration,
      this.description,
      this.airedYear,
      this.premiered,
      this.views,
      this.categories,
      this.studios,
      this.producers,
      this.scheduleEp});

  RecentlyAddedDubData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    japaneseName = json['japanese_name'];
    englishName = json['english_name'];
    thumbnail = json['thumbnail'];
    image = json['image'];
    imageHighQuality = json['image_high_quality'];
    aniImage = json['ani_image'];
    banner = json['banner'];
    type = json['type'];
    animeWatchType = json['anime_watch_type'];
    status = json['status'];
    active = json['active'];
    episodes = json['episodes'];
    episodesTillNow = json['episodes_till_now'];
    ratingAge = json['rating_age'];
    duration = json['duration'];
    description = json['description'];
    airedYear = json['aired_year'];
    premiered = json['premiered'];
    views = json['views'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['studios'] != null) {
      studios = <Studios>[];
      json['studios'].forEach((v) {
        studios!.add(Studios.fromJson(v));
      });
    }
    if (json['producers'] != null) {
      producers = <Producers>[];
      json['producers'].forEach((v) {
        producers!.add(Producers.fromJson(v));
      });
    }
    scheduleEp = json['schedule_ep'] != null
        ? ScheduleEp.fromJson(json['schedule_ep'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['japanese_name'] = this.japaneseName;
    data['english_name'] = this.englishName;
    data['thumbnail'] = this.thumbnail;
    data['image'] = this.image;
    data['image_high_quality'] = this.imageHighQuality;
    data['ani_image'] = this.aniImage;
    data['banner'] = this.banner;
    data['type'] = this.type;
    data['anime_watch_type'] = this.animeWatchType;
    data['status'] = this.status;
    data['active'] = this.active;
    data['episodes'] = this.episodes;
    data['episodes_till_now'] = this.episodesTillNow;
    data['rating_age'] = this.ratingAge;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['aired_year'] = this.airedYear;
    data['premiered'] = this.premiered;
    data['views'] = this.views;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.studios != null) {
      data['studios'] = this.studios!.map((v) => v.toJson()).toList();
    }
    if (this.producers != null) {
      data['producers'] = this.producers!.map((v) => v.toJson()).toList();
    }
    if (this.scheduleEp != null) {
      data['schedule_ep'] = this.scheduleEp!.toJson();
    }
    return data;
  }
}
