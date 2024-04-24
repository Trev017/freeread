import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
//Class where a list can be compiled to be a playlist.
class PlaylistBuilder extends StatelessWidget {

  //Class variables
  final AudioPlayer? audioPlayer;

  //Class constructor
  const PlaylistBuilder({
    super.key,
    this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
      stream: audioPlayer!.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        final sequence = state!.sequence ?? [];
        return ListView(
          children: [
            for (int x = 0; x < sequence.length; x++)
              ListTile(
                selected: x == state.currentIndex,
                title: Text(sequence[x].tag),
                onTap: () {
                  //
                },
              )
          ],
        );
      },
    );
  }
}