import 'package:flutter/material.dart';

// Widget _buildMessageCard(String message) {
//   return Container(
//     width: double.infinity,
//     padding: const EdgeInsets.all(14),
//     decoration: BoxDecoration(
//       color: const Color(0xffF1F3F6),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     child: Text(message, style: const TextStyle(fontSize: 15)),
//   );
// }

// Widget _buildVoiceCard() {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//     decoration: BoxDecoration(
//       color: const Color(0xffF1F3F6),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     child: Row(
//       children: [
//         IconButton(
//           onPressed: _togglePlay,
//           icon: Icon(
//             _isPlaying ? Icons.pause_circle : Icons.play_circle,
//             size: 32,
//             color: Colors.green,
//           ),
//         ),
//         const SizedBox(width: 10),
//         const Text("Voice Message"),
//       ],
//     ),
//   );
// }

// Widget _buildVoiceCard() {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//     decoration: BoxDecoration(
//       color: const Color(0xffF1F3F6),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     child: Row(
//       children: [
//         IconButton(
//           onPressed: _togglePlay,
//           icon: Icon(
//             _isPlaying ? Icons.pause_circle : Icons.play_circle,
//             size: 32,
//             color: Colors.green,
//           ),
//         ),
//         const SizedBox(width: 10),
//         const Text("Voice Message"),
//       ],
//     ),
//   );
// }
// Widget _buildInputCard() {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 12),
//     decoration: BoxDecoration(
//       color: const Color(0xffF1F3F6),
//       borderRadius: BorderRadius.circular(30),
//     ),
//     child: Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: _controller,
//             onChanged: (val) {
//               setState(() {});
//             },
//             decoration: const InputDecoration(
//               hintText: "Type your query...",
//               border: InputBorder.none,
//             ),
//           ),
//         ),
//         _controller.text.trim().isNotEmpty
//             ? IconButton(
//                 icon: const Icon(Icons.send, color: Colors.green),
//                 onPressed: () {
//                   setState(() {
//                     _textMessage = _controller.text.trim();
//                     _controller.clear();
//                   });
//                 },
//               )
//             : GestureDetector(
//                 onLongPressStart: (_) => _startRecording(),
//                 onLongPressEnd: (_) => _stopRecording(),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Icon(
//                     Icons.mic,
//                     color: _isRecording ? Colors.red : Colors.green,
//                   ),
//                 ),
//               ),
//       ],
//     ),
//   );
// }
// Widget _buildRecordingIndicator() {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//     decoration: BoxDecoration(
//       color: Colors.red.withOpacity(0.1),
//       borderRadius: BorderRadius.circular(25),
//     ),
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const Icon(Icons.fiber_manual_record, color: Colors.red, size: 14),
//         const SizedBox(width: 8),
//         Text(
//           _formatTime(_seconds),
//           style: const TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Colors.red,
//           ),
//         ),
//       ],
//     ),
//   );
// }
