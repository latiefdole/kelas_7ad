import 'package:flutter/material.dart';
import '../../model/pasien.dart';
import '../../service/pasien_service.dart';
import 'pasien_form.dart';
import 'pasien_item.dart';
import '../../widget/sidebar.dart';

class PasienPage extends StatefulWidget {
  const PasienPage({super.key});

  @override
  State<PasienPage> createState() => _PasienPageState();
}

class _PasienPageState extends State<PasienPage> {
  Stream<List<Pasien>> getList() async* {
    List<Pasien> data = await PasienService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Pasien"),
        actions: [
          ElevatedButton(
            child: const Text("Tambah Data"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PasienForm()));
            },
          )
        ],
      ),
      drawer: const Sidebar(),
      body: StreamBuilder(
        stream: getList(),
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
            return const Text('Data Kosong');
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return PasienItem(pasien: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
//       body: ListView(
//         children: [
//           PasienItem(
//               pasien: Pasien(
//                   namaPasien: "Pasien 1",
//                   nomorRM: "Melati1",
//                   alamat: "Jakarta Pusat",
//                   nomorTelepon: "088888888",
//                   tanggalLahir: "14 Oktober 1993")),
//           PasienItem(
//               pasien: Pasien(
//                   namaPasien: "Pasien 1",
//                   nomorRM: "Melati2",
//                   alamat: "Jakarta Timur",
//                   nomorTelepon: "089999999",
//                   tanggalLahir: "23 Maret 1992")),
//           PasienItem(
//               pasien: Pasien(
//                   namaPasien: "Pasien 1",
//                   nomorRM: "Anggrek21",
//                   alamat: "Jakarta Utara",
//                   nomorTelepon: "085555555",
//                   tanggalLahir: "11 Februari 1996")),
//         ],
//       ),
//     );
//   }
// }
