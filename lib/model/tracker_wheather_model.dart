class TrackerWheather {
  int id;
  String city;
  double temperature;
  List<Tracks> tracks = [];
  String genre;

  TrackerWheather(
      {this.id, this.city, this.temperature, this.tracks, this.genre});

  TrackerWheather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    temperature = json['temperature'];
    if (json['tracks'] != null) {
      tracks = new List<Tracks>();
      json['tracks'].forEach((v) {
        tracks.add(new Tracks.fromJson(v));
      });
    }
    genre = json['genre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.city;
    data['temperature'] = this.temperature;
    if (this.tracks != null) {
      data['tracks'] = this.tracks.map((v) => v.toJson()).toList();
    }
    data['genre'] = this.genre;
    return data;
  }
}

class Tracks {
  String id;
  int key;
  List<Artists> artists = [];
  String name;

  Tracks({this.id, this.key, this.artists, this.name});

  Tracks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    if (json['artists'] != null) {
      artists = new List<Artists>();
      json['artists'].forEach((v) {
        artists.add(new Artists.fromJson(v));
      });
    }
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    return data;
  }

  String listArtist() {
    return '${artists.map((e) => e.name).toString()}';
  }
}

class Artists {
  String name;

  Artists({this.name});

  Artists.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
