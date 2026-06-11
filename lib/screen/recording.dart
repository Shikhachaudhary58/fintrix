// import 'dart:async';
// import 'package:fintrix/common/appbar.dart';
// import 'package:fintrix/common/upload_image.dart';
// import 'package:fintrix/screen/query_detail.dart';
// import 'package:fintrix/screen/thank_you_screen.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:record/record.dart';
// import 'package:audioplayers/audioplayers.dart';

// class VoiceRecordingScreen extends StatefulWidget {
//   const VoiceRecordingScreen({super.key});

//   @override
//   State<VoiceRecordingScreen> createState() => _VoiceRecordingScreenState();
// }

// class _VoiceRecordingScreenState extends State<VoiceRecordingScreen>
//     with SingleTickerProviderStateMixin {
//   final AudioRecorder _recorder = AudioRecorder();
//   final data = Get.arguments ?? {};
//   final AudioPlayer _player = AudioPlayer();
//   final TextEditingController _controller = TextEditingController();
//   String? _textMessage;
//   bool _isEditing = false;
//   String? _uploadedFilePath;

//   bool _isRecording = false;
//   bool _isPlaying = false;
//   String? _audioPath;
//   int _seconds = 0;
//   Timer? _timer;

//   // 🎙 Start Recording
//   Future<void> _startRecording() async {
//     if (await _recorder.hasPermission()) {
//       if (kIsWeb) {
//         await _recorder.start(const RecordConfig(), path: '');
//       } else {
//         await _recorder.start(const RecordConfig(), path: 'recorded_audio.m4a');
//       }

//       setState(() {
//         _isRecording = true;
//         _seconds = 0;
//       });

//       _timer = Timer.periodic(
//         const Duration(seconds: 1),
//         (timer) => setState(() => _seconds++),
//       );
//     }
//   }
//   // Future<void> _startRecording() async {
//   //   if (await _recorder.hasPermission()) {
//   //     await _recorder.start(const RecordConfig(), path: '');

//   //     setState(() {
//   //       _isRecording = true;
//   //       _seconds = 0;
//   //     });

//   //     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//   //       setState(() => _seconds++);
//   //     });
//   //   }
//   // }

//   // ⏹ Stop Recording
//   Future<void> _stopRecording() async {
//     final path = await _recorder.stop();
//     _timer?.cancel();

//     setState(() {
//       _isRecording = false;
//       _audioPath = path; // ✅ Save recording
//       _textMessage = null; // ✅ Now properly saved
//     });

//     print("Recorded path: $_audioPath");
//   }
//   // Future<void> _stopRecording() async {
//   //   final path = await _recorder.stop();
//   //   _timer?.cancel();

//   //   setState(() {
//   //     _isRecording = false;
//   //     _audioPath = path;
//   //   });
//   // }

//   // ▶ Play / Pause Audio

//   Future<void> _togglePlay() async {
//     if (_audioPath == null) return;

//     if (_isPlaying) {
//       await _player.stop();
//       setState(() => _isPlaying = false);
//     } else {
//       if (kIsWeb) {
//         await _player.play(UrlSource(_audioPath!));
//       } else {
//         await _player.play(DeviceFileSource(_audioPath!));
//       }

//       setState(() => _isPlaying = true);

//       _player.onPlayerComplete.listen((event) {
//         setState(() => _isPlaying = false);
//       });
//     }
//   }
//   // Future<void> _togglePlay() async {
//   //   if (_audioPath == null) return;

//   //   if (_isPlaying) {
//   //     await _player.stop();
//   //     setState(() => _isPlaying = false);
//   //   } else {
//   //     await _player.play(DeviceFileSource(_audioPath!));
//   //     setState(() => _isPlaying = true);

//   //     _player.onPlayerComplete.listen((event) {
//   //       setState(() => _isPlaying = false);
//   //     });
//   //   }
//   // }

//   String _formatTime(int seconds) {
//     final mins = seconds ~/ 60;
//     final secs = seconds % 60;
//     return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
//   }

