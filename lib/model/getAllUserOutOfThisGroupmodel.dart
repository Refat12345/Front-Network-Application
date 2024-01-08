class GetAllUserOutOfThisGroupModel {
  List<UserSearchDTOS>? userSearchDTOS;

  GetAllUserOutOfThisGroupModel({this.userSearchDTOS});

  GetAllUserOutOfThisGroupModel.fromJson(Map<String, dynamic> json) {
    if (json['userSearchDTOS'] != null) {
      userSearchDTOS = <UserSearchDTOS>[];
      json['userSearchDTOS'].forEach((v) {
        userSearchDTOS!.add(new UserSearchDTOS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userSearchDTOS != null) {
      data['userSearchDTOS'] =
          this.userSearchDTOS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserSearchDTOS {
  int? userId;
  String? userName;

  UserSearchDTOS({this.userId, this.userName});

  UserSearchDTOS.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    return data;
  }
}