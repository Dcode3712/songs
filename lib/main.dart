import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:songs/DatePicker_TimePicker.dart';
import 'package:songs/Model.dart';

import 'AllMusic.dart';

void main() {
  runApp(MaterialApp(
    // home: splash(),
    home: dateandtimepicker(),
  ));
}

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {

  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
  super.initState();

  loadSongs();
  }

  loadSongs()
  async {

    var status = await Permission.storage.status;
    if (status.isDenied) {
      await [Permission.storage].request();
    }

   Model.SongList = await _audioQuery.querySongs();

   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
     return AllMusic();
   },));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Loading....", style: TextStyle(fontSize: 17)),
      ),
    );
  }


}
