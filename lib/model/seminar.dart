import 'dart:convert';

List<Seminar> seminarFromJson(String str) => List<Seminar>.from(json.decode(str).map((x) => Seminar.fromJson(x)));

String seminarToJson(List<Seminar> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Seminar {
  final String id;
  final String thesisId;
  final DateTime registeredAt;
  final int method;
  final DateTime seminarAt;
  final String roomId;
  final String onlineUrl;
  final String fileReport;
  final String fileSlide;
  final String fileJournal;
  final String fileAttendance;
  final int recommendation;
  final int status;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Reviewer> reviewers;
  final List<dynamic> audiences;

  Seminar({
    required this.id,
    required this.thesisId,
    required this.registeredAt,
    required this.method,
    required this.seminarAt,
    required this.roomId,
    required this.onlineUrl,
    required this.fileReport,
    required this.fileSlide,
    required this.fileJournal,
    required this.fileAttendance,
    required this.recommendation,
    required this.status,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.reviewers,
    required this.audiences,
  });

  factory Seminar.fromJson(Map<String, dynamic> json) {
    return Seminar(
      id: json["id"] ?? '',
      thesisId: json["thesis_id"] ?? '',
      registeredAt: _parseDateTime(json["registered_at"]),
      method: json["method"] ?? 0,
      seminarAt: _parseDateTime(json["seminar_at"]),
      roomId: json["room_id"] ?? '',
      onlineUrl: json["online_url"] ?? '',
      fileReport: json["file_report"] ?? '',
      fileSlide: json["file_slide"] ?? '',
      fileJournal: json["file_journal"] ?? '',
      fileAttendance: json["file_attendance"] ?? '',
      recommendation: json["recommendation"] ?? 0,
      status: json["status"] ?? 0,
      description: json["description"] ?? '',
      createdAt: _parseDateTime(json["created_at"]),
      updatedAt: _parseDateTime(json["updated_at"]),
      reviewers: json["reviewers"] != null
          ? List<Reviewer>.from(json["reviewers"].map((x) => Reviewer.fromJson(x)))
          : [],
      audiences: json["audiences"] != null ? List<dynamic>.from(json["audiences"].map((x) => x)) : [],
    );
  }

  static DateTime _parseDateTime(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return DateTime.now(); 
    }
    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      print('Error parsing date: $e');
      return DateTime.now(); 
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "thesis_id": thesisId,
    "registered_at": registeredAt.toIso8601String(),
    "method": method,
    "seminar_at": seminarAt.toIso8601String(),
    "room_id": roomId,
    "online_url": onlineUrl,
    "file_report": fileReport,
    "file_slide": fileSlide,
    "file_journal": fileJournal,
    "file_attendance": fileAttendance,
    "recommendation": recommendation,
    "status": status,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "reviewers": List<dynamic>.from(reviewers.map((x) => x.toJson())),
    "audiences": List<dynamic>.from(audiences.map((x) => x)),
  };
}


class Reviewer {
    final String id;
    final String thesisSeminarId;
    final String reviewerId;
    final int status;
    final dynamic position;
    final dynamic recommendation;
    final dynamic notes;
    final DateTime createdAt;
    final DateTime updatedAt;

    Reviewer({
        required this.id,
        required this.thesisSeminarId,
        required this.reviewerId,
        required this.status,
        required this.position,
        required this.recommendation,
        required this.notes,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Reviewer.fromJson(Map<String, dynamic> json) => Reviewer(
        id: json["id"],
        thesisSeminarId: json["thesis_seminar_id"],
        reviewerId: json["reviewer_id"],
        status: json["status"],
        position: json["position"],
        recommendation: json["recommendation"],
        notes: json["notes"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "thesis_seminar_id": thesisSeminarId,
        "reviewer_id": reviewerId,
        "status": status,
        "position": position,
        "recommendation": recommendation,
        "notes": notes,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
