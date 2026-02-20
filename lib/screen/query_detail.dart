// import 'dart:io';

// import 'package:fintrix/common/appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class QueryDetailScreen extends StatefulWidget {
//   final String? textMessage;
//   final String? audioPath;
//   final String? uploadedFilePath;

//   const QueryDetailScreen({
//     super.key,
//     this.textMessage,
//     this.audioPath,
//     this.uploadedFilePath,
//   });

//   @override
//   State<QueryDetailScreen> createState() => _QueryDetailScreenState();
// }

// class _QueryDetailScreenState extends State<QueryDetailScreen> {
//   final AudioPlayer _player = AudioPlayer();
//   final TextEditingController _commentController = TextEditingController();

//   bool _isPlaying = false;
//   bool _showCommentBox = false;

//   Future<void> _togglePlay() async {
//     if (widget.audioPath == null) return;

//     if (_isPlaying) {
//       await _player.stop();
//       setState(() => _isPlaying = false);
//     } else {
//       await _player.play(DeviceFileSource(widget.audioPath!));
//       setState(() => _isPlaying = true);

//       _player.onPlayerComplete.listen((event) {
//         setState(() => _isPlaying = false);
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _player.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBarWidget('Query Details'),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// Uploaded File Preview
//             if (widget.uploadedFilePath != null)
//               Container(
//                 height: 150,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: Colors.grey.shade200,
//                 ),
//                 child: Image.network(
//                   widget.uploadedFilePath!,
//                   fit: BoxFit.cover,
//                 ),
//               ),

//             const SizedBox(height: 20),

//             /// Text Message
//             if (widget.textMessage != null)
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(
//                   color: const Color(0xffF1F3F6),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   widget.textMessage!,
//                   style: const TextStyle(fontSize: 15),
//                 ),
//               ),

//             /// Voice Message
//             if (widget.audioPath != null)
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: const Color(0xffF1F3F6),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(
//                         _isPlaying ? Icons.pause_circle : Icons.play_circle,
//                         size: 30,
//                         color: Colors.green,
//                       ),
//                       onPressed: _togglePlay,
//                     ),
//                     const Text("Voice Message"),
//                   ],
//                 ),
//               ),

//             const Spacer(),
//           ],
//         ),
//       ),

//       /// 💬 Floating Comment Button
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           /// Comment Box
//           if (_showCommentBox)
//             Container(
//               width: 250,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: _commentController,
//                     decoration: const InputDecoration(
//                       hintText: "Enter your complaint...",
//                       border: OutlineInputBorder(),
//                     ),
//                     maxLines: 2,
//                   ),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         _showCommentBox = false;
//                       });
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Complaint submitted")),
//                       );
//                     },
//                     child: const Text("Submit"),
//                   ),
//                 ],
//               ),
//             ),

//           const SizedBox(height: 10),

//           FloatingActionButton(
//             backgroundColor: Colors.green,
//             child: const Icon(Icons.comment),
//             onPressed: () {
//               setState(() {
//                 _showCommentBox = !_showCommentBox;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/foundation.dart';
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

  // ====== WORKING DAY LOGIC ======
  final DateTime _createdDate = DateTime.now();
  DateTime? _expectedResolutionDate;
  int _remainingWorkingDays = 3;
  String _status = "In Progress";

  @override
  void initState() {
    super.initState();

    _expectedResolutionDate = _calculateExpectedDate(_createdDate, 3);

    _calculateRemainingDays();
  }

  DateTime _calculateExpectedDate(DateTime startDate, int workingDays) {
    int addedDays = 0;
    DateTime date = startDate;

    while (addedDays < workingDays) {
      date = date.add(const Duration(days: 1));

      if (date.weekday != DateTime.saturday &&
          date.weekday != DateTime.sunday) {
        addedDays++;
      }
    }
    return date;
  }

  void _calculateRemainingDays() {
    DateTime today = DateTime.now();
    int remaining = 0;
    DateTime temp = today;

    while (temp.isBefore(_expectedResolutionDate!)) {
      temp = temp.add(const Duration(days: 1));

      if (temp.weekday != DateTime.saturday &&
          temp.weekday != DateTime.sunday) {
        remaining++;
      }
    }

    setState(() {
      _remainingWorkingDays = remaining;
      if (_remainingWorkingDays <= 0) {
        _status = "Completed";
      }
    });
  }

  // ===== AUDIO PLAY =====
  Future<void> _togglePlay() async {
    if (widget.audioPath == null) return;

    if (_isPlaying) {
      await _player.stop();
      setState(() => _isPlaying = false);
    } else {
      if (kIsWeb) {
        await _player.play(UrlSource(widget.audioPath!));
      } else {
        await _player.play(DeviceFileSource(widget.audioPath!));
      }

      setState(() => _isPlaying = true);

      _player.onPlayerComplete.listen((event) {
        setState(() => _isPlaying = false);
      });
    }
  }

  Widget _buildStatusTile({required String title, required bool isActive}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            isActive ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isActive ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.black : Colors.grey,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Query Details'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== FILE PREVIEW =====
              if (widget.uploadedFilePath != null)
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: kIsWeb
                        ? Image.network(
                            widget.uploadedFilePath!,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(widget.uploadedFilePath!),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),

              const SizedBox(height: 20),

              // ===== USER TEXT MESSAGE =====
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

              const SizedBox(height: 20),

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

              // ===== RESOLUTION MESSAGE =====
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _remainingWorkingDays > 0
                      ? "Your query will be resolved within $_remainingWorkingDays working day(s).\nExpected Resolution Date: ${_expectedResolutionDate!.day}-${_expectedResolutionDate!.month}-${_expectedResolutionDate!.year}"
                      : "Your query has been resolved.",
                  style: const TextStyle(fontSize: 14),
                ),
              ),

              const SizedBox(height: 20),

              // ===== TRACKING HISTORY =====
              const Text(
                "Tracking History",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),

              _buildStatusTile(title: "Query Submitted", isActive: true),
              _buildStatusTile(
                title: "In Progress",
                isActive: _status == "In Progress",
              ),
              _buildStatusTile(
                title: "Completed",
                isActive: _status == "Completed",
              ),

              // const Spacer(),

              // ===== VOICE MESSAGE =====
            ],
          ),
        ),
      ),

      // ===== COMMENT BUTTON =====
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
