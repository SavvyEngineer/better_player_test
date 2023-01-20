import 'dart:io';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/playlist.m3u');
}

class HlsAudioPage extends StatefulWidget {
  @override
  _HlsAudioPageState createState() => _HlsAudioPageState();
}

class _HlsAudioPageState extends State<HlsAudioPage> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    var str =
        "http://sample.vodobox.net/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8";
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    BetterPlayerDataSource dataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, str);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HLS Audio"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Click on overflow menu (3 dots) and select Audio. You can choose "
              "audio track from HLS stream. Better Player will setup audio"
              " automatically for you.",
              style: TextStyle(fontSize: 16),
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
        ],
      ),
    );
  }
}
