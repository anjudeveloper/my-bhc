class UpdateDobResponse {
  String? status;
  String? response;
  int? code;
  int? data;

  UpdateDobResponse({required this.status, required this.response, required this.code, required this.data});

  UpdateDobResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    code = json['code'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    data['code'] = this.code;
    data['data'] = this.data;
    return data;
  }
}
