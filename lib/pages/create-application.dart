//importing material package
import 'package:Burkman/models/user.dart';
import 'package:Burkman/widgets/scoreField.dart';
import 'package:flutter/material.dart';
//import firebase auth and firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//the firebase auth helper
import '../helpers/authentication.dart';
//importing course, entry, result model
import '../models/course.dart';
import '../models/entry.dart';
import '../models/result.dart';
//import admission-portal screen
import '../pages/admission-portal.dart';
//import custom widgets for form field, grade field, main header and subject field.
import '../widgets/formField.dart';
import '../widgets/gradeField.dart';
import '../widgets/mainHeader.dart';
import '../widgets/subjectField.dart';

BaseAuth _auth = Auth(); //initialize the auth base class
Firestore _firestore = Firestore.instance; //initialze firestore
CollectionReference userRef =
    _firestore.collection('/users'); //initialize users collection

class CreateApplication extends StatefulWidget {
  static const String routeName = '/createApplication';
  CreateApplication({Key key}) : super(key: key);

  @override
  _CreateApplicationState createState() => _CreateApplicationState();
}

class _CreateApplicationState extends State<CreateApplication> {
  TextEditingController _regNumberFieldController =
      TextEditingController(); //initialize the reg number controller
  TextEditingController _emailFieldController =
      TextEditingController(); //initialize email controller
  TextEditingController _phoneFieldController =
      TextEditingController(); //initialize phone controller
  List<TextEditingController> _scoreFieldControllers =
      <TextEditingController>[]; //initialise score field array

  List<Entry> entryList = List(); //initialize entry list
  List<Course> rowList = List(); // initialize row list

  String title = '';
  String _selectedEntry = '';

  int _entryIndex = 0;
  int applicationIndex = 0;
  List<String> appTitle = [
    'Personal Information',
    'O\'Level Results',
    'Preview',
    'Submitted',
  ];

  @override
  void initState() {
    super.initState();
    // rowList.add(Course(subject: 'Mathematics', score: '90', grade: 'A'));
    // rowList.add(Course(subject: 'English', score: '67', grade: 'B'));
    entryList.add(Entry(entryIndex: 0, name: 'WASSCE', courses: []));
    entryList.add(Entry(entryIndex: 1, name: 'NECO', courses: []));
    entryList.add(Entry(entryIndex: 2, name: 'GCE', courses: []));
    _selectedEntry = entryList[0].name;
  }

  _buildCreateApplication(Result result) {
    //method to create application based on application index position
    switch (applicationIndex) {
      case 0:
        return _buildPersonalInfo();
      case 1:
        return _buildOlevel();
      case 2:
        return _buildPreviewInfo(result);
      case 3:
        return _buildSubmitted();
      default:
        return Text('building Screens');
    }
  }

  getCurrentUser() async {
    var user = await _auth.getCurrentUser();
    return user;
  }

