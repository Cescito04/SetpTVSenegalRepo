class ApiDirect {
  List<Allitems>? allitems;

  ApiDirect({this.allitems});

  ApiDirect.fromJson(Map<String, dynamic> json) {
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
  String? logo;
  String? type;
  String? feedUrl;
  String? streamUrl;

  Allitems(
      {this.title,
        this.desc,
        this.logo,
        this.type,
        this.feedUrl,
        this.streamUrl});

  Allitems.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    logo = json['logo'];
    type = json['type'];
    feedUrl = json['feed_url'];
    streamUrl = json['stream_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['logo'] = this.logo;
    data['type'] = this.type;
    data['feed_url'] = this.feedUrl;
    data['stream_url'] = this.streamUrl;
    return data;
  }
}
