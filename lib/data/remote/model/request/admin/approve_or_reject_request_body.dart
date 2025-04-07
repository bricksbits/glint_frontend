import 'dart:convert';
ApproveOrRejectRequestBody approveOrRejectRequestBodyFromJson(String str) => ApproveOrRejectRequestBody.fromJson(json.decode(str));
String approveOrRejectRequestBodyToJson(ApproveOrRejectRequestBody data) => json.encode(data.toJson());
class ApproveOrRejectRequestBody {
  ApproveOrRejectRequestBody({
      this.approvals,});

  ApproveOrRejectRequestBody.fromJson(dynamic json) {
    if (json['approvals'] != null) {
      approvals = [];
      json['approvals'].forEach((v) {
        approvals?.add(Approvals.fromJson(v));
      });
    }
  }
  List<Approvals>? approvals;
ApproveOrRejectRequestBody copyWith({  List<Approvals>? approvals,
}) => ApproveOrRejectRequestBody(  approvals: approvals ?? this.approvals,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (approvals != null) {
      map['approvals'] = approvals?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Approvals approvalsFromJson(String str) => Approvals.fromJson(json.decode(str));
String approvalsToJson(Approvals data) => json.encode(data.toJson());
class Approvals {
  Approvals({
      this.eventId, 
      this.isApproved,});

  Approvals.fromJson(dynamic json) {
    eventId = json['event_id'];
    isApproved = json['is_approved'];
  }
  int? eventId;
  bool? isApproved;
Approvals copyWith({  int? eventId,
  bool? isApproved,
}) => Approvals(  eventId: eventId ?? this.eventId,
  isApproved: isApproved ?? this.isApproved,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_id'] = eventId;
    map['is_approved'] = isApproved;
    return map;
  }

}