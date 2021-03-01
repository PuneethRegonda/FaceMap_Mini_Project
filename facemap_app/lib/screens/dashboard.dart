import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './realtime_person_list.dart';
import '../components/search_bar.dart';
import '../provider/recognized_faces.dart';
import '../utils/session.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool isWebsite = false;
  @override
  void didChangeDependencies() {
    isWebsite = MediaQuery.of(context).size.width >= 1080 ? true : false;
    super.didChangeDependencies();
  }

  Widget buildSearchBar() {
    return Hero(
      tag: "search_bar",
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Card(
            elevation: 0.0,
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchByRollNo()));
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .80,
                height: 60.0,
                child: Card(
                  elevation: 3.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              "Search Roll No",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                        color: Colors.blue[200],
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildSearchBar(),
          Text(
            "Search by Places",
            style: kIsWeb
                ? TextStyle(fontWeight: FontWeight.w800, fontSize: 30.0)
                : Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: kIsWeb
                ? MediaQuery.of(context).size.height * .75
                : MediaQuery.of(context).size.height * .6,
            width: kIsWeb
                ? MediaQuery.of(context).size.width * .85
                : MediaQuery.of(context).size.width * .75,
            child: GridView.count(
              padding: isWebsite ? EdgeInsets.all(20.0) : EdgeInsets.all(30.0),
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              crossAxisCount: isWebsite ? 6 : 2,
              children: buildCards(context),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildCards(BuildContext context) {
    return Session.cameraLocations.keys
        .map((String location) => SizedBox(
              width:
                  isWebsite ? MediaQuery.of(context).size.height * .05 : 250.0,
              height:
                  isWebsite ? MediaQuery.of(context).size.height * .05 : 250.0,
              child: InkWell(
                onTap: () {
                  if (Provider.of<RecognizedFacesProvider>(context,
                              listen: false)
                          .locations[location] !=
                      null)
                    print(Provider.of<RecognizedFacesProvider>(context,
                            listen: false)
                        .locations[location]
                        .realTimeFaces.toString());

                    Navigator.of(context).push(CupertinoPageRoute(builder: (_)=>RealTimePersonsList()));
                },
                child: Card(
                  child: Center(
                    child: Text(
                      location,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
              ),
            ))
        .toList();

  
  }
}
