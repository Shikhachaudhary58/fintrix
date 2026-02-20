import 'dart:io';

import 'package:fintrix/common/appbar.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class QueryDetailScreen extends StatefulWidget {
  final String? textMessage;
  final String? audioPath;
  final String? uploadedFilePath;

  const QueryDetailScreen({
    super.key,
    this.textMessage,
    this.audioPath,
    this.uploadedFilePath,
  });

  @override
  State<QueryDetailScreen> createState() => _QueryDetailScreenState();
}

class _QueryDetailScreenState extends State<QueryDetailScreen> {
  final AudioPlayer _player = AudioPlayer();
  final TextEditingController _commentController = TextEditingController();

  bool _isPlaying = false;
  bool _showCommentBox = false;

  Future<void> _togglePlay() async {
    if (widget.audioPath == null) return;

    if (_isPlaying) {
      await _player.stop();
      setState(() => _isPlaying = false);
    } else {
      await _player.play(DeviceFileSource(widget.audioPath!));
      setState(() => _isPlaying = true);

      _player.onPlayerComplete.listen((event) {
        setState(() => _isPlaying = false);
      });
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Query Details'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Uploaded File Preview
            if (widget.uploadedFilePath != null)
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200,
                ),
                child: Image.network(
                  widget.uploadedFilePath!,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 20),

            /// Text Message
            if (widget.textMessage != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xffF1F3F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.textMessage!,
                  style: const TextStyle(fontSize: 15),
                ),
              ),

            /// Voice Message
            if (widget.audioPath != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xffF1F3F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _isPlaying ? Icons.pause_circle : Icons.play_circle,
                        size: 30,
                        color: Colors.green,
                      ),
                      onPressed: _togglePlay,
                    ),
                    const Text("Voice Message"),
                  ],
                ),
              ),

            const Spacer(),
          ],
        ),
      ),

      /// 💬 Floating Comment Button
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Comment Box
          if (_showCommentBox)
            Container(
              width: 250,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: "Enter your complaint...",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showCommentBox = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Complaint submitted")),
                      );
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 10),

          FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(Icons.comment),
            onPressed: () {
              setState(() {
                _showCommentBox = !_showCommentBox;
              });
            },
          ),
        ],
      ),
    );
  }
}
