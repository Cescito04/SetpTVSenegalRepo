class ApiCategory {
  List<Allitems>? allitems;

  ApiCategory({this.allitems});

  ApiCategory.fromJson(Map<String, dynamic> json) {
    if (json['allitems'] != null) {
      allitems = <Allitems>[];
      json['allitems'].forEach((v) {
        allitems!.add(new Allitems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allitems != null) {
      data['allitems'] = this.allitems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Allitems {
  String? title;
  String? logo;
  String? desc;
  String? feedUrl;
  String? relatedItems;
  String? time;
  String? date;
  String? type;
  String? videoUrl;

  Allitems(
      {this.title,
        this.logo,
        this.desc,
        this.feedUrl,
        this.relatedItems,
        this.time,
        this.date,
        this.type,
        this.videoUrl});

  Allitems.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    logo = json['logo'];
    desc = json['desc'];
    feedUrl = json['feed_url'];
    relatedItems = json['relatedItems'];
    time = json['time'];
    date = json['date'];
    type = json['type'];
    videoUrl = json['video_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['logo'] = this.logo;
    data['desc'] = this.desc;
    data['feed_url'] = this.feedUrl;
    data['relatedItems'] = this.relatedItems;
    data['time'] = this.time;
    data['date'] = this.date;
    data['type'] = this.type;
    data['video_url'] = this.videoUrl;
    return data;
  }
}
