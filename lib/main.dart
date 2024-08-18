import 'package:flutter/material.dart';
import 'package:student/data.dart';

void main() {
  getStudents();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme:
            InputDecorationTheme(border: OutlineInputBorder()),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Color(0xff16E5A7)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Android Expert'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => _AddStudentForm()));
          },
          label: Row(
            children: [Icon(Icons.add), Text('Add Student')],
          )),
      body: FutureBuilder<List<StudentData>>(
        future: getStudents(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _Student(
                    data: snapshot.data![index],
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _AddStudentForm extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _scoreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            try {
               saveStudent(
                _firstNameController.text,
                _lastNameController.text,
                _courseController.text,
                _scoreController.text);
            } catch (e) {
              debugPrint(e.toString());
            }
          },
          label: Row(
            children: [Icon(Icons.check), Text('Save')],
          )),
      appBar: AppBar(
        title: Text('Add New Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(label: Text('First Name')),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(label: Text('Lasr Name')),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _courseController,
              decoration: InputDecoration(label: Text('Course')),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _scoreController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(label: Text('Score')),
            ),
          ],
        ),
      ),
    );
  }
}

class _Student extends StatelessWidget {
  final StudentData data;

  const _Student({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05)),
          ]),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
            child: Text(
              data.finrstName.characters.first,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 24),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.finrstName + ' ' + data.lastName),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.grey.shade200),
                  child: Text(
                    data.course,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bar_chart,
                color: Colors.grey.shade400,
              ),
              Text(
                data.score.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
