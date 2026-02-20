import 'dart:async';
import 'package:fintrix/common/appbar.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class VoiceRecorderScreen extends StatefulWidget {
  const VoiceRecorderScreen({super.key});

  @override
  State<VoiceRecorderScreen> createState() => _VoiceRecorderScreenState();
}

class _VoiceRecorderScreenState extends State<VoiceRecorderScreen> {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();

  bool _isRecording = false;
  String? _audioPath;
  int _seconds = 0;
  Timer? _timer;

  /// Start Recording
  Future<void> _startRecording() async {
    if (await _recorder.hasPermission()) {
      final dir = await getTemporaryDirectory();
      final path =
          '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _recorder.start(const RecordConfig(), path: path);

      setState(() {
        _isRecording = true;
        _audioPath = path;
        _seconds = 0;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() => _seconds++);
      });
    }
  }

  /// Stop Recording
  Future<void> _stopRecording() async {
    await _recorder.stop();
    _timer?.cancel();

    setState(() {
      _isRecording = false;
    });
  }

  /// Play Audio
  Future<void> _playAudio() async {
    if (_audioPath != null) {
      await _player.play(DeviceFileSource(_audioPath!));
    }
  }

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _recorder.dispose();
    _player.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBarWidget('Raise Query'),
      body: Stack(
        children: [
          Center(
            child: _audioPath != null && !_isRecording
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Recorded Audio"),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _playAudio,
                        child: const Text("Play"),
                      ),
                    ],
                  )
                : const Text("Hold mic to record"),
          ),

          /// Recording UI Overlay
          if (_isRecording)
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Text(
                      _formatTime(_seconds),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Text(
                        "Slide to cancel",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          /// Mic Button
          Positioned(
            bottom: 30,
            right: 20,
            child: GestureDetector(
              onLongPressStart: (_) => _startRecording(),
              onLongPressEnd: (_) => _stopRecording(),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: _isRecording ? Colors.red : Colors.green,
                child: const Icon(Icons.mic, color: Colors.white, size: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
