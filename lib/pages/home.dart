import 'package:flutter/material.dart';//importing material package 
//import user model
import '../models/user.dart';
//importing screens
import '../pages/admission-portal.dart';
import '../pages/result-checker.dart';
import '../widgets/mainHeader.dart';//importing widget for mainHeader

class Home extends StatefulWidget {
  static const String routeName = '/home';
  Home({Key key, this.user}) : super(key: key);

  User user;//user object 

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;//initializing the page index
  PageController _pageController;//instantiating the pagecontroller for pageview

  List<String> _pageList = ['Admission Portal', 'Result Checker'];//list of pages in pageview
  String _pageTitle;//initialize each page title for appbar

  @override
  void initState() {
    _pageController = PageController(initialPage: pageIndex);//initialize the page view
    super.initState();
  }
  // method for opening admission portal
  void _admissionPortal() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdmissionPortal(),
      ),
    );
  }
  // method for opening result checking
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
    _pageTitle = _pageList[pageIndex];//set the necessary page title
    return Scaffold(
      appBar: mainHeader(context, isTitle: true, title: _pageTitle),//set the custom main header
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
