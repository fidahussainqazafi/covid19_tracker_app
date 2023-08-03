class CountryInfo {
  CountryInfo({
    required this.id,
    required this.iso2,
    required this.iso3,
    required this.latitude,
    required this.longitude,
    required this.flag,
  });

  CountryInfo.fromJson(dynamic json) {
    id = json['_id'];
    iso2 = json['iso2'];
    iso3 = json['iso3'];
    latitude = json['lat'];
    longitude = json['long'];
    flag = json['flag'];
  }

  late int id;
  late String iso2;
  late String iso3;
  late double latitude;
  late double longitude;
  late String flag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['iso2'] = iso2;
    map['iso3'] = iso3;
    map['lat'] = latitude;
    map['long'] = longitude;
    map['flag'] = flag;
    return map;
  }
}
