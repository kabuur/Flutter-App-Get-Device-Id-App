import 'dart:io';

import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';

void main() {
  runApp(const MaterialApp(
    home: deviceID(),
  ));
}

class deviceID extends StatefulWidget {
  const deviceID({super.key});

  @override
  State<deviceID> createState() => _deviceIDState();
}

class _deviceIDState extends State<deviceID> {
  String deviceId = "";

  void getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }

    print('Device ID: $deviceId');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  getDeviceId();
                },
                child: Text("get device info")),
            Text(
              "device id is = " + deviceId,
              style: TextStyle(
                fontSize: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}
