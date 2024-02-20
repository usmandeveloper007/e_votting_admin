class ElectionModel {
  String? type;
  String? startTime;
  String? endTime;
  String? modDate;

  ElectionModel({this.type, this.startTime, this.endTime, this.modDate});

  ElectionModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    modDate = json['modDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['modDate'] = this.modDate;
    return data;
  }
}
