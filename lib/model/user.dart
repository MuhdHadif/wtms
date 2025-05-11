class User {
  String? id;
  String? fullName;
  String? email;
  String? password;
  String? phoneNum;
  String? address;

  User(
      {this.id,
      this.fullName,
      this.email,
      this.password,
      this.phoneNum,
      this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    phoneNum = json['phoneNum'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNum'] = this.phoneNum;
    data['userAddress'] = this.address;
    return data;
  }
}