import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import '../models/app_strings.dart';
import '../widgets/internet_error_widget.dart';
import 'package:web_socket_channel/io.dart';

import '../widgets/parking_area_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? serialLed;
  bool? ledStatus1;
  bool? ledStatus2;
  bool? ledStatus3;
  bool? ledStatus4;
  IOWebSocketChannel? channel;
  bool? connected;
  final info = NetworkInfo();
  @override
  void initState() {
    ledStatus2 = ledStatus1 = ledStatus3 = ledStatus4 = true;
    serialLed = false;
    connected = false;
    Future.delayed(Duration.zero, () async {
      channelConnect(); //connect to WebSocket
    });
    super.initState();
  }

  void channelConnect() async {
    try {
      var ip = await info.getWifiIP();
      channel = IOWebSocketChannel.connect(ip != null
          ? "ws://192.168.${ip.toString().split(".")[2]}.${(int.parse(ip.toString().split(".")[3]) - 1).toString()}:81"
          : "ws://192.168.4.1:81"); //channel IP : Port
      channel!.stream.listen(
        (message) {
          changeLedStates(message);
          setState(() {
            connected = true;
          });
        },
        onDone: () {},
        onError: (error) {
          print("error         $error");
          setState(() {
            connected = false;
          });
        },
      );
    } catch (e) {
      print("error         $e");
      setState(() {
        connected = false;
      });
    }
  }

  void changeLedStates(dynamic message) {
    print("message ------------ $message");
    setState(() {
      if (message == "connected") {
        connected = true;
      } else if (message == "ledStatus1Unavailable") {
        ledStatus1 = false;
      } else if (message == "ledStatus2Unavailable") {
        ledStatus2 = false;
      } else if (message == "ledStatus3Unavailable") {
        ledStatus3 = false;
      } else if (message == "ledStatus4Unavailable") {
        ledStatus4 = false;
      } else if (message == "ledStatus1available") {
        ledStatus1 = true;
      } else if (message == "ledStatus2available") {
        ledStatus2 = true;
      } else if (message == "ledStatus3available") {
        ledStatus3 = true;
      } else if (message == "ledStatus4available") {
        ledStatus4 = true;
      }
    });
  }

  Future<void> sendCmd(String cmd) async {
    if (connected == true) {
      channel!.sink.add(cmd);
    } else {
      channelConnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Parking ".toUpperCase(),
                style: const TextStyle(color: Colors.blue),
              ),
              Text("system ".toUpperCase()),
            ],
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          actions: [],
        ),
        body: connected!
            ? GridView(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.05),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: MediaQuery.of(context).size.height * 0.4),
                children: [
                  ParkingAreaItem(
                    isAvailable: ledStatus1!,
                    number: 1,
                  ),
                  ParkingAreaItem(
                    isAvailable: ledStatus2!,
                    number: 2,
                  ),
                  ParkingAreaItem(
                    isAvailable: ledStatus3!,
                    number: 3,
                  ),
                  ParkingAreaItem(
                    isAvailable: ledStatus4!,
                    number: 4,
                  ),
                ],
              )
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        channelConnect();
                      },
                      child: Text("retry"))
                ],
              )),
      ),
    );
  }
}
