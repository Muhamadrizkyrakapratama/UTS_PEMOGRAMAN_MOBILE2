import 'package:flutter/material.dart';
import 'dart:async';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime time;

  ChatMessage({required this.text, required this.isUser, required this.time});
}

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  // Menu cepat / quick replies
  final List<String> _quickReplies = [
    '📦 Cek pesanan',
    '🔄 Retur & refund',
    '👟 Info produk',
    '💳 Metode pembayaran',
    '📍 Toko terdekat',
    '📞 Hubungi CS',
  ];

  // Basis pengetahuan chatbot
  final Map<String, String> _responses = {
    'halo': '👋 Halo! Selamat datang di CS Toko Sepatu. Ada yang bisa saya bantu?',
    'hi': '👋 Hi! Selamat datang! Saya siap membantu Anda. 😊',
    'cek pesanan':
        '📦 Untuk cek pesanan, silakan masuk ke menu *Pesanan Saya* di aplikasi atau kirimkan nomor pesanan Anda di sini.',
    'pesanan':
        '📦 Untuk cek pesanan, silakan masuk ke menu *Pesanan Saya* di aplikasi atau kirimkan nomor pesanan Anda di sini.',
    'retur':
        '🔄 Retur produk dapat dilakukan dalam **7 hari** setelah barang diterima. Syarat: produk belum dipakai & tag masih terpasang. Hubungi kami di 0800-1234-5678.',
    'refund':
        '💰 Refund diproses dalam **3–5 hari kerja** setelah produk diterima. Dana dikembalikan ke metode pembayaran asal.',
    'info produk':
        '👟 Produk kami tersedia dalam berbagai ukuran (36–45). Apakah ada produk tertentu yang ingin Anda tanyakan?',
    'produk':
        '👟 Kami menjual Nike, Adidas, Puma, Vans, Jordan, dan banyak lagi! Cek koleksi terbaru di Dashboard.',
    'pembayaran':
        '💳 Kami menerima: **Transfer Bank, GoPay, OVO, Dana, QRIS, Kartu Kredit/Debit, dan COD** (area tertentu).',
    'metode pembayaran':
        '💳 Metode yang tersedia: Transfer Bank, GoPay, OVO, Dana, QRIS, COD. Pilih yang paling mudah untuk Anda!',
    'toko':
        '📍 Toko kami ada di:\n• Jakarta Selatan – Jl. Sudirman No. 10\n• Bandung – Jl. Braga No. 25\n• Surabaya – Jl. Tunjungan No. 5\nBuka pukul 09.00–21.00 WIB.',
    'terdekat':
        '📍 Toko kami ada di Jakarta Selatan, Bandung, dan Surabaya. Ketik "toko" untuk info lengkap!',
    'cs':
        '📞 Hubungi CS kami:\n• WhatsApp: 0812-3456-7890\n• Email: cs@tokosepatu.id\n• Jam layanan: 08.00–20.00 WIB',
    'hubungi':
        '📞 Hubungi CS kami di WhatsApp **0812-3456-7890** atau email **cs@tokosepatu.id**.',
    'garansi':
        '🛡️ Semua produk kami bergaransi **30 hari** dari tanggal pembelian untuk cacat produksi.',
    'ukuran':
        '📏 Kami tersedia ukuran **36 hingga 45**. Ingin panduan size chart? Saya bisa bantu!',
    'size':
        '📏 Ukuran tersedia: 36–45. Untuk referensi ukuran, kunjungi halaman produk dan lihat tab Size Guide.',
    'diskon':
        '🏷️ Cek promo terbaru di halaman Promo! Saat ini ada diskon hingga **40%** untuk produk pilihan.',
    'promo':
        '🏷️ Promo spesial tersedia setiap hari! Cek tab Promo di aplikasi untuk voucher dan flash sale.',
    'pengiriman':
        '🚚 Pengiriman tersedia ke seluruh Indonesia via JNE, J&T, SiCepat, dan GoSend (same day area tertentu).',
    'ongkir':
        '🚚 Ongkos kirim dihitung berdasarkan berat dan lokasi tujuan. Gratis ongkir untuk pembelian min. Rp 500.000!',
    'terima kasih':
        '😊 Sama-sama! Senang bisa membantu. Ada hal lain yang ingin ditanyakan?',
    'makasih':
        '😊 Sama-sama! Jangan ragu untuk tanya lagi ya. 👋',
    'bye':
        '👋 Terima kasih sudah menghubungi kami! Semoga belanjanya menyenangkan!',
    'selamat tinggal':
        '👋 Terima kasih! Jika ada pertanyaan lain, kami selalu siap membantu. Sampai jumpa! 😊',
  };

  @override
  void initState() {
    super.initState();
    // Pesan sambutan otomatis
    Future.delayed(const Duration(milliseconds: 300), () {
      _addBotMessage(
          '👋 Halo! Selamat datang di **CS Toko Sepatu**.\n\nSaya Sapi, asisten virtual kami. Ada yang bisa saya bantu hari ini?');
    });
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: false, time: DateTime.now()));
    });
    _scrollToBottom();
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    _controller.clear();

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true, time: DateTime.now()));
      _isTyping = true;
    });
    _scrollToBottom();

    // Simulasi delay bot mengetik
    final delay = 800 + (text.length * 20).clamp(0, 1200);
    Future.delayed(Duration(milliseconds: delay), () {
      if (!mounted) return;
      setState(() => _isTyping = false);
      _addBotMessage(_generateResponse(text));
    });
  }

  String _generateResponse(String input) {
    final lower = input.toLowerCase().trim();

    for (final key in _responses.keys) {
      if (lower.contains(key)) {
        return _responses[key]!;
      }
    }

    // Fallback
    return '🤔 Maaf, saya kurang memahami pertanyaan Anda.\n\nCoba tanyakan tentang:\n• Pesanan & pengiriman\n• Retur & refund\n• Produk & ukuran\n• Promo & diskon\n\nAtau hubungi CS kami di **0812-3456-7890**.';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.support_agent, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CS Toko Sepatu',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                Text(
                  '🟢 Online',
                  style: TextStyle(fontSize: 11, color: Color(0xFFBFDBFE)),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat header banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: const BoxDecoration(
              color: Color(0xFF1E3A8A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: const Text(
              '⏱️ Rata-rata waktu respons: < 1 menit',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFBFDBFE), fontSize: 12),
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),

          // Quick replies
          if (_messages.length <= 2)
            Container(
              height: 44,
              margin: const EdgeInsets.only(bottom: 4),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _quickReplies.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () => _sendMessage(_quickReplies[i].replaceAll(RegExp(r'[^\w\s]', unicode: true), '').trim()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A8A).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF1E3A8A).withOpacity(0.3)),
                      ),
                      child: Text(
                        _quickReplies[i],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF1E3A8A),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          // Input area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _controller,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        hintText: 'Ketik pesan...',
                        hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _sendMessage(_controller.text),
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E3A8A),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg) {
    final isUser = msg.isUser;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: Color(0xFF1E3A8A),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.support_agent, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.72,
                  ),
                  decoration: BoxDecoration(
                    color: isUser ? const Color(0xFF1E3A8A) : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isUser ? 16 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    msg.text,
                    style: TextStyle(
                      color: isUser ? Colors.white : const Color(0xFF1A202C),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(msg.time),
                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                ),
              ],
            ),
          ),
          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xFF1E3A8A),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.support_agent, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300 + (i * 150)),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: const Color(0xFF94A3B8),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
