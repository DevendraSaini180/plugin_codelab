import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:plugin_codelab/plugin_codelab.dart';

void main() {
  runApp(const MyApp());
}

enum _KeyType { Black, White }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _pluginCodelabPlugin = PluginCodelab();


  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _pluginCodelabPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> showToast(String message) async {
    await _pluginCodelabPlugin.showToastMessage(message);
  }

  Widget _makeKey({required _KeyType keyType, required int key}) {
    return AnimatedContainer(
      height: 200,
      width: 44,
      duration: Duration(seconds: 2),
      curve: Curves.easeIn,
      child: Material(
        color: keyType == _KeyType.White
            ? Colors.white
            : Color.fromARGB(255, 60, 60, 80),
        child: InkWell(
          onTap: () => showToast(key.toString()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        backgroundColor: Color.fromARGB(255, 250, 30, 0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Running on: $_platformVersion\n'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _makeKey(keyType: _KeyType.White, key: 60),
                  _makeKey(keyType: _KeyType.Black, key: 61),
                  _makeKey(keyType: _KeyType.White, key: 62),
                  _makeKey(keyType: _KeyType.Black, key: 63),
                  _makeKey(keyType: _KeyType.White, key: 64),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
