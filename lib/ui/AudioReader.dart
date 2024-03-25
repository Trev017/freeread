import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'AudioProvider.dart';

class AudioReader extends StatefulWidget {
  final String? audioBookTitle;
  final String? audioBookAuthor;
  final String? audioBookChapter;
  final int? audioBookDuration;

  const AudioReader({
    super.key,
    this.audioBookTitle,
    this.audioBookAuthor,
    this.audioBookChapter,
    this.audioBookDuration,
  }
  );

  @override
  State<StatefulWidget> createState() => _MyAudioReaderPageState();
}

class _MyAudioReaderPageState extends State<AudioReader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //
      ),
      //backgroundColor: Colors.yellow.shade100,
      body: Padding(
        //Builds view for the audioplayer
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(context.watch<AudioProvider>().audioBookTitle ?? "Test"),
            const Spacer(),
            ProgressBar(progress: Duration.zero, total: Duration(seconds: widget.audioBookDuration ?? 5)),
            Row(
              children: [
                const Spacer(),
                Center(
                  child: IconButton(icon: const Icon(Icons.fast_rewind), iconSize: 40, onPressed: () {}),
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(icon: const Icon(Icons.rotate_left), iconSize: 40, onPressed: () {}),
                      Text("15"),
                    ],
                  ),
                ),
                Center(
                  child: IconButton(icon: const Icon(Icons.play_arrow), iconSize: 40, onPressed: () {}),
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(icon: const Icon(Icons.rotate_right), iconSize: 40, onPressed: () {}),
                      Text("15"),
                    ],
                  ),
                ),
                Center(
                  child: IconButton(icon: const Icon(Icons.fast_forward), iconSize: 40, onPressed: () {}),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
