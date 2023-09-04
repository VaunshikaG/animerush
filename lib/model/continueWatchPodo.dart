class ContinueWatchPodo {
  int? st;
  String? msg;
  String? functionName;
  List<ContinueData>? data;

  ContinueWatchPodo({this.st, this.msg, this.functionName, this.data});

  ContinueWatchPodo.fromJson(Map<String, dynamic> json) {
    st = json['st'];
    msg = json['msg'];
    functionName = json['function_name'];
    if (json['data'] != null) {
      data = <ContinueData>[];
      json['data'].forEach((v) {
        data!.add(ContinueData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['st'] = this.st;
    data['msg'] = this.msg;
    data['function_name'] = this.functionName;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContinueData {
  int? id;
  int? user;
  ContinueAnime? anime;
  String? episode;
  bool? removed;
  String? created;

  ContinueData(
      {this.id,
      this.user,
      this.anime,
      this.episode,
      this.removed,
      this.created});

  ContinueData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    anime =
        json['anime'] != null ? ContinueAnime.fromJson(json['anime']) : null;
    episode = json['episode'];
    removed = json['removed'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    if (this.anime != null) {
      data['anime'] = this.anime!.toJson();
    }
    data['episode'] = this.episode;
    data['removed'] = this.removed;
    data['created'] = this.created;
    return data;
  }
}

class ContinueAnime {
  int? id;
  String? name;
  String? japaneseName;
  String? synonyms;
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
  String? descriptionClear;
  String? airedYear;
  String? premiered;
  int? views;
  List<Categories>? categories;
  List<Studios>? studios;
  List<Producers>? producers;
  ScheduleEp? scheduleEp;

  ContinueAnime(
      {this.id,
      this.name,
      this.japaneseName,
        this.synonyms,
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
        this.descriptionClear,
      this.description,
      this.airedYear,
      this.premiered,
      this.views,
      this.categories,
      this.studios,
      this.producers,
      this.scheduleEp});

  ContinueAnime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    japaneseName = json['japanese_name'];
    synonyms = json['synonyms'];
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
    descriptionClear = json['description_clear'];
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
