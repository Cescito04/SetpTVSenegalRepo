class ApiSubCategory {
  List<Allitems>? allitems;

  ApiSubCategory({this.allitems});

  ApiSubCategory.fromJson(Map<String, dynamic> json) {
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
  String? desc;
  String? type;
  String? logo;
  String? videoUrl;
  String? feedUrl;
  String? relatedItems;
  String? time;

  Allitems(
      {this.title,
        this.desc,
        this.type,
        this.logo,
        this.videoUrl,
        this.feedUrl,
        this.relatedItems,
        this.time});

  Allitems.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    type = json['type'];
    logo = json['logo'];
    videoUrl = json['video_url'];
    feedUrl = json['feed_url'];
    relatedItems = json['relatedItems'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['type'] = this.type;
    data['logo'] = this.logo;
    data['video_url'] = this.videoUrl;
    data['feed_url'] = this.feedUrl;
    data['relatedItems'] = this.relatedItems;
    data['time'] = this.time;
    return data;
  }
}
