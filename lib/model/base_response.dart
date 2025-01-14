class ResponseBase<T> {
  int? totals;
  T? data;
  String? message;
  
  ResponseBase({this.totals, this.data});

  ResponseBase.fromJson(Map<String, dynamic> json,
      [T Function(dynamic json)? dataFromJson]) {
    if (dataFromJson == null) {
      data = json['data'];
    } else {
      var _tmp = json['data'];
      data = _tmp == null ? null : dataFromJson(_tmp);
    }
    totals = json.containsKey('total')
        ? json['total']
        : json.containsKey('totals')
            ? json['totals']
            : -100;
  }
}
