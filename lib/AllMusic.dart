import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:songs/Model.dart';

class AllMusic extends StatefulWidget {
  const AllMusic({Key? key}) : super(key: key);

  @override
  State<AllMusic> createState() => _AllMusicState();
}

class _AllMusicState extends State<AllMusic> {

  AudioPlayer player = AudioPlayer();

  List<bool> statuslist = [];

  @override
  void initState() {
    super.initState();

    statuslist = List.filled(Model.SongList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Music"),
      ),
      body: ListView.builder(
        itemCount: Model.SongList.length,
        itemBuilder: (context, index) {
          return ListTile(

            trailing: statuslist[index] ?
            IconButton(onPressed: () async {

              setState(() {
                statuslist = List.filled(Model.SongList.length, false);
              });

              print(statuslist);

              await player.stop();

            }, icon: Icon(Icons.pause))

                :IconButton(onPressed: () async {
              await player.stop();

              setState(() {
                statuslist = List.filled(Model.SongList.length, false);
                statuslist[index] = true;
              });

              await player.play(DeviceFileSource(Model.SongList[index].data));

              print(statuslist);


            }, icon: Icon(Icons.play_arrow)),

            title: Text("${Model.SongList[index].displayNameWOExt}"),
            subtitle: Text("${Model.SongList[index].duration}"),
          );
        },
      ),
    );
  }
}
