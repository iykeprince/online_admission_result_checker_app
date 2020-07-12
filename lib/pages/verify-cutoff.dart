import 'package:flutter/material.dart';

class VerifyCutOff extends StatefulWidget {
  static const String routeName = '/verifyCutOff';

  VerifyCutOff({Key key}) : super(key: key);

  @override
  _VerifyCutOffState createState() => _VerifyCutOffState();
}

class _VerifyCutOffState extends State<VerifyCutOff> {
  List<String> _instituteList = List<String>();

  @override
  void initState() {
    _instituteList.add('University of Nigeria, Nsukka');
    _instituteList.add('University of Lagos, Lagos');
    _instituteList.add('University of Benin, Benin');
    _instituteList.add('Nnamdi Azikiwe University, Awka');
    _instituteList.add('Federal University of Technology, Akure');
    _instituteList.add('Tai Solarin College of Education, Ijebu');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('2019/2020 Jamb Result'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'You Scored ',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          '260',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Matriculation Number - ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'XXXXXXXX',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'FullName - ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'John Smith',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 16.0),
              child: Column(
                children: <Widget>[
                  Text('Choose institution', style: TextStyle(fontSize: 18),),
                  // Container(
                  //   child: Expanded(
                  //     child: DropdownButtonFormField(
                  //       items: _instituteList
                  //           .map((item) => DropdownMenuItem(child: Text(item))).toList(),
                  //       onChanged: (value) {},
                  //     ),
                  //   ),
                  // ),
                  RaisedButton(onPressed: (){}, child: Text('Validate'),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
