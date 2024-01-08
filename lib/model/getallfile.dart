class GetAllFileModel {
  List<GroupFilesDTOResponses>? groupFilesDTOResponses;

  GetAllFileModel({this.groupFilesDTOResponses});

  GetAllFileModel.fromJson(Map<String, dynamic> json) {
    if (json['groupFilesDTOResponses'] != null) {
      groupFilesDTOResponses = <GroupFilesDTOResponses>[];
      json['groupFilesDTOResponses'].forEach((v) {
        groupFilesDTOResponses!.add(new GroupFilesDTOResponses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.groupFilesDTOResponses != null) {
      data['groupFilesDTOResponses'] =
          this.groupFilesDTOResponses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupFilesDTOResponses {
  int? fileId;
  String? fileName;
  String? path;
  bool? status;

  GroupFilesDTOResponses({this.fileId, this.fileName, this.path, this.status});

  GroupFilesDTOResponses.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'];
    fileName = json['fileName'];
    path = json['path'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileId'] = this.fileId;
    data['fileName'] = this.fileName;
    data['path'] = this.path;
    data['status'] = this.status;
    return data;
  }
}