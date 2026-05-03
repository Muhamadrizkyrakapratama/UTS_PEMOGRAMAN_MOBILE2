import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';
import 'main.dart';
import 'database_helper.dart';

class Profile extends StatelessWidget {
  final User? currentUser;
  const Profile({super.key, this.currentUser});

  @override
  Widget build(BuildContext context) {
    final displayName = currentUser?.name ?? 'Muhammad Rizky Raka Pratama';
    final displayEmail = currentUser?.email ?? 'raka@example.com';
    final displayPhone = currentUser?.phone ?? '-';
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        title: const Text(
          'Profil',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // -- Header Section --
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 3,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 46,
                      backgroundImage: AssetImage('assets/raka.jpg'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Nama
                  Text(
                    displayName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A202C),
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // NIM Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF4FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'NIM: 312210397',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Role
                  const Text(
                    'Mahasiswa',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF718096),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ActionButton(
                        icon: SimpleIcons.github,
                        label: 'GitHub',
                        onTap: () {},
                      ),
                      const SizedBox(width: 10),
                      _ActionButton(
                        icon: SimpleIcons.whatsapp,
                        label: 'WhatsApp',
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // -- Matkul Section --
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBF4FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.laptop_mac_outlined,
                          size: 18,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Pemrograman Mobile 2',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A202C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            const SizedBox(height: 12),

            // -- Info Section --
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informasi Pribadi',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A202C),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _InfoRow(
                    icon: Icons.school_outlined,
                    label: 'Program Studi',
                    value: 'Teknik Informatika',
                  ),
                  _InfoRow(
                    icon: Icons.account_balance_outlined,
                    label: 'Universitas',
                    value: 'Universitas Pelita Bangsa',
                  ),
                  _InfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Angkatan',
                    value: '2022',
                  ),
                  _InfoRow(
                    icon: Icons.phone_outlined,
                    label: 'Telepon',
                    value: displayPhone,
                  ),
                  _InfoRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: displayEmail,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // -- Menu Section --
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _MenuItem(
                    icon: Icons.edit_outlined,
                    label: 'Edit Profil',
                    onTap: () {},
                  ),
                  _dividerLine(),
                  _MenuItem(
                    icon: Icons.lock_outline,
                    label: 'Ubah Password',
                    onTap: () {},
                  ),
                  _dividerLine(),
                  _MenuItem(
                    icon: Icons.logout,
                    label: 'Keluar',
                    color: Colors.red,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: const Text(
                            'Keluar Akun',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          content: const Text(
                            'Apakah kamu yakin ingin keluar?',
                            style: TextStyle(color: Color(0xFF718096)),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(),
                              child: const Text(
                                'Batal',
                                style: TextStyle(color: Color(0xFF718096)),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (_) => const HomePage(),
                                  ),
                                  (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text('Ya, Keluar'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _dividerLine() => const Divider(
        height: 1,
        thickness: 1,
        color: Color(0xFFF1F5F9),
        indent: 56,
      );
}

// -- Reusable Widgets --

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: const Color(0xFF3B82F6)),
      label: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF3B82F6),
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        side: const BorderSide(color: Color(0xFFBFDBFE)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}


class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF64748B)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A202C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MatkulItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MatkulItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF94A3B8),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = const Color(0xFF1A202C),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
            Icon(Icons.chevron_right, size: 20, color: color.withValues(alpha: 0.4)),
          ],
        ),
      ),
    );
  }
}
