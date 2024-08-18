import 'package:dio/dio.dart';

class StudentData {
  final int id;
  final String finrstName;
  final String lastName;
  final String course;
  final int score;
  final String createdAt;
  final String updatedAt;

  StudentData(
      {required this.id,
      required this.finrstName,
      required this.lastName,
      required this.course,
      required this.score,
      required this.createdAt,
      required this.updatedAt});

  StudentData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        finrstName = json['first_name'],
        lastName = json['last_name'],
        course = json['course'],
        score = json['score'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];
}

class HttpClient {
  static Dio dio =
      Dio(BaseOptions(baseUrl: 'http://expertdevelopers.ir/api/v1/'));
}

Future<List<StudentData>> getStudents() async {
  final response = await HttpClient.dio.get('experts/student');
  final List<StudentData> students = [];
  if (response.data is List<dynamic>) {
    (response.data as List<dynamic>).forEach((element) {
      students.add(StudentData.fromJson(element));
    });
  }
  return students;
}

Future<StudentData> saveStudent(
    String firstName, String lastName, String course, String score) async {
  final response = await HttpClient.dio.post('experts/student', data: {
    "first_name": firstName,
    "last_name": lastName,
    "course": course,
    "score": score
  });
  if (response.statusCode == 200) {
    return StudentData.fromJson(response.data);
  }else{
    throw Exception();
  }
}
