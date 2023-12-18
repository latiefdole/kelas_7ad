class Pasien {
  String? id;
  String namaPasien;
  String nomorRM;
  String tanggalLahir;
  String alamat;
  String nomorTelepon;
  Pasien({
    this.id,
    required this.namaPasien,
    required this.nomorRM,
    required this.alamat,
    required this.nomorTelepon,
    required this.tanggalLahir,
  });
  factory Pasien.fromJson(Map<String, dynamic> json) => Pasien(
      namaPasien: json["nama"],
      nomorRM: json["nomor_rm"],
      alamat: json["alamat"],
      nomorTelepon: json["nomor_telepon"],
      tanggalLahir: json["tanggal_lahir"],
      id: json["id"]);
  Map<String, dynamic> toJson() => {
        "nomor_rm": nomorRM,
        "nama": namaPasien,
        "alamat": alamat,
        "nomor_telepon": nomorTelepon,
        "tanggal_lahir": tanggalLahir
      };
}
