import 'package:flutter/material.dart';
import 'package:kelas_7ad/helpers/user_info.dart';

import 'HalamanUtama.dart';
import '../ui/login.dart';
import '../ui/pasien/pasien_page.dart';
import '../ui/pegawai/pegawai_page.dart';
import '../ui/poli/poli_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Image(image: AssetImage('../img/logo.png')),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Beranda()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Pegawai'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PegawaiPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_hospital),
            title: const Text('Pasien'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PasienPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.apartment),
            title: const Text('Data Poli'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PoliPage(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              UserInfo().logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
