import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/models/message.dart';
import 'package:prueba_tecnica_01/test_exercises/chatApp/provider/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false).fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                if (chatProvider.messages.isEmpty) {
                  return const Center(
                      child: Text('Message history is empty',
                          style: TextStyle(color: Colors.white)));
                }

                return ListView.builder(
                  itemCount: chatProvider.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatProvider.messages[index];
                    return _buildMessageCard(message);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      final player = AudioPlayer();
                      await player
                          .play(AssetSource('audio/notification-1.mp3'));

                      // ignore: use_build_context_synchronously
                      Provider.of<ChatProvider>(context, listen: false)
                          .addMessage(text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageCard(Message message) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                message.message,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                message.date.toString(),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
              right: -3,
              top: -14,
              child: message.photoUrl.isNotEmpty
                  ? CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(message.photoUrl))
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 60,
                      width: 60,
                      child: const Center(child: Text('Error')))),
        ],
      ),
    );
  }
}
