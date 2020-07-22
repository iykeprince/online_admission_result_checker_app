import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../models/application.dart';
import '../widgets/mainHeader.dart';
import 'package:screenshot/screenshot.dart';

class ApplicationDetail extends StatefulWidget {
  static const String routeName = '/application-detail';
  ApplicationDetail({Key key}) : super(key: key);

  @override
  _ApplicationDetailState createState() => _ApplicationDetailState();
}

class _ApplicationDetailState extends State<ApplicationDetail> {
  Application application;
  File _imageFile;
  ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    _requestWritePermission();
  }

    _requestWritePermission() async {
    // PermissionStatu permissionStatus = await SimplePermissions.requestPermission(Permission.WriteExternalStorage);

    // if (permissionStatus == PermissionStatus.authorized) {
    //   setState(() {
    //     _allowWriteFile = true;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    application = ModalRoute.of(context).settings.arguments;

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
                         
                          child: Image.network(application.university.image, fit: BoxFit.cover,),
                        ),
                      ],
                    ),
                    Text(
                      'Name: ${application.university.name}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Accronym: ${application.university.accronym}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Founded: ${application.university.founded}',
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
                      '${application.result.score}',
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
                    Text('O\'Level Results (${application.courses.length})'),
                    Container(
                      child: Column(
                        children: [
                          application.courses.length > 0
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent.withOpacity(.3),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8.0,
                                            left: 16.0,
                                          ),
                                          child: Text(
                                            'WASSCE',
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
                                          ],
                                          rows: application.courses.map((row) {
                                            return DataRow(cells: <DataCell>[
                                              DataCell(Text(row.subject)),
                                              DataCell(Text(row.score)),
                                              DataCell(Text(row.grade)),
                                            ]);
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _imageFile = await _screenshotController.capture(
              delay: Duration(milliseconds: 10),
              pixelRatio: 1.5,
            );
            String fileName = DateTime.now().toString();
            _saveImage(fileName, _imageFile);
          },
          child: Icon(Icons.add_a_photo)),
    );
  }

  _saveImage(String name, File image) async {
    final result = await ImageGallerySaver.saveImage(
      image.readAsBytesSync(),
      name: name,
    );
    print('File is saved $result');
  }
}
