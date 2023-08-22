class ApiAlaUne {
  List<Allitems>? allitems;

  ApiAlaUne({this.allitems});

  ApiAlaUne.fromJson(Map<String, dynamic> json) {
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
  String? relatedItems;
  String? feedUrl;
  String? time;

  Allitems(
      {this.title,
        this.desc,
        this.type,
        this.logo,
        this.videoUrl,
        this.relatedItems,
        this.feedUrl,
        this.time});

  Allitems.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    type = json['type'];
    logo = json['logo'];
    videoUrl = json['video_url'];
    relatedItems = json['relatedItems'];
    feedUrl = json['feed_url'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['type'] = this.type;
    data['logo'] = this.logo;
    data['video_url'] = this.videoUrl;
    data['relatedItems'] = this.relatedItems;
    data['feed_url'] = this.feedUrl;
    data['time'] = this.time;
    return data;
  }
}
