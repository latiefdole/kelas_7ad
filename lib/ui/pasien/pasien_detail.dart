import 'package:flutter/material.dart';
import '../../service/pasien_service.dart';
import '../../model/pasien.dart';
import '../../widget/sidebar.dart';
import 'pasien_page.dart';
import 'pasien_update_form.dart';

class PasienDetail extends StatefulWidget {
  final Pasien pasien;

  const PasienDetail({super.key, required this.pasien});

  @override
  State<PasienDetail> createState() => _PasienDetailState();
}

class _PasienDetailState extends State<PasienDetail> {
  Stream<Pasien> getData() async* {
    Pasien data = await PasienService().getById(widget.pasien.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pasien Detail")),
      drawer: const Sidebar(),
      body: StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return const Text('Data Tidak Ditemukan');
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ListTile(
                  title: const Text("Nomor RM"),
                  subtitle: Text(snapshot.data.nomorRM,
                      style: const TextStyle(fontSize: 20))),
              ListTile(
                  title: const Text("Nama Pasien"),
                  subtitle: Text(snapshot.data.namaPasien,
                      style: const TextStyle(fontSize: 20))),
              ListTile(
                  title: const Text("Tanggal Lahir"),
                  subtitle: Text(snapshot.data.tanggalLahir,
                      style: const TextStyle(fontSize: 20))),
              ListTile(
                  title: const Text("Nomor Telepon"),
                  subtitle: Text(snapshot.data.nomorTelepon,
                      style: const TextStyle(fontSize: 20))),
              ListTile(
                  title: const Text("Alamat"),
                  subtitle: Text(snapshot.data.alamat,
                      style: const TextStyle(fontSize: 20))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _tombolUbah(),
                  _tombolHapus(),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  _tombolUbah() {
    return StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PasienUpdateForm(pasien: snapshot.data)));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Ubah")));
  }

  _tombolHapus() {
    return ElevatedButton(
        onPressed: () async {
          AlertDialog alertDialog = AlertDialog(
            content: const Text("Yakin ingin menghapus data ini?"),
            actions: [
              // tombol ya
              StreamBuilder(
                stream: getData(),
                builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Close the confirmation dialog
                    _hapusData(snapshot.data);
                    // Call the _hapusData function
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PasienPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("YA"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Tidak"),
              )
            ],
          );
          showDialog(context: context, builder: (context) => alertDialog);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Hapus"));
  }

// Function to handle data deletion and navigation
  _hapusData(data) async {
    await PasienService().hapus(data);
    await Future.delayed(Duration.zero);
    if (!context.mounted) return;
    Navigator.of(context).pop(); // Close the confirmation dialog
  }
}
