class SearchPodo {
  int? st;
  String? msg;
  Data? data;

  SearchPodo({this.st, this.msg, this.data});

  SearchPodo.fromJson(Map<String, dynamic> json) {
    st = json['st'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['st'] = this.st;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? displayContentName;
  List<AnimeList>? animeList;
  int? nextPage;
  int? currentPage;
  int? previousPage;
  String? val;
  int? maxPageCounter;

  Data(
      {this.displayContentName,
      this.animeList,
      this.nextPage,
      this.currentPage,
      this.previousPage,
      this.val,
      this.maxPageCounter});

  Data.fromJson(Map<String, dynamic> json) {
    displayContentName = json['display_content_name'];
    if (json['anime_list'] != null) {
      animeList = <AnimeList>[];
      json['anime_list'].forEach((v) {
        animeList!.add(AnimeList.fromJson(v));
      });
    }
    nextPage = json['next_page'];
    currentPage = json['current_page'];
    previousPage = json['previous_page'];
    val = json['val'];
    maxPageCounter = json['max_page_counter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['display_content_name'] = this.displayContentName;
    if (this.animeList != null) {
      data['anime_list'] = this.animeList!.map((v) => v.toJson()).toList();
    }
    data['next_page'] = this.nextPage;
    data['current_page'] = this.currentPage;
    data['previous_page'] = this.previousPage;
    data['val'] = this.val;
    data['max_page_counter'] = this.maxPageCounter;
    return data;
  }
}

class AnimeList {
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

  AnimeList(
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
      this.description,
        this.descriptionClear,
      this.airedYear,
      this.premiered,
      this.views,
      this.categories,
      this.studios,
      this.producers,
      this.scheduleEp});

  AnimeList.fromJson(Map<String, dynamic> json) {
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

class Producers {
  Producers();

  Producers.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
