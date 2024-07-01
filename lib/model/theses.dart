import 'dart:convert';

Theses thesesFromJson(String str) => Theses.fromJson(json.decode(str));

String thesesToJson(Theses data) => json.encode(data.toJson());

class Theses {
    final String id;
    final String topicId;
    final String studentId;
    final String title;
    final String thesesAbstract;
    final DateTime startAt;
    final int status;
    final String grade;
    final int gradeBy;
    final String createdBy;
    final DateTime createdAt;
    final DateTime updatedAt;

    Theses({
        required this.id,
        required this.topicId,
        required this.studentId,
        required this.title,
        required this.thesesAbstract,
        required this.startAt,
        required this.status,
        required this.grade,
        required this.gradeBy,
        required this.createdBy,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Theses.fromJson(Map<String, dynamic> json) => Theses(
        id: json["id"],
        topicId: json["topic_id"],
        studentId: json["student_id"],
        title: json["title"],
        thesesAbstract: json["abstract"],
        startAt: DateTime.parse(json["start_at"]),
        status: json["status"],
        grade: json["grade"],
        gradeBy: json["grade_by"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "topic_id": topicId,
        "student_id": studentId,
        "title": title,
        "abstract": thesesAbstract,
        "start_at": startAt.toIso8601String(),
        "status": status,
        "grade": grade,
        "grade_by": gradeBy,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
