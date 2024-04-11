import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class InternetErrorWidget extends StatelessWidget {
  final bool connected;
  const InternetErrorWidget({super.key, required this.connected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.height * 0.1,
            backgroundColor: Colors.white,
            child: AvatarGlow(
              animate: true,
              glowColor: Colors.grey.shade400,
              endRadius: MediaQuery.of(context).size.height * 0.15,
              showTwoGlows: true,
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 2000),
              repeatPauseDuration: const Duration(milliseconds: 100),
              repeat: true,
              child: Icon(
                Icons.wifi_off_outlined,
                size: MediaQuery.of(context).size.height * 0.1,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(
            "لايوجد اتصال بالانترنت",
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}
