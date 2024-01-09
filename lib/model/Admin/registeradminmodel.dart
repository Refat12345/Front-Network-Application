class RegisterAdminModel {
  User? user;
  String? token;

  RegisterAdminModel({this.user, this.token});

  RegisterAdminModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? userId;
  String? userName;

  String? role;

  User(
      {this.userId,
        this.userName,
        this.role});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['role'] = this.role;
    return data;
  }
}