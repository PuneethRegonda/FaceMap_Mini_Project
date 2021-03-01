import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RealTimePersonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(100, (index) {
            return SizedBox(
              width: kIsWeb ? MediaQuery.of(context).size.height * .5 : 250.0,
              height: kIsWeb ? MediaQuery.of(context).size.height * .5 : 250.0,
              child: Card(
                child: Center(
                  child: Text(
                    'Item $index',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
