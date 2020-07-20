import 'package:flutter/material.dart';
import 'package:online_admission_result_checker_app/models/user.dart';
import 'package:online_admission_result_checker_app/pages/admission-portal.dart';
import 'package:online_admission_result_checker_app/pages/result-checker.dart';
import '../widgets/mainHeader.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';
  Home({Key key, this.user}) : super(key: key);

  User user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  PageController _pageController;

  List<String> _pageList = ['Admission Portal', 'Result Checker'];
  String _pageTitle;

  @override
  void initState() {
    _pageController = PageController(initialPage: pageIndex);
    super.initState();
  }

  void _admissionPortal() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdmissionPortal(),
      ),
    );
  }

  void _resultChecker() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultChecker(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // _pageController.jumpToPage(pageIndex);
    _pageTitle = _pageList[pageIndex];
    return Scaffold(
      appBar: mainHeader(context, isTitle: true, title: _pageTitle),
      body: Container(
        child: PageView(
          controller: _pageController,
          children: <Widget>[
            AdmissionPortal(),
            ResultChecker(
              user: widget.user,
            ),
          ],
          onPageChanged: (value) {
            setState(() {
              pageIndex = value;
             
            });
          },
          pageSnapping: true,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
          _pageController.animateToPage(
            pageIndex,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: [
          BottomNavigationBarItem(
              title: Text('Admission Portal'), icon: Icon(Icons.comment)),
          BottomNavigationBarItem(
              title: Text('Result Checker'), icon: Icon(Icons.check_circle)),
        ],
      ),
    );
  }
}
