// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/pasien.dart';
import '../../service/pasien_service.dart';
import 'pasien_detail.dart';

class PasienUpdateForm extends StatefulWidget {
  final Pasien pasien;

  const PasienUpdateForm({Key? key, required this.pasien}) : super(key: key);
  @override
  _PasienUpdateFormState createState() => _PasienUpdateFormState();
}

class _PasienUpdateFormState extends State<PasienUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _noRMCtrl = TextEditingController();
  final _namaPasienCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _teleponPasienCtrl = TextEditingController();
  final _alamatPasienCtrl = TextEditingController();
  Future<Pasien> getData() async {
    Pasien data = await PasienService().getById(widget.pasien.id.toString());
    setState(() {
      _namaPasienCtrl.text = widget.pasien.namaPasien;
      _noRMCtrl.text = widget.pasien.nomorRM;
      _tanggalLahirCtrl.text = widget.pasien.tanggalLahir;
      _teleponPasienCtrl.text = widget.pasien.nomorTelepon;
      _alamatPasienCtrl.text = widget.pasien.alamat;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Pasien")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _fieldNoRM(),
              _fieldNamaPasien(),
              _fieldTglLahirPasien(),
              _fieldTeleponPasien(),
              _fieldAlamatPasien(),
              _pembatas(),
              _tombolSimpan()
            ],
          ),
        ),
      ),
    );
  }

  _fieldNoRM() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "NO RM",
          hintText: "Input Nomor RM"),
      controller: _noRMCtrl,
    );
  }

  _fieldNamaPasien() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Nama Pasien",
          hintText: "Input Nama Pasien"),
      controller: _namaPasienCtrl,
    );
  }

  _fieldTglLahirPasien() {
    return TextField(
      decoration: const InputDecoration(
        floatingLabelStyle: TextStyle(color: Colors.red),
        labelText: "Tanggal Lahir",
        hintText: "Input Tanggal Lahir",
        icon: Icon(Icons.calendar_today),
      ),
      controller: _tanggalLahirCtrl,

      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                1990), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

          _tanggalLahirCtrl.text =
              formattedDate; //set output date to TextField value.
        }
      },
    );
  }

  _fieldAlamatPasien() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "Alamat Pasien",
          hintText: "Input Alamat Pasien"),
      controller: _alamatPasienCtrl,
    );
  }

  _fieldTeleponPasien() {
    return TextField(
      decoration: const InputDecoration(
          floatingLabelStyle: TextStyle(color: Colors.red),
          labelText: "No Telp Pasien",
          hintText: "Input Nomor Telepon Pasien"),
      controller: _teleponPasienCtrl,
    );
  }

  _pembatas() {
    return const SizedBox(height: 20);
  }

  _tombolSimpan() {
    return ElevatedButton(
        onPressed: () async {
          Pasien pasien = Pasien(
              namaPasien: _namaPasienCtrl.text,
              nomorRM: _noRMCtrl.text,
              alamat: _alamatPasienCtrl.text,
              nomorTelepon: _teleponPasienCtrl.text,
              tanggalLahir: _tanggalLahirCtrl.text);
          String id = widget.pasien.id.toString();
          await PasienService().ubah(pasien, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PasienDetail(pasien: value)));
          });
        },
        child: const Text("Simpan Perubahan"));
  }
}
