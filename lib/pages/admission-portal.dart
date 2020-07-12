import 'package:flutter/material.dart';

class AdmissionPortal extends StatefulWidget {
  static const String routeName = '/admissionPortal';

  AdmissionPortal({Key key}) : super(key: key);

  @override
  _AdmissionPortalState createState() => _AdmissionPortalState();
}

class _AdmissionPortalState extends State<AdmissionPortal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Admission Portal'),
    );
  }
}
