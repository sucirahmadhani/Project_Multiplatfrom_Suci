import 'dart:convert';
import 'package:sidang/model/supervisor.dart';
import 'package:sidang/model/seminar.dart';
import 'defense.dart';

List<Thesis> thesisFromJson(String str) => List<Thesis>.from(json.decode(str).map((x) => Thesis.fromJson(x)));

String thesisToJson(List<Thesis> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Thesis {
  final String id;
  final String topicId;
  final String studentId;
  final String title;
  final String thesisAbstract;
  final DateTime startAt;
  final int status;
  final String grade;
  final int gradeBy;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Supervisor> supervisors; 
  final List<Seminar> seminars;
  final List<Defense> defenses;

  Thesis({
    required this.id,
    required this.topicId,
    required this.studentId,
    required this.title,
    required this.thesisAbstract,
    required this.startAt,
    required this.status,
    required this.grade,
    required this.gradeBy,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.supervisors, 
    required this.seminars,
    required this.defenses,
  });

  factory Thesis.fromJson(Map<String, dynamic> json) => Thesis(
        id: json["id"],
        topicId: json["topic_id"],
        studentId: json["student_id"],
        title: json["title"],
        thesisAbstract: json["abstract"],
        startAt: DateTime.parse(json["start_at"]),
        status: json["status"],
        grade: json["grade"],
        gradeBy: json["grade_by"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        supervisors: List<Supervisor>.from(
            json["supervisors"].map((x) => Supervisor.fromJson(x))), seminars: List<Seminar>.from(
            json["seminars"].map((x) => Seminar.fromJson(x))),defenses: List<Defense>.from(
            json["defenses"].map((x) => Defense.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "topic_id": topicId,
        "student_id": studentId,
        "title": title,
        "abstract": thesisAbstract,
        "start_at": startAt.toIso8601String(),
        "status": status,
        "grade": grade,
        "grade_by": gradeBy,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "supervisors": List<dynamic>.from(supervisors.map((x) => x.toJson())), 
        "seminars": List<dynamic>.from(seminars.map((x) => x.toJson())),
        "defenses": List<dynamic>.from(defenses.map((x) => x.toJson())),
      };
}
