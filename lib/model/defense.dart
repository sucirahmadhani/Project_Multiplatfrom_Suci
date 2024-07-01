import 'dart:convert';

List<Defense> defenseFromJson(String str) => List<Defense>.from(json.decode(str).map((x) => Defense.fromJson(x)));

String defenseToJson(List<Defense> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Defense {
  final String id;
  final String thesisId;
  final String thesisRubricId;
  final String fileReport;
  final String fileSlide;
  final String fileJournal;
  final int status;
  final DateTime registeredAt;
  final int method;
  final DateTime trialAt;
  final String startAt;
  final String endAt;
  final String roomId;
  final String onlineUrl;
  final int score;
  final String grade;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Defense({
    required this.id,
    required this.thesisId,
    required this.thesisRubricId,
    required this.fileReport,
    required this.fileSlide,
    required this.fileJournal,
    required this.status,
    required this.registeredAt,
    required this.method,
    required this.trialAt,
    required this.startAt,
    required this.endAt,
    required this.roomId,
    required this.onlineUrl,
    required this.score,
    required this.grade,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Defense.fromJson(Map<String, dynamic> json) => Defense(
        id: json["id"],
        thesisId: json["thesis_id"],
        thesisRubricId: json["thesis_rubric_id"],
        fileReport: json["file_report"],
        fileSlide: json["file_slide"],
        fileJournal: json["file_journal"],
        status: json["status"],
        registeredAt: DateTime.parse(json["registered_at"]),
        method: json["method"],
        trialAt: DateTime.parse(json["trial_at"]),
        startAt: json["start_at"],
        endAt: json["end_at"],
        roomId: json["room_id"],
        onlineUrl: json["online_url"],
        score: json["score"],
        grade: json["grade"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thesis_id": thesisId,
        "thesis_rubric_id": thesisRubricId,
        "file_report": fileReport,
        "file_slide": fileSlide,
        "file_journal": fileJournal,
        "status": status,
        "registered_at": registeredAt.toIso8601String(),
        "method": method,
        "trial_at": trialAt.toIso8601String(),
        "start_at": startAt,
        "end_at": endAt,
        "room_id": roomId,
        "online_url": onlineUrl,
        "score": score,
        "grade": grade,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
