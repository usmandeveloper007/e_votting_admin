class UserModel {
  String? userId;
  String? fingerId;
  String? fullName;
  String? age;
  String? email;
  String? address;
  String? city;
  int? cNIC;
  String? userType;
  String? partType;
  String? electionType;
  String? createdAt;
  bool? isApproved;
  String? imageUrl;

  UserModel(
      {this.userId,
        this.fullName,
        this.fingerId,
        this.age,
        this.email,
        this.address,
        this.city,
        this.cNIC,
        this.userType,
        this.partType,
        this.electionType,
        this.createdAt,
        this.isApproved,
        this.imageUrl});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fullName = json['fullName'];
    fingerId = json['fingerId'];
    age = json['age'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    cNIC = json['cNIC'];
    userType = json['userType'];
    partType = json['partType'];
    electionType = json['electionType'];
    createdAt = json['createdAt'];
    isApproved = json['isApproved'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['fingerId'] = this.fingerId;
    data['fullName'] = this.fullName;
    data['age'] = this.age;
    data['email'] = this.email;
    data['address'] = this.address;
    data['city'] = this.city;
    data['cNIC'] = this.cNIC;
    data['userType'] = this.userType;
    data['partType'] = this.partType;
    data['electionType'] = this.electionType;
    data['createdAt'] = this.createdAt;
    data['isApproved'] = this.isApproved;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
