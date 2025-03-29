import 'package:flutter/material.dart';
import '../models/company_registration.dart';
import 'client_details_screen.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _selectedChat = 'John Smith'; // Для демонстрации

  // Моковые данные для чатов
  final List<Map<String, dynamic>> _chats = [
    {
      'name': 'John Smith',
      'lastMessage': 'When will my application be processed?',
      'time': '2:30 PM',
      'unread': 2,
      'clientType': ClientType.regular,
      'applications': [
        CompanyRegistration(
          id: 'REG001',
          companyName: 'Tech Solutions Ltd',
          clientName: 'John Smith',
          email: 'john.smith@techsolutions.com',
          phone: '+971 50 123 4567',
          freezone: 'DMCC',
          submissionDate: DateTime.now().subtract(const Duration(days: 2)),
          status: RegistrationStatus.new_,
          notes: 'Premium client, urgent processing required',
        ),
        CompanyRegistration(
          id: 'REG002',
          companyName: 'Global Trading FZE',
          clientName: 'John Smith',
          email: 'john.smith@techsolutions.com',
          phone: '+971 50 123 4567',
          freezone: 'JAFZA',
          submissionDate: DateTime.now().subtract(const Duration(days: 5)),
          status: RegistrationStatus.inProgress,
          notes: 'Documents pending verification',
        ),
      ],
    },
    {
      'name': 'Sarah Johnson',
      'lastMessage': 'Thank you for your help!',
      'time': '1:45 PM',
      'unread': 0,
      'clientType': ClientType.agent,
      'applications': [
        CompanyRegistration(
          id: 'REG003',
          companyName: 'Dubai Investments LLC',
          clientName: 'Sarah Johnson',
          email: 'sarah.j@globaltrading.com',
          phone: '+971 50 234 5678',
          freezone: 'SHAMS',
          submissionDate: DateTime.now().subtract(const Duration(days: 10)),
          status: RegistrationStatus.completed,
          notes: 'All documents verified and approved',
        ),
      ],
    },
    {
      'name': 'Ahmed Al-Rahman',
      'lastMessage': 'I need to update my documents',
      'time': '12:15 PM',
      'unread': 1,
      'clientType': ClientType.regular,
      'applications': [
        CompanyRegistration(
          id: 'REG004',
          companyName: 'Innovation Hub FZCO',
          clientName: 'Ahmed Al-Rahman',
          email: 'ahmed@dubaiinvestments.com',
          phone: '+971 50 345 6789',
          freezone: 'DMCC',
          submissionDate: DateTime.now().subtract(const Duration(days: 1)),
          status: RegistrationStatus.new_,
          notes: 'Startup company, priority processing',
        ),
      ],
    },
    {
      'name': 'Maria Garcia',
      'lastMessage': 'Can you explain the process?',
      'time': '11:30 AM',
      'unread': 0,
      'clientType': ClientType.regular,
      'applications': [
        CompanyRegistration(
          id: 'REG005',
          companyName: 'Middle East Trading Co',
          clientName: 'Maria Garcia',
          email: 'maria@innovationhub.com',
          phone: '+971 50 456 7890',
          freezone: 'JAFZA',
          submissionDate: DateTime.now().subtract(const Duration(days: 7)),
          status: RegistrationStatus.rejected,
          notes: 'Incomplete documentation',
        ),
      ],
    },
  ];

  // Моковые данные для сообщений
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello, how can I help you today?',
      'isMe': true,
      'time': '2:25 PM',
    },
    {
      'text': 'When will my application be processed?',
      'isMe': false,
      'time': '2:26 PM',
    },
    {
      'text': 'Your application is currently under review. We will process it within 3-5 business days.',
      'isMe': true,
      'time': '2:27 PM',
    },
    {
      'text': 'Thank you for the information.',
      'isMe': false,
      'time': '2:28 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Chat'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Row(
        children: [
          // Список чатов
          Container(
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
            child: Column(
              children: [
                // Поиск
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search chats...',
                      prefixIcon: const Icon(Icons.search, size: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                // Список чатов
                Expanded(
                  child: ListView.builder(
                    itemCount: _chats.length,
                    itemBuilder: (context, index) {
                      final chat = _chats[index];
                      final isSelected = chat['name'] == _selectedChat;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedChat = chat['name'];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                                : Colors.transparent,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                child: Text(
                                  chat['name'][0],
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chat['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      chat['lastMessage'],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    chat['time'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (chat['unread'] > 0) ...[
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        chat['unread'].toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Область чата
          Expanded(
            child: Column(
              children: [
                // Заголовок чата
                GestureDetector(
                  onTap: () {
                    final selectedChatData = _chats.firstWhere(
                      (chat) => chat['name'] == _selectedChat,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClientDetailsScreen(
                          clientName: selectedChatData['name'],
                          clientType: selectedChatData['clientType'],
                          applications: selectedChatData['applications'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          child: Text(
                            _selectedChat[0],
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedChat,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Online',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                ),
                // Сообщения
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return Align(
                        alignment: message['isMe']
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: message['isMe']
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message['text'],
                                style: TextStyle(
                                  color: message['isMe']
                                      ? Colors.white
                                      : Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                message['time'],
                                style: TextStyle(
                                  color: message['isMe']
                                      ? Colors.white.withOpacity(0.7)
                                      : Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Поле ввода
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.attach_file),
                        onPressed: () {
                          // TODO: Implement file attachment
                        },
                      ),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          maxLines: null,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (_messageController.text.isNotEmpty) {
                            // TODO: Implement send message
                            _messageController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
} 