//   @override
//   void dispose() {
//     _recorder.dispose();
//     _player.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final bool isSmall = width < 600;

//     return Scaffold(
//       appBar: appBarWidget('Raise Query'),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             /// Upload
//             UploadDocWidget(
//               title: "Upload Document",
//               getUrl: (value) {
//                 _uploadedFilePath = value;
//                 print("Selected file path: $value");
//               },
//             ),

//             const SizedBox(height: 30),

//             /// MESSAGE AREA
//             // /// MESSAGE AREA
//             // if (_textMessage != null && !_isEditing)
//             //   _buildMessageCard(_textMessage!)
//             // else if (_audioPath != null && _textMessage == null)
//             //   _buildVoiceCard()
//             // else
//             //   _buildInputCard(),

//             /// MESSAGE AREA
//             if (_isEditing)
//               _buildInputCard()
//             else if (_textMessage != null)
//               _buildMessageCard(_textMessage!)
//             else if (_audioPath != null)
//               _buildVoiceCard()
//             else
//               _buildInputCard(),

//             // if (_textMessage != null)
//             //   _buildMessageCard(_textMessage!)
//             // else if (_audioPath != null)
//             //   _buildVoiceCard()
//             // else
//             //   _buildInputCard(),
//             const SizedBox(height: 20),

//             if (_isRecording) _buildRecordingIndicator(),

