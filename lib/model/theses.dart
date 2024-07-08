import 'dart:convert';

Theses thesesFromJson(String str) => Theses.fromJson(json.decode(str));

String thesesToJson(Theses data) => json.encode(data.toJson());

class Theses {
    final String id;
    final String topicId;
    final String studentId;
    final String title;
    final String thesesAbstract;
    final DateTime? startAt;
    final int? status;

    Theses({
        required this.id,
        required this.topicId,
        required this.studentId,
        required this.title,
        required this.thesesAbstract,
        required this.startAt,
        this.status,
    });

    factory Theses.fromJson(Map<String, dynamic> json) => Theses(
        id: json["id"],
        topicId: json["topic_id"],
        studentId: json["student_id"],
        title: json["title"],
        thesesAbstract: json["abstract"],
        startAt: json["start_at"] != null ? DateTime.tryParse(json["start_at"]) : null,
        status: json["status"] != null ? int.tryParse(json["status"].toString()) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "topic_id": topicId,
        "student_id": studentId,
        "title": title,
        "abstract": thesesAbstract,
        "start_at": startAt?.toIso8601String(),
        "status": status,
    };
}
