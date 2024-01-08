class GetMyGroupModel {
  List<UserGroupsDTOResponses>? userGroupsDTOResponses;

  GetMyGroupModel({this.userGroupsDTOResponses});

  GetMyGroupModel.fromJson(Map<String, dynamic> json) {
    if (json['userGroupsDTOResponses'] != null) {
      userGroupsDTOResponses = <UserGroupsDTOResponses>[];
      json['userGroupsDTOResponses'].forEach((v) {
        userGroupsDTOResponses!.add(new UserGroupsDTOResponses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userGroupsDTOResponses != null) {
      data['userGroupsDTOResponses'] =
          this.userGroupsDTOResponses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserGroupsDTOResponses {
  int? groupID;
  String? groupName;

  UserGroupsDTOResponses({this.groupID, this.groupName});

  UserGroupsDTOResponses.fromJson(Map<String, dynamic> json) {
    groupID = json['groupID'];
    groupName = json['groupName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupID'] = this.groupID;
    data['groupName'] = this.groupName;
    return data;
  }
}