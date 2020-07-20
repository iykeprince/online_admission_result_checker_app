import 'package:flutter/material.dart';
import 'package:online_admission_result_checker_app/models/application.dart';
import 'package:online_admission_result_checker_app/models/course.dart';
import 'package:online_admission_result_checker_app/models/result.dart';
import 'package:online_admission_result_checker_app/models/university.dart';
import 'package:online_admission_result_checker_app/models/user.dart';
import 'application-detail.dart';

class AdmissionPortal extends StatefulWidget {
  static const String routeName = '/admissionPortal';

  AdmissionPortal({Key key}) : super(key: key);

  @override
  _AdmissionPortalState createState() => _AdmissionPortalState();
}

class _AdmissionPortalState extends State<AdmissionPortal> {
  List<Application> applicationList = List();

  List<Course> courseList = List();
  Result result = Result();
  User user = User();
  University university = University();

  @override
  void initState() {
    super.initState();

    courseList.add(Course(subject: 'Mathematics', score: '90', grade: 'A'));
    courseList.add(Course(subject: 'English', score: '67', grade: 'B'));
    courseList.add(Course(subject: 'Biology', score: '90', grade: 'A'));
    courseList.add(Course(subject: 'Chemistry', score: '67', grade: 'B'));
    courseList.add(Course(subject: 'Physics', score: '50', grade: 'C'));
    courseList.add(Course(subject: 'Agricultural Science', score: '67', grade: 'B'));
    courseList.add(Course(subject: 'Geography', score: '80', grade: 'A'));
    courseList.add(Course(subject: 'Economics', score: '66', grade: 'B'));
    
    result.score = 220;
    user.username = 'Uchechi Akwarandu';
    user.email = 'uche24@hotmail.co.uk';
    user.gender = 'Male';
    user.userId = '234232lljldajdsljfasdfadf';
    user.phone = '098765431';
    university.name = 'Abia State University';
    university.accronym = 'ABSU';
    university.founded = '1981';
    university.image =
        'https://firebasestorage.googleapis.com/v0/b/burkman-984c6.appspot.com/o/absu.png?alt=media&token=76ffdb9e-3471-4df9-926d-ea5d0b7136d9';
    result.university = university;

    applicationList.add(new Application(
      courses: courseList,
      result: result,
      university: university,
      user: user,
    ));
  }

  _applicationItem(context, index, list) {
    final Application item = list[index];
    print('application list size: ${list.length}');
    return ListTile(
      contentPadding: EdgeInsets.all(4),
      title: Text(
        item.university.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
          color: Colors.black,
        ),
      ),
      subtitle: Text('Score: ${item.result.score}'),
      trailing: FlatButton.icon(
        icon: Icon(
          Icons.arrow_right,
        ),
        label: Text('Detail'),
        onPressed: () {
          Navigator.pushNamed(
            context,
            ApplicationDetail.routeName,
            arguments: item,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('application length ${applicationList.length}');
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'View Applications',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          Divider(),
          applicationList.length == 0
              ? Center(
                  child: Text(
                    'No application submitted yet!',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              : Container(
                  height: 300,
                  child: ListView.builder(
                    itemCount: applicationList.length,
                    itemBuilder: (context, index) => _applicationItem(
                      context,
                      index,
                      applicationList,
                    ),
                    scrollDirection: Axis.vertical,
                  ),
                )
        ],
      ),
    );
  }
}