//             const Spacer(), // 👈 pushes button to bottom
//             /// ✅ SUBMIT BUTTON
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onPressed: () {
//                   Get.to(
//                     () => ThankYouScreen(
//                       address: data['address'] ?? '',
//                       time: data['time'] ?? '',
//                       textMessage: _textMessage,
//                       audioPath: _audioPath,
//                       uploadedFilePath: _uploadedFilePath,
//                     ),
//                   );

//                   // Get.to(ThankYouScreen(address: ''));
//                   // _showThankYouDialog();
//                 },
//                 child: const Text(
//                   "Submit",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       // Column(
//       //   // mainAxisSize: MainAxisSize.min,
//       //   children: [
//       //     UploadDocWidget(
//       //       title: "Upload Document",
//       //       getUrl: (value) {
//       //         print("Selected file path: $value");
//       //       },
//       //     ),

//       //     const SizedBox(height: 30),

//       //     /// ✅ SHOW SENT TEXT MESSAGE
//       //     if (_textMessage != null)
//       //       Container(
//       //         width: double.infinity,
//       //         padding: const EdgeInsets.all(14),
//       //         decoration: BoxDecoration(
//       //           color: const Color(0xffF1F3F6),
//       //           borderRadius: BorderRadius.circular(12),
//       //         ),
//       //         child: Text(_textMessage!, style: const TextStyle(fontSize: 15)),
//       //       ),

//       //     /// ✅ SHOW RECORDED AUDIO CARD
//       //     if (_audioPath != null && _textMessage == null)
//       //       Container(
//       //         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//       //         decoration: BoxDecoration(
//       //           color: const Color(0xffF1F3F6),
//       //           borderRadius: BorderRadius.circular(12),
//       //         ),
//       //         child: Row(
//       //           children: [
//       //             IconButton(
//       //               onPressed: _togglePlay,
//       //               icon: Icon(
//       //                 _isPlaying ? Icons.pause_circle : Icons.play_circle,
//       //                 size: 32,
//       //                 color: Colors.green,
//       //               ),
//       //             ),
//       //             const SizedBox(width: 10),
//       //             const Text("Voice Message"),
//       //           ],
//       //         ),
//       //       ),

//       //     const SizedBox(height: 30),

//       //     /// ✅ INPUT CARD (TEXT + VOICE)
//       //     if (_textMessage == null && _audioPath == null)
//       //       Container(
//       //         padding: const EdgeInsets.symmetric(horizontal: 12),
//       //         decoration: BoxDecoration(
//       //           color: const Color(0xffF1F3F6),
//       //           borderRadius: BorderRadius.circular(30),
//       //         ),
//       //         child: Row(
//       //           children: [
//       //             /// TEXT FIELD
//       //             Expanded(
//       //               child: TextField(
//       //                 controller: _controller,
//       //                 onChanged: (val) {
//       //                   setState(() {});
//       //                 },
//       //                 decoration: const InputDecoration(
//       //                   hintText: "Type your query...",
//       //                   border: InputBorder.none,
//       //                 ),
//       //               ),
//       //             ),

//       //             /// SEND OR MIC BUTTON
//       //             _controller.text.trim().isNotEmpty
//       //                 ? IconButton(
//       //                     icon: const Icon(Icons.send, color: Colors.green),
//       //                     onPressed: () {
//       //                       setState(() {
//       //                         _textMessage = _controller.text.trim();
//       //                         _controller.clear();
//       //                       });
//       //                     },
//       //                   )
//       //                 : GestureDetector(
//       //                     onLongPressStart: (_) => _startRecording(),
//       //                     onLongPressEnd: (_) => _stopRecording(),
//       //                     child: Padding(
//       //                       padding: const EdgeInsets.all(8.0),
//       //                       child: Icon(
//       //                         Icons.mic,
//       //                         color: _isRecording ? Colors.red : Colors.green,
//       //                       ),
//       //                     ),
//       //                   ),
//       //           ],
//       //         ),
//       //       ),

//       //     const SizedBox(height: 20),

//       //     /// RECORDING TIMER
//       //     if (_isRecording)
//       //       Container(
//       //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       //         decoration: BoxDecoration(
//       //           color: Colors.red.withOpacity(0.1),
//       //           borderRadius: BorderRadius.circular(25),
//       //         ),
//       //         child: Row(
//       //           mainAxisSize: MainAxisSize.min,
//       //           children: [
//       //             const Icon(
//       //               Icons.fiber_manual_record,
//       //               color: Colors.red,
//       //               size: 14,
//       //             ),
//       //             const SizedBox(width: 8),
//       //             Text(
//       //               _formatTime(_seconds),
//       //               style: const TextStyle(
//       //                 fontWeight: FontWeight.w600,
//       //                 color: Colors.red,
//       //               ),
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //   ],
//       // ),
//     );
//   }

//   void _showThankYouDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 /// ✅ LOTTIE ANIMATION
//                 Lottie.asset(
//                   "assets/lottie/thankyou.json",
//                   height: 200,
//                   width: 200,
//                   repeat: false,
//                 ),
//                 Gap(5),

//                 const Text(
//                   "Thank you for reaching us!",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                 ),

//                 Gap(5),

//                 const Text(
//                   "We will get back to you soon.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.grey),
//                 ),

//                 Gap(20),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 45,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => QueryDetailScreen(
//                             textMessage: _textMessage,
//                             audioPath: _audioPath,
//                             uploadedFilePath: _uploadedFilePath, // ✅ REAL VALUE
//                           ),
//                         ),
//                       );
//                       // Navigator.pop(context);
//                     },
//                     child: const Text("OK"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // void _showThankYouDialog() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       return AlertDialog(
//   //         shape: RoundedRectangleBorder(
//   //           borderRadius: BorderRadius.circular(16),
//   //         ),
//   //         title: const Text("Thank You"),
//   //         content: const Text(
//   //           "Thank you for reaching us.\n\nWe will get back to you soon.",
//   //         ),
//   //         actions: [
//   //           TextButton(
//   //             onPressed: () {
//   //               Navigator.pop(context);
//   //             },
//   //             child: const Text("OK"),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }

//   Widget _buildMessageCard(String message) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(child: Text(message, style: const TextStyle(fontSize: 15))),
//           IconButton(
//             icon: Icon(Icons.edit, size: 20, color: Colors.blue.shade200),
//             // onPressed: () {
//             //   setState(() {
//             //     _isEditing = true;
//             //     _controller.text = message;
//             //   });
//             // },
//             onPressed: () {
//               setState(() {
//                 _isEditing = true;
//                 _controller.text = _textMessage ?? '';
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildMessageCard(String message) {
//   //   return Container(
//   //     width: double.infinity,
//   //     padding: const EdgeInsets.all(14),
//   //     decoration: BoxDecoration(
//   //       color: const Color(0xffF1F3F6),
//   //       borderRadius: BorderRadius.circular(12),
//   //     ),
//   //     child: Text(message, style: const TextStyle(fontSize: 15)),
//   //   );
//   // }

//   Widget _buildVoiceCard() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           /// ▶ Play Button
//           IconButton(
//             onPressed: _togglePlay,
//             icon: Icon(
//               _isPlaying ? Icons.pause_circle : Icons.play_circle,
//               size: 32,
//               color: Colors.blue.shade200,
//             ),
//           ),

//           const SizedBox(width: 10),

//           const Expanded(
//             child: Text("Voice Message", style: TextStyle(fontSize: 15)),
//           ),

//           /// ❌ Delete Button
//           IconButton(
//             icon: const Icon(Icons.delete, color: Colors.red),
//             onPressed: () async {
//               await _player.stop();
//               _timer?.cancel();

//               setState(() {
//                 _audioPath = null; // ❗ Remove recording
//                 _isPlaying = false;
//                 _isRecording = false;
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _buildVoiceCard() {
//   //   return Container(
//   //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//   //     decoration: BoxDecoration(
//   //       color: const Color(0xffF1F3F6),
//   //       borderRadius: BorderRadius.circular(12),
//   //     ),
//   //     child: Row(
//   //       children: [
//   //         IconButton(
//   //           onPressed: _togglePlay,
//   //           icon: Icon(
//   //             _isPlaying ? Icons.pause_circle : Icons.play_circle,
//   //             size: 32,
//   //             color: Colors.green,
//   //           ),
//   //         ),
//   //         const SizedBox(width: 10),
//   //         const Text("Voice Message"),
//   //       ],
//   //     ),
//   //   );
//   // }

//   Widget _buildInputCard() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _controller,

//               onChanged: (val) {
//                 setState(() {});
//               },
//               decoration: const InputDecoration(
//                 hintText: "Type your query...",
//                 border: InputBorder.none,
//                 fillColor: Colors.white,
//               ),
//             ),
//           ),
//           // _controller.text.trim().isNotEmpty
//           //     ? IconButton(
//           //         icon: const Icon(Icons.send, color: Colors.green),
//           //         onPressed: () {
//           //           setState(() {
//           //             _textMessage = _controller.text.trim();
//           //             _controller.clear();
//           //           });
//           //         },
//           //       )
//           _controller.text.trim().isNotEmpty
//               ? IconButton(
//                   icon: Icon(
//                     _isEditing ? Icons.check : Icons.send,
//                     color: Colors.blue.shade200,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _textMessage = _controller.text.trim();
//                       _audioPath = null; // ❗ Clear recording
//                       _isEditing = false;
//                       _controller.clear();
//                       // _textMessage = _controller.text.trim();
//                       // _isEditing = false; // FIRST turn off edit mode
//                       // _controller.clear(); // THEN clear controller
//                     });
//                   },
//                 )
//               : GestureDetector(
//                   onLongPressStart: (_) => _startRecording(),
//                   onLongPressEnd: (_) => _stopRecording(),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Icon(
//                       Icons.mic,
//                       color: _isRecording ? Colors.red : Colors.blue.shade200,
//                     ),
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRecordingIndicator() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.red.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(Icons.fiber_manual_record, color: Colors.red, size: 14),
//           const SizedBox(width: 8),
//           Text(
//             _formatTime(_seconds),
//             style: const TextStyle(
//               fontWeight: FontWeight.w600,
//               color: Colors.red,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:io';
import 'package:fintrix/common/appbar.dart';
import 'package:fintrix/common/custom_button.dart';
import 'package:fintrix/common/upload_image.dart';
import 'package:fintrix/screen/thank_you_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';

class VoiceRecordingScreen extends StatefulWidget {
  const VoiceRecordingScreen({super.key});

  @override
  State<VoiceRecordingScreen> createState() => _VoiceRecordingScreenState();
}

class _VoiceRecordingScreenState extends State<VoiceRecordingScreen> {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  final data = Get.arguments ?? {};
  bool _hasRecording = false; // 👈 ADD THIS

  final TextEditingController _controller = TextEditingController();

  String? _textMessage;
  String? _audioPath;
  String? _uploadedFilePath;

  bool _isRecording = false;
  bool _isPlaying = false;
  bool _isEditing = false;

  int _seconds = 0;
  Timer? _timer;

  // ================= RECORD START =================
  // Future<void> _startRecording() async {
  //   try {
  //     if (!await _recorder.hasPermission()) {
  //       Get.snackbar("Permission", "Microphone permission required");
  //       return;
  //     }

  //     if (kIsWeb) {
  //       await _recorder.start(const RecordConfig(), path: '');
  //     } else {
  //       await _recorder.start(
  //         const RecordConfig(),
  //         path: '', // auto path
  //       );
  //     }

  //     setState(() {
  //       _isRecording = true;
  //       _seconds = 0;
  //     });

  //     _timer = Timer.periodic(
  //       const Duration(seconds: 1),
  //       (_) => setState(() => _seconds++),
  //     );
  //   } catch (e) {
  //     print("Start Recording Error: $e");
  //   }
  // }

  Future<void> _startRecording() async {
    try {
      if (!await _recorder.hasPermission()) {
        Get.snackbar("Permission", "Microphone permission required");
        return;
      }

      String path = '';

      if (!kIsWeb) {
        final dir = await getTemporaryDirectory();
        path =
            '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
      }

      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: kIsWeb ? '' : path,
      );

      setState(() {
        _isRecording = true;
        _seconds = 0;
      });

      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => setState(() => _seconds++),
      );
    } catch (e) {
      print("Start Recording Error: $e");
    }
  }

  // ================= RECORD STOP =================
  Future<void> _stopRecording() async {
    try {
      final path = await _recorder.stop();
      _timer?.cancel();

      // setState(() {
      //   _isRecording = false;
      //   _audioPath = path;
      //   _textMessage = null;
      // });
      setState(() {
        _isRecording = false;

        if (kIsWeb) {
          // 👇 Web fix
          _audioPath = path ?? 'web_recording';
          _hasRecording = true;
        } else {
          _audioPath = path;
        }

        _textMessage = null;
      });
      print("Recorded path: $_audioPath");
    } catch (e) {
      print("Stop Recording Error: $e");
    }
  }

  // ================= PLAY AUDIO =================
  // Future<void> _togglePlay() async {
  //   if (_audioPath == null) return;

  //   try {
  //     if (_isPlaying) {
  //       await _player.stop();
  //       setState(() => _isPlaying = false);
  //     } else {
  //       if (kIsWeb) {
  //         await _player.play(UrlSource(_audioPath!));
  //       } else {
  //         await _player.play(DeviceFileSource(_audioPath!));
  //       }

  //       setState(() => _isPlaying = true);

  //       _player.onPlayerComplete.listen((event) {
  //         setState(() => _isPlaying = false);
  //       });
  //     }
  //   } catch (e) {
  //     print("Audio Play Error: $e");
  //   }
  // }

  Future<void> _togglePlay() async {
    if (_audioPath == null || _audioPath!.isEmpty) {
      Get.snackbar("Error", "No audio found");
      return;
    }

    try {
      if (_isPlaying) {
        await _player.stop();
        setState(() => _isPlaying = false);
      } else {
        await _player.stop(); // 🔥 important

        if (kIsWeb) {
          if (kIsWeb) {
            if (_audioPath == null || _audioPath == 'web_recording') {
              Get.snackbar("Info", "Playback not supported on web recording");
              return;
            }

            await _player.play(UrlSource(_audioPath!));
          }
          await _player.play(UrlSource(_audioPath!));
        } else {
          final file = File(_audioPath!);

          if (!file.existsSync()) {
            Get.snackbar("Error", "Audio file not found");
            return;
          }

          await _player.play(DeviceFileSource(file.path));
        }

        setState(() => _isPlaying = true);

        _player.onPlayerComplete.listen((event) {
          setState(() => _isPlaying = false);
        });
      }
    } catch (e) {
      print("Audio Play Error: $e");
      Get.snackbar("Playback Error", "Unable to play audio");
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
    _controller.dispose();
    super.dispose();
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Raise Query'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            /// Upload
            UploadDocWidget(
              title: "Upload Document",
              getUrl: (value) {
                _uploadedFilePath = value;
              },
            ),

            const SizedBox(height: 30),

            /// MESSAGE AREA
            if (_isEditing)
              _buildInputCard()
            else if (_textMessage != null)
              _buildMessageCard(_textMessage!)
            else if (_audioPath != null)
              _buildVoiceCard()
            else
              _buildInputCard(),

            const SizedBox(height: 20),

            /// RECORDING TIMER
            if (_isRecording) _buildRecordingIndicator(),

            const Spacer(),

            /// SUBMIT BUTTON
            ///
            customButton(
              title: 'Submit',
              onTap: () {
                Get.to(
                  () => ThankYouScreen(
                    address: data['address'] ?? '',
                    time: data['time'] ?? '',
                    textMessage: _textMessage,
                    audioPath: _audioPath,
                    uploadedFilePath: _uploadedFilePath,
                  ),
                );
              },
            ),
            // SizedBox(
            //   width: double.infinity,
            //   height: 50,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.green,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //     ),
            //     onPressed: () {
            // Get.to(
            //   () => ThankYouScreen(
            //     address: data['address'] ?? '',
            //     time: data['time'] ?? '',
            //     textMessage: _textMessage,
            //     audioPath: _audioPath,
            //     uploadedFilePath: _uploadedFilePath,
            //   ),
            // );
            //     },
            //     child: const Text(
            //       "Submit",
            //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // ================= TEXT MESSAGE =================
  Widget _buildMessageCard(String message) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: Text(message)),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.blue.shade200),
            onPressed: () {
              setState(() {
                _isEditing = true;
                _controller.text = message;
              });
            },
          ),
        ],
      ),
    );
  }

  // ================= VOICE CARD =================
  Widget _buildVoiceCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _togglePlay,
            icon: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.green,
            ),
          ),
          const Expanded(child: Text("Voice Message")),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              setState(() {
                _audioPath = null;
              });
            },
          ),
        ],
      ),
    );
  }

  // ================= INPUT =================
  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: "Type your query...",
                border: InputBorder.none,
              ),
            ),
          ),

          /// SEND OR MIC BUTTON
          _controller.text.trim().isNotEmpty
              ? IconButton(
                  icon: Icon(
                    _isEditing ? Icons.check : Icons.send,
                    color: Colors.blue.shade200,
                  ),
                  onPressed: () {
                    setState(() {
                      _textMessage = _controller.text.trim();
                      _audioPath = null;
                      _isEditing = false;
                      _controller.clear();
                    });
                  },
                )
              : GestureDetector(
                  onTap: () async {
                    if (_isRecording) {
                      await _stopRecording();
                    } else {
                      await _startRecording();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      _isRecording ? Icons.stop : Icons.mic,
                      color: _isRecording ? Colors.red : Colors.blue.shade200,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  // ================= RECORDING UI =================
  Widget _buildRecordingIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.fiber_manual_record, color: Colors.red, size: 14),
          const SizedBox(width: 8),
          Text(
            _formatTime(_seconds),
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
