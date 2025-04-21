import 'dart:io';

import 'package:flutter/material.dart';


class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Platform.isIOS
                  ? const Icon(Icons.arrow_back_ios)
                  : const Icon(Icons.arrow_back),
              onPressed: () {}
              ),
        ),
        body: const Center(
          child: Text('Page not found'),
        ));
  }
}
