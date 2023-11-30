/// status : "success"
/// data : [{"_id":"6551d44065f5af4161114e93","title":"Warning!!!!","description":"Complete Task Manager Project first,Then add logical task.Ok??","status":"New","createdDate":"29-10-2023"},{"_id":"655eefe26d668882817185c4","title":"My Task","description":"My Task","status":"New","createdDate":"16-11-2023"},{"_id":"6565bc124c7eac36557b6b8b","title":"a","description":"a2","status":"New","createdDate":"26-11-2023"},{"_id":"6566749c4c7eac36557b762f","title":"d","description":"sdf","status":"New","createdDate":"26-11-2023"},{"_id":"6566760b4c7eac36557b7631","title":"213324","description":"21321564","status":"New","createdDate":"26-11-2023"},{"_id":"656676694c7eac36557b7633","title":"21348596498","description":"51654956489468","status":"New","createdDate":"26-11-2023"},{"_id":"656683274c7eac36557b7638","title":"sgerr","description":"sgerserg","status":"New","createdDate":"26-11-2023"},{"_id":"656691d54c7eac36557b7649","title":"Shamim","description":"Details not given","status":"New","createdDate":"26-11-2023"},{"_id":"6566eb574c7eac36557b7c05","title":"jssj","description":"jdjjs","status":"New","createdDate":"26-11-2023"},{"_id":"6566ed264c7eac36557b7c29","title":"ok","description":"ok","status":"New","createdDate":"26-11-2023"},{"_id":"65673af14c7eac36557b8005","title":"My Task","description":"My Task","status":"New","createdDate":"26-11-2023"},{"_id":"65673b114c7eac36557b8009","title":"My Task","description":"My Task","status":"New","createdDate":"26-11-2023"}]

class NewTaskStatusModel {
  NewTaskStatusModel({
      String? status, 
      List<TaskData>? data,}){
    _status = status;
    _data = data;
}

  NewTaskStatusModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TaskData.fromJson(v));
      });
    }
  }
  String? _status;
  List<TaskData>? _data;
NewTaskStatusModel copyWith({  String? status,
  List<TaskData>? data,
}) => NewTaskStatusModel(  status: status ?? _status,
  data: data ?? _data,
);
  String? get status => _status;
  List<TaskData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6551d44065f5af4161114e93"
/// title : "Warning!!!!"
/// description : "Complete Task Manager Project first,Then add logical task.Ok??"
/// status : "New"
/// createdDate : "29-10-2023"

class TaskData {
  TaskData({
      String? id, 
      String? title, 
      String? description, 
      String? status, 
      String? createdDate,}){
    _id = id;
    _title = title;
    _description = description;
    _status = status;
    _createdDate = createdDate;
}

  TaskData.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _description = json['description'];
    _status = json['status'];
    _createdDate = json['createdDate'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _status;
  String? _createdDate;
TaskData copyWith({  String? id,
  String? title,
  String? description,
  String? status,
  String? createdDate,
}) => TaskData(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  status: status ?? _status,
  createdDate: createdDate ?? _createdDate,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get status => _status;
  String? get createdDate => _createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['status'] = _status;
    map['createdDate'] = _createdDate;
    return map;
  }

}