  //method to show screen if submitted
  _buildSubmitted() {
    return Center(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            Text(
              'Your application has been submitted!',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            FlatButton(
              child: Text('View Application'),
              color: Theme.of(context).accentColor,
              onPressed: () {
                //TODO: push to home..
              },
            ),
          ],
        ),
      ),
    );
  }

  //method to preview application before submiting
  _buildPreviewInfo(Result result) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'University',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  Container(
                                    child: Text(
                                      '${result.university.name}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Accronym',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  Container(
                                    child: Text(
                                      '${result.university.accronym}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Founded',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  Container(
                                    child: Text(
                                      '${result.university.founded}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //university logo here
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  result.university.image,
                                ),
                              ),
                            ),
                          )
                        ]),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Text(
                          '${result.user.username}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Registration No.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Text(
                          '${result.user.regNumber}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Text(
                          '${result.user.email}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'O\'level Results',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: entryList.map((entry) {
                    return entry.courses.length > 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.redAccent.withOpacity(.3),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                      left: 16.0,
                                    ),
                                    child: Text(
                                      entry.name,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataTable(
                                    columns: <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          'Subject',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Score',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Grade',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            setState(() {
                                              // List<Entry> newEntries = entryList
                                              //     .where((element) =>
                                              //         element.name == _selectedEntry)
                                              //     .toList();
                                              Course course = new Course();
                                              course.subject = 'Physics';
                                              course.grade = 'B';
                                              course.score = '66';
                                              entryList[_entryIndex]
                                                  .courses
                                                  .add(course);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                    rows: entry.courses.map((row) {
                                      return DataRow(cells: <DataCell>[
                                        DataCell(Text(row.subject)),
                                        DataCell(Text(row.score)),
                                        DataCell(Text(row.grade)),
                                        DataCell(
                                          FlatButton.icon(
                                            label: Text(''),
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              print(
                                                  'cell index ${row.subject}');
                                            },
                                          ),
                                        ),
                                      ]);
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container();
                  }).toList(),
                ),
              ),
              Divider(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Prev'),
                  onPressed: () {
                    setState(() {
                      applicationIndex = 1;
                    });
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Submit'),
                  onPressed: () {
                    //submit to firebase
                    setState(() {
                      applicationIndex = 3;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //method to show UI for inputing and handling O'level
  _buildOlevel() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Select Examination Type',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          child: DropdownButton(
                            hint: Text('Select examination type'),
                            items: entryList
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: item.name,
                                    child: Text(
                                      item.name,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              print('entry: $value');
                              setState(() {
                                _selectedEntry = value;
                                _entryIndex = entryList.indexWhere(
                                    (element) => element.name == value);
                              });
                            },
                            value: _selectedEntry,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () {
                          print('selected Entry $_selectedEntry');
                          setState(() {
                            print('entry index: $_entryIndex');
                            List<Entry> newEntries = entryList
                                .where(
                                    (element) => element.name == _selectedEntry)
                                .toList();
                            if (newEntries.length == 0) {
                              entryList.add(
                                Entry(
                                  entryIndex: _entryIndex,
                                  name: _selectedEntry,
                                  courses: [
                                    Course(
                                      subject: '',
                                      score: '',
                                      grade: '',
                                    ),
                                  ],
                                ),
                              );
                            }
                          });
                        },
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Add',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
              ),
              Container(
                child: Column(
                  children: entryList.length > 0
                      ? entryList.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.redAccent.withOpacity(.3),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                      left: 16.0,
                                    ),
                                    child: Text(
                                      entry.name,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label: Text(
                                            'Subject',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Score',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Grade',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              setState(() {
                                                Course course = new Course();
                                                course.subject = '';
                                                course.grade = '';
                                                course.score = '';
                                                entryList[entry.entryIndex]
                                                    .courses
                                                    .add(course);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                      rows: entry.courses.length > 0
                                          ? entry.courses.map((row) {
                                              int index =
                                                  entry.courses.indexOf(row);
                                              
                                              print('courses entry $index');
                                              return DataRow(cells: <DataCell>[
                                                DataCell(
                                                    SubjectField(course: row)),
                                                DataCell(
                                                  ScoreField(
                                                    
                                                    course: row,
                                                  ),
                                                ),
                                                DataCell(
                                                    GradeField(course: row)),
                                                DataCell(
                                                  FlatButton.icon(
                                                    label: Text(''),
                                                    icon: Icon(Icons.remove),
                                                    onPressed: () {
                                                      entry.courses
                                                          .removeAt(index);
                                                    },
                                                  ),
                                                ),
                                              ]);
                                            }).toList()
                                          : [],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList()
                      : Container(),
                ),
              ),
              Divider(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Prev'),
                  onPressed: () {
                    setState(() {
                      applicationIndex = 0;
                    });
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Next'),
                  onPressed: () {
                    if (entryList.length > 0) {
                      
                      setState(() {
                        applicationIndex = 2;
                      });
                    } else {
                      print('entrylist is empty');
                    }
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<DocumentSnapshot> getUserBio() async {
    FirebaseUser user =
        await _auth.getCurrentUser(); //gets the current logged user
    return _firestore.document('/users/${user.uid}').get();
  }

  //method for personal bio data
  _buildPersonalInfo() {
    //get the user profile data from firestore
    return FutureBuilder<DocumentSnapshot>(
      future: getUserBio(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          var doc = snapshot.data;
          User userDoc = User.fromDocument(doc.data, doc.documentID);
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(.5),
                      ),
                      child: Text(
                        'We hope you are keeping safe due to coronavirus pandemic our management might be slow. just bear with use, we will reply as soon as we can. thank you!',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Apply for Admission',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          formField(
                              value: userDoc.regNumber,
                              controller: _regNumberFieldController,
                              icon: Icon(Icons.confirmation_number),
                              text: 'Registration Number',
                              validationText:
                                  'Please enter a valid registration number!'),
                          formField(
                              value: userDoc.email,
                              controller: _emailFieldController,
                              icon: Icon(Icons.confirmation_number),
                              text: 'Email Address',
                              validationText:
                                  'Please enter a valid registration number!'),
                          formField(
                              value: userDoc.phone,
                              controller: _phoneFieldController,
                              icon: Icon(Icons.confirmation_number),
                              text: 'Phone Number',
                              validationText:
                                  'Please enter a valid registration number!'),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(''),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        color: Theme.of(context).accentColor,
                        child: Text('Next'),
                        onPressed: () {
                          setState(() {
                            applicationIndex = 1;
                          });
                        },
                      ),
                    ),
                  ],
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
    );
  }

  @override
  Widget build(BuildContext context) {
    Result result = ModalRoute.of(context).settings.arguments;
    print('creating application: ${result.score}');
    setState(() {
      title = appTitle[applicationIndex];
    });
    return Scaffold(
      appBar: mainHeader(context, isTitle: true, title: title),
      body: _buildCreateApplication(result),
    );
  }
}
