import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeVideoPlayerScreen extends StatefulWidget {
  @override
  _YouTubeVideoPlayerScreenState createState() =>
      _YouTubeVideoPlayerScreenState();
}

class _YouTubeVideoPlayerScreenState extends State<YouTubeVideoPlayerScreen> {
  late YoutubePlayerController _controller; // Mark as late

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
            'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
          ) ??
          '', // provide a default empty string if convertUrlToId() returns null
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Video Player'),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }
}
