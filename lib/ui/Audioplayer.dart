import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class Audioplayer extends StatefulWidget {
  const Audioplayer({super.key});

  @override
  State<StatefulWidget> createState() => _MyAudioplayerPageState();
}

class _MyAudioplayerPageState extends State<Audioplayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //
      ),
      backgroundColor: Colors.yellow.shade100,
      body: Padding(
        //Builds view for the audioplayer
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Test"),
            const Spacer(),
            const ProgressBar(progress: Duration.zero, total: Duration(seconds: 5)),
            IconButton(icon: const Icon(Icons.play_arrow), iconSize: 40, onPressed: () {}),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
