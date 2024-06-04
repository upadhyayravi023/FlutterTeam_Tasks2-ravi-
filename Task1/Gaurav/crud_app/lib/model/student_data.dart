
class StudentData{

  String name;
  int studentId;
  String studentProgram;
  double cgpa;

  StudentData({
    required this.name,
    required this.studentId,
    required this.studentProgram,
    required this.cgpa
});

  StudentData.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          studentId: json['studentId']! as int,
          studentProgram: json['studentProgram']! as String,
          cgpa: json['cgpa']! as double
        );


  StudentData copywith({
    String? name,
    int? studentId,
    String? studentProgram,
    double? cgpa
  }){
    return StudentData(
        name: name ?? this.name,
        studentId: studentId ?? this.studentId,
        studentProgram: studentProgram ?? this.studentProgram,
        cgpa: cgpa ?? this.cgpa);
  }

  Map<String, Object?> toJson(){
    return {
      'name' : name,
      'studentId' : studentId,
      'studentProgram' : studentProgram,
      'cgpa' : cgpa
    };
  }


}


