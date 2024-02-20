class CityPartyModel {
  List<String>? cities;
  List<String>? parties;

  CityPartyModel({this.cities, this.parties});

  CityPartyModel.fromJson(Map<String, dynamic> json) {
    cities = json['cities'].cast<String>();
    parties = json['parties'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cities'] = this.cities;
    data['parties'] = this.parties;
    return data;
  }
}
