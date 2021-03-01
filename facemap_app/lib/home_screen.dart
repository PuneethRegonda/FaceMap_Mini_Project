import 'dart:io';

import 'package:facemap_app/models/recognized_face.dart';
import 'package:facemap_app/provider/recognized_faces.dart';
import 'package:facemap_app/screens/aboutus.dart';
import 'package:facemap_app/screens/dashboard.dart';
import 'package:facemap_app/screens/facemap.dart';
import 'package:facemap_app/utils/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'utils/urls.dart';

// this is a test for the socket.io in dart
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Socket socket;
  Widget _selectedScreeen;
  List<RecognizedFace> _recognizedFaces;
  List<RecognizedFace> _allRecognizedFaces;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recognizedFaces =
        Provider.of<RecognizedFacesProvider>(context).recognizedFaces;
    _allRecognizedFaces =
        Provider.of<RecognizedFacesProvider>(context).allrecognizedFaces;
  }

  @override
  void initState() {
    socket = io(Urls.host + 'facemap', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {
        'Authorization': 'TOKEN ' + Session.authToken,
      } // optional
    });

    socket.connect();

    socket.on('connect', (_) {
      print('connected');
    });

    socket.on("old_faces", (data) {
      print("old_faces");

      if (data != null) {
        print("adding oldFaces");
        Provider.of<RecognizedFacesProvider>(context, listen: false)
            .allrecognizedFaces = RecognizedFace.fromOldFacesJsonList(data);
      }
    });

    socket.on('new_faces', (data) {
      print("new_faces");
      print(data.toString());
      // Provider.of<RecognizedFacesProvider>(context, listen: false).addNewFaces =
      //     RecognizedFace.fromKnownFaces(data);
      Provider.of<RecognizedFacesProvider>(context, listen: false).addRealTimeFacesToLocations =
          RecognizedFace.fromKnownFaces(data);
    });

    socket.on('disconnect', (_) => print('disconnected'));
    _selectedScreeen = DashBoard();
    super.initState();
  }

  int _currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: _selectedScreeen,
          bottomNavigationBar: !kIsWeb
              ? BottomNavigationBar(
                  onTap: (int index) {
                    _currentIndex = index;
                    switch (index) {
                      case 0:
                        _selectedScreeen = DashBoard();
                        break;
                      case 1:
                        _selectedScreeen = FaceMapScreen();
                        break;
                      case 2:
                        _selectedScreeen = AboutUs();
                        break;
                    }

                    setState(() {});
                  },
                  currentIndex: _currentIndex,
                  type: BottomNavigationBarType.fixed,
                  elevation: 5.0,
                  items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), title: Text("Dashboard")),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.map), title: Text("Facemap")),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.developer_board),
                          title: Text("Developer Board")),
                    ])
              : null),
    );
  }

  @override
  void dispose() {
    socket.close();
    super.dispose();
  }
}
