import 'dart:convert';
//importing material package
import 'package:Burkman/helpers/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import application, course, result, user and university model
import '../models/application.dart';
import '../models/course.dart';
import '../models/result.dart';
import '../models/university.dart';
import '../models/user.dart';
//import the application-detail screen
import 'application-detail.dart';

BaseAuth _auth = Auth(); //initialize the auth base class
Firestore _firestore = Firestore.instance; //initialze firestore

CollectionReference applicationRef =
    _firestore.collection('/applications'); //initialize application collection

class AdmissionPortal extends StatefulWidget {
  static const String routeName =
      '/admissionPortal'; //constant admission portal screen route

  AdmissionPortal({Key key}) : super(key: key);

  @override
  _AdmissionPortalState createState() => _AdmissionPortalState();
}

class _AdmissionPortalState extends State<AdmissionPortal> {

  List<Course> courseList = List(); //initialize course list
  Result result = Result(); //initialize result object
  User user = User(); //initialize user object
  University university = University(); //initialize university object

  Future<QuerySnapshot> getApplications() async {
    FirebaseUser user = await _auth.getCurrentUser();
    return await applicationRef
        .where('user.user_id', isEqualTo: user.uid)
        .getDocuments();
  }

  @override
  void initState() {
    super.initState();
  }

  //method for presenting and displaying each item on the listview
  _applicationItem(context, index, docs) {
    final DocumentSnapshot documentSnapshot = docs[index];
    Map<String, dynamic> doc = documentSnapshot.data;

    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(4),
          leading: Container(
            padding: const EdgeInsets.all(4),
            child: Image.network('${doc['university']['image']}'),),
          title: Text(
            '${doc['university']['name']}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: Colors.black,
            ),
          ),
          subtitle: Text('Score: ${doc['result']['score']}'),
          trailing: FlatButton.icon(
            icon: Icon(
              Icons.arrow_right,
            ),
            label: Text('Detail'),
            onPressed: () {
              Navigator.pushNamed(
                context,
                ApplicationDetail.routeName,
                arguments: doc,
              );
            },
          ),
        ),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: FutureBuilder<QuerySnapshot>(
        future: getApplications(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            // print('data: ${snapshot.data.documents[0].data}');
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                snapshot.data.documents.length == 0
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
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) => _applicationItem(
                            context,
                            index,
                            snapshot.data.documents,
                          ),
                          scrollDirection: Axis.vertical,
                        ),
                      ),
              ],
            );
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
