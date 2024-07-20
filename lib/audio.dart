import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'dart:math';

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  late AnimationController _animationController;
  bool _isPlaying = false;
  List<double> _waveformData = [];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _generateRandomWaveform();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _generateRandomWaveform() {
    final random = Random();
    _waveformData = List.generate(50, (index) => random.nextDouble());
  }

  Future<void> _toggleAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      _animationController.reverse();
    } else {
      await _audioPlayer.play(AssetSource('sb_indreams(chosic.com).mp3'));
      _animationController.forward();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Audio Player'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: RectangleWaveform(
                samples: _waveformData,
                height: 200,
                width: MediaQuery.of(context).size.width - 40,
                activeColor: Colors.purple,
                inactiveColor: Colors.purple.withOpacity(0.3),
                showActiveWaveform: true,
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: _toggleAudio,
              child: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: _animationController,
                size: 80,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
