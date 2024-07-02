import 'dart:convert';

List<Defense> defenseFromJson(String str) => List<Defense>.from(json.decode(str).map((x) => Defense.fromJson(x)));

String defenseToJson(List<Defense> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Defense {
  final String id;
  final String thesisId;
  final String thesisRubricId;
  

  Defense({
    required this.id,
    required this.thesisId,
    required this.thesisRubricId,
    
  });

  factory Defense.fromJson(Map<String, dynamic> json) => Defense(
        id: json["id"],
        thesisId: json["thesis_id"],
        thesisRubricId: json["thesis_rubric_id"],
        
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thesis_id": thesisId,
        "thesis_rubric_id": thesisRubricId,
      };
}
