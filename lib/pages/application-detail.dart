//import dart io package for file handling
import 'dart:io';

//import the material package
import 'package:Burkman/models/entry.dart';
import 'package:flutter/material.dart';
//import image gallery saver lib
import 'package:image_gallery_saver/image_gallery_saver.dart';
//import screenshot lib
import 'package:screenshot/screenshot.dart';
import 'package:simple_permissions/simple_permissions.dart';
//import application model package
import '../models/application.dart';
//import main header package
import '../widgets/mainHeader.dart';

class ApplicationDetail extends StatefulWidget {
  static const String routeName =
      '/application-detail'; //constant for screen navigator route name
  ApplicationDetail({Key key}) : super(key: key);

  @override
  _ApplicationDetailState createState() => _ApplicationDetailState();
}

class _ApplicationDetailState extends State<ApplicationDetail> {
  File _imageFile; //initantiate the image file
  bool _allowWriteFile = false;
  ScreenshotController _screenshotController =
      ScreenshotController(); //initialize screenshot

  @override
  void initState() {
    super.initState();
    _requestWritePermission();
  }

  _requestWritePermission() async {
    PermissionStatus permissionStatus =
        await SimplePermissions.requestPermission(
            Permission.WriteExternalStorage);

    if (permissionStatus == PermissionStatus.authorized) {
      setState(() {
        _allowWriteFile = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> snapshot = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: mainHeader(
        context,
        isTitle: true,
        title: 'View Application',
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'University',
                          style: TextStyle(
                            fontSize: 28.0,
                          ),
                        ),
                        Container(
                          width: 50,
                          child: Image.network(
                            snapshot['university']['image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Name: ${snapshot['university']['name']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Accronym: ${snapshot['university']['accronym']}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Founded: ${snapshot['university']['founded']}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Score',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      '${snapshot['result']['score']}',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('O\'Level Results (${snapshot['entries'].length})'),
                    snapshot['entries'].length > 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: snapshot['entries']
                                .map<Widget>((entry) => Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        entry['courses'].length > 0
                                            ? Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey
                                                        .withOpacity(.3),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 8.0,
                                                          left: 16.0,
                                                        ),
                                                        child: Text(
                                                          entry['name'],
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                        ],
                                                        rows: entry['courses']
                                                            .map<DataRow>((course) =>
                                                                DataRow(cells: <
                                                                    DataCell>[
                                                                  DataCell(Text(
                                                                      course[
                                                                          'subject'])),
                                                                  DataCell(Text(
                                                                      course[
                                                                          'score'])),
                                                                  DataCell(Text(
                                                                      course[
                                                                          'grade'])),
                                                                ]))
                                                            .toList(),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ))
                                .toList(),
                          )
                        : Container(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _imageFile = null;
            _imageFile = await _screenshotController.capture(
              path: '',
              delay: Duration(milliseconds: 10),
              pixelRatio: 1.5,
            );
            String fileName = DateTime.now().toString();
            _saveImage(fileName, _imageFile);
          },
          child: Icon(Icons.add_a_photo)),
    );
  }

  //method for saving image
  _saveImage(String name, File image) async {
    try {
      final result = await ImageGallerySaver.saveImage(
        image.readAsBytesSync(),
        name: name,
      );
      print('File is saved $result');
    } catch (error) {
      print('file error: $error');
    }
  }
}
