import 'package:sidang/model/defense.dart';
import 'package:sidang/model/seminar.dart';
import 'package:sidang/model/supervisor.dart';

class Thesis {
  final String id;
  final String? topicId; 
  final String studentId;
  final String title;
  final String? thesisAbstract; 
  final DateTime? startAt;
  final int status;
  final List<Supervisor> supervisors;
  final List<Seminar> seminars;
  final List<Defense> defenses;

  Thesis({
    required this.id,
    this.topicId,
    required this.studentId,
    required this.title,
    this.thesisAbstract,
    this.startAt,
    required this.status,
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
    startAt: json["start_at"] != null ? DateTime.parse(json["start_at"]) : null,
    status: json["status"],
    supervisors: List<Supervisor>.from(
      json["supervisors"].map((x) => Supervisor.fromJson(x))),
    seminars: List<Seminar>.from(
      json["seminars"].map((x) => Seminar.fromJson(x))),
    defenses: List<Defense>.from(
      json["defenses"].map((x) => Defense.fromJson(x))),
  );
}
