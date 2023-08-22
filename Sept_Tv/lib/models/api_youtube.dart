class ApiYoutube {
  String? kind;
  String? etag;
  String? nextPageToken;
  String? regionCode;
  PageInfo? pageInfo;
  List<Items>? items;

  ApiYoutube({this.kind, this.etag, this.nextPageToken, this.regionCode, this.pageInfo, this.items});

  ApiYoutube.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    nextPageToken = json['nextPageToken'];
    regionCode = json['regionCode'];
    pageInfo = json['pageInfo'] != null ? new PageInfo.fromJson(json['pageInfo']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) { items!.add(new Items.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    data['nextPageToken'] = this.nextPageToken;
    data['regionCode'] = this.regionCode;
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PageInfo {
  int? totalResults;
  int? resultsPerPage;

  PageInfo({this.totalResults, this.resultsPerPage});

  PageInfo.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    resultsPerPage = json['resultsPerPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalResults'] = this.totalResults;
    data['resultsPerPage'] = this.resultsPerPage;
    return data;
  }
}

class Items {
  String? kind;
  String? etag;
  Id? id;
  Snippet? snippet;

  Items({this.kind, this.etag, this.id, this.snippet});

  Items.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    snippet = json['snippet'] != null ? new Snippet.fromJson(json['snippet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    if (this.id != null) {
      data['id'] = this.id!.toJson();
    }
    if (this.snippet != null) {
      data['snippet'] = this.snippet!.toJson();
    }
    return data;
  }
}

class Id {
  String? kind;
  String? videoId;

  Id({this.kind, this.videoId});

  Id.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    videoId = json['videoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['videoId'] = this.videoId;
    return data;
  }
}

class Snippet {
  String? publishedAt;
  String? channelId;
  String? title;
  String? description;
  Thumbnails? thumbnails;
  String? channelTitle;
  String? liveBroadcastContent;
  String? publishTime;

  Snippet({this.publishedAt, this.channelId, this.title, this.description, this.thumbnails, this.channelTitle, this.liveBroadcastContent, this.publishTime});

  Snippet.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    title = json['title'];
    description = json['description'];
    thumbnails = json['thumbnails'] != null ? new Thumbnails.fromJson(json['thumbnails']) : null;
    channelTitle = json['channelTitle'];
    liveBroadcastContent = json['liveBroadcastContent'];
    publishTime = json['publishTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publishedAt'] = this.publishedAt;
    data['channelId'] = this.channelId;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.thumbnails != null) {
      data['thumbnails'] = this.thumbnails!.toJson();
    }
    data['channelTitle'] = this.channelTitle;
    data['liveBroadcastContent'] = this.liveBroadcastContent;
    data['publishTime'] = this.publishTime;
    return data;
  }
}

class Thumbnails {
  ThumbnailSize? defaultSize;
  ThumbnailSize? mediumSize;
  ThumbnailSize? highSize;

  Thumbnails({this.defaultSize, this.mediumSize, this.highSize});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    defaultSize = json['default'] != null ? ThumbnailSize.fromJson(json['default']) : null;
    mediumSize = json['medium'] != null ? ThumbnailSize.fromJson(json['medium']) : null;
    highSize = json['high'] != null ? ThumbnailSize.fromJson(json['high']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.defaultSize != null) {
      data['default'] = this.defaultSize!.toJson();
    }
    if (this.mediumSize != null) {
      data['medium'] = this.mediumSize!.toJson();
    }
    if (this.highSize != null) {
      data['high'] = this.highSize!.toJson();
    }
    return data;
  }
}

class ThumbnailSize {
  String? url;
  int? width;
  int? height;

  ThumbnailSize({this.url, this.width, this.height});

  ThumbnailSize.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}
