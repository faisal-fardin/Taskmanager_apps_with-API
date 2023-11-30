/// status : "success"
/// data : [{"_id":"Pocha","sum":1},{"_id":"Cancelled","sum":7},{"_id":"Completed","sum":1},{"_id":"completed","sum":2},{"_id":"Complete","sum":5},{"_id":null,"sum":1},{"_id":"New","sum":4}]

class SummaryCountModel {
  SummaryCountModel({
      String? status, 
      List<SummaryData>? data,}){
    _status = status;
    _data = data;
}

  SummaryCountModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SummaryData.fromJson(v));
      });
    }
  }
  String? _status;
  List<SummaryData>? _data;
SummaryCountModel copyWith({  String? status,
  List<SummaryData>? data,
}) => SummaryCountModel(  status: status ?? _status,
  data: data ?? _data,
);
  String? get status => _status;
  List<SummaryData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "Pocha"
/// sum : 1

class SummaryData {
  SummaryData({
      String? id, 
      num? sum,}){
    _id = id;
    _sum = sum;
}

  SummaryData.fromJson(dynamic json) {
    _id = json['_id'];
    _sum = json['sum'];
  }
  String? _id;
  num? _sum;
SummaryData copyWith({  String? id,
  num? sum,
}) => SummaryData(  id: id ?? _id,
  sum: sum ?? _sum,
);
  String? get id => _id;
  num? get sum => _sum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['sum'] = _sum;
    return map;
  }

}