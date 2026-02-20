import 'dart:io';

import 'package:fintrix/common/appbar.dart';
import 'package:fintrix/common/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class VoiceRecord extends StatefulWidget {
  const VoiceRecord({super.key});

  @override
  State<VoiceRecord> createState() => _VoiceRecordState();
}

class _VoiceRecordState extends State<VoiceRecord> {
  final AudioRecorder audioRecorder = AudioRecorder();
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isRecording = false;
  bool isPlaying = false;
  String? recordingPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Raise Query'),
      floatingActionButton: _recordingButton(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 14),
          child: Column(
            children: [
              UploadDocWidget(
                title: "Upload Document",
                getUrl: (value) {
                  print("Selected file path: $value");
                },
              ),
              _buildUi(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUi() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (recordingPath != null)
            MaterialButton(
              onPressed: () async {
                if (audioPlayer.playing) {
                  audioPlayer.stop();
                  setState(() {
                    isPlaying = false;
                  });
                } else {
                  await audioPlayer.setFilePath(recordingPath!);
                  audioPlayer.play();
                  setState(() {
                    isPlaying = true;
                  });
                }
              },
              color: Colors.blueGrey,
              child: Text(
                isPlaying
                    ? 'Stop Playing Recording'
                    : 'start Playing Recording',
                style: TextStyle(color: Colors.black),
              ),
            ),
          if (recordingPath == null) Center(child: Text('No record found')),
        ],
      ),
    );
  }

  Widget _recordingButton() {
    return FloatingActionButton(
      onPressed: () async {
        if (isRecording) {
          String? filePath = await audioRecorder.stop();
          if (filePath != null) {
            setState(() {
              isRecording = false;
              recordingPath = filePath;
            });
          }
        } else {
          if (await audioRecorder.hasPermission()) {
            final Directory appDocumentDir =
                await getApplicationDocumentsDirectory();
            final String filePath = p.join(
              appDocumentDir.path,
              'recording.wav',
            );
            await audioRecorder.start(RecordConfig(), path: filePath);
            setState(() {
              isRecording = true;
              recordingPath = null;
            });
          }
        }
      },
      child: Icon(isRecording ? Icons.stop : Icons.mic),
    );
  }
}
