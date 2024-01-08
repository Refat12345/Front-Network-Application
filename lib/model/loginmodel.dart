class LoginModel {
  User? user;
  String? token;

  LoginModel({this.user, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? userGroups;
  List<String>? groups;
  List<String>? files;
  List<String>? myFiles;
  String? role;

  User(
      {this.userId,
        this.userName,
        this.userGroups,
        this.groups,
        this.files,
        this.myFiles,
        this.role

      });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userGroups = json['user_groups'].cast<String>();
    groups = json['groups'].cast<String>();
    files = json['files'].cast<String>();
    myFiles = json['my_files'].cast<String>();
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_groups'] = this.userGroups;
    data['groups'] = this.groups;
    data['files'] = this.files;
    data['my_files'] = this.myFiles;
    data['role'] = this.role;

    return data;
  }
}