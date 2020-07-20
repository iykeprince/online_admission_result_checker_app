import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_admission_result_checker_app/models/result.dart';
import 'package:online_admission_result_checker_app/models/university.dart';
import 'package:online_admission_result_checker_app/models/user.dart';
import 'package:online_admission_result_checker_app/pages/verify-cutoff.dart';
import 'package:online_admission_result_checker_app/widgets/formField.dart';

Firestore _firestore = Firestore.instance;
CollectionReference ref = _firestore.collection('/results');
CollectionReference userRef = _firestore.collection('/users');
Future<QuerySnapshot> universitySnapshot =
    _firestore.collection('/universities').getDocuments();

class ResultChecker extends StatefulWidget {
  static const String routeName = '/resultChecker';

  ResultChecker({Key key, this.user}) : super(key: key);
  User user;

  @override
  _ResultCheckerState createState() => _ResultCheckerState();
}

class _ResultCheckerState extends State<ResultChecker> {
  final TextEditingController _regNumFieldController = TextEditingController();
  University selectedUniversity;

  bool isUniversitySelected = false;

  bool loading = false;
  Result result;

  Widget buildUniversityList() {
    return Container(
      child: FutureBuilder(
        future: universitySnapshot,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            QuerySnapshot querySnapshot = snapshot.data;
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Select University',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: querySnapshot.documents.length,
                      itemBuilder: (context, index) {
                        Map doc = querySnapshot.documents.elementAt(index).data;
                        String id =
                            querySnapshot.documents.elementAt(index).documentID;
                        University university =
                            University.fromDocument(doc, id);
                        print('university image: ${university.image}');
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.1),
                              ),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(university.image),
                                backgroundColor: Colors.transparent,
                              ),
                              contentPadding: EdgeInsets.all(4),
                              title: Text(
                                university.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(university.accronym),
                              trailing: Text(
                                university.founded,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  isUniversitySelected = true;
                                  selectedUniversity = university;
                                });
                              },
                            ),
                          ),
                        );
                      }),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  buildResultChecker(University selectedUniversity) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                selectedUniversity.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                selectedUniversity.accronym,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(50),
              ),
              Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      selectedUniversity.image,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 40, bottom: 4),
                      alignment: Alignment.centerLeft,
                      child: Text('Enter your matriculation number'),
                    ),
                    formField(
                      controller: _regNumFieldController,
                      text: 'JAMB Registration No.',
                      validationText:
                          'Please enter a valid JAMB registration no.',
                      icon: Icon(Icons.person_outline),
                      value: widget.user.regNumber,
                    ),
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        QuerySnapshot studentSnapshot = await userRef
                            .where('reg_number',
                                isEqualTo: widget.user.regNumber)
                            .limit(1)
                            .getDocuments();

                        if (studentSnapshot.documents.length == 0) {
                          print('student: no record found');
                          openResultScreen(null);
                          return;
                        }

                        User student = User.fromDocument(
                            studentSnapshot.documents[0].data,
                            studentSnapshot.documents[0].documentID);
                        result = Result();
                        result.user = student;
                        result.university = selectedUniversity;
                        result.score = 220;
                        openResultScreen(result);
                        print('student ${student.username}');
                        setState(() {});
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => VerifyCutOff(),
                        //     ));
                      },
                      child: Text('Check Result'),
                    ),
                    loading ? CircularProgressIndicator() : Text(''),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  openResultScreen(Result _result) async {
    await Navigator.pushNamed(context, VerifyCutOff.routeName,
        arguments: _result);
    print('result: ${result.score}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: !isUniversitySelected
            ? buildUniversityList()
            : buildResultChecker(
                selectedUniversity,
              ));
  }
}
