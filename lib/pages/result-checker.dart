import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_admission_result_checker_app/models/university.dart';
import 'package:online_admission_result_checker_app/models/user.dart';
import 'package:online_admission_result_checker_app/pages/verify-cutoff.dart';
import 'package:online_admission_result_checker_app/widgets/formField.dart';

Firestore _firestore = Firestore.instance;
CollectionReference ref = _firestore.collection('/results');
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
                        return ListTile(
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
                              selectedUniversity = university;
                            });
                          },
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

  buildResultChecker() {
    return ListView(
      children: <Widget>[
        Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(50),
              ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(50),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyCutOff(),
                            ));
                      },
                      child: Text('View Application'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: selectedUniversity == null
            ? buildUniversityList()
            : buildResultChecker());
  }
}
