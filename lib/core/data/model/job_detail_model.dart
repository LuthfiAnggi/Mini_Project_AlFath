// lib/data/models/job_detail_model.dart

import 'dart:convert';
import 'package:equatable/equatable.dart';



// 1. KELAS UTAMA (INDuk)
class JobDetailModel extends Equatable {
  final JobDetailData data;

  const JobDetailModel({required this.data});

  factory JobDetailModel.fromRawJson(String str) =>
      JobDetailModel.fromJson(json.decode(str));

  factory JobDetailModel.fromJson(Map<String, dynamic> json) => JobDetailModel(
        data: JobDetailData.fromJson(json["data"]),
      );

  @override
  List<Object?> get props => [data];
}

// 2. KELAS DATA (Berisi pekerjaan, perusahaan, lamaran)
class JobDetailData extends Equatable {
  final PekerjaanDetail pekerjaan;
  final PerusahaanDetail perusahaan;
  final Lamaran lamaran;

  const JobDetailData({
    required this.pekerjaan,
    required this.perusahaan,
    required this.lamaran,
  });

  factory JobDetailData.fromJson(Map<String, dynamic> json) => JobDetailData(
        pekerjaan: PekerjaanDetail.fromJson(json["pekerjaan"]),
        perusahaan: PerusahaanDetail.fromJson(json["perusahaan"]),
        lamaran: Lamaran.fromJson(json["lamaran"]),
      );

  @override
  List<Object?> get props => [pekerjaan, perusahaan, lamaran];
}

// 3. KELAS PEKERJAAN DETAIL
class PekerjaanDetail extends Equatable {
  final String key;
  final String nama;
  final String lokasi; // Diperbaiki: String
  final int minimalGaji;
  final int maksimalGaji;
  final String tipe; // Diperbaiki: String
  final String kategori; // Diperbaiki: String
  final List<Skill> skill;
  final String minimalPendidikan;
  final String minimalPengalaman;
  final String workType; // Diperbaiki: String
  final String status;
  final String minimalUmur;
  final String deskripsi;
  final String createdAt; // Diperbaiki: String

  const PekerjaanDetail({
    required this.key,
    required this.nama,
    required this.lokasi,
    required this.minimalGaji,
    required this.maksimalGaji,
    required this.tipe,
    required this.kategori,
    required this.skill,
    required this.minimalPendidikan,
    required this.minimalPengalaman,
    required this.workType,
    required this.status,
    required this.minimalUmur,
    required this.deskripsi,
    required this.createdAt,
  });

  factory PekerjaanDetail.fromJson(Map<String, dynamic> json) =>
      PekerjaanDetail(
        key: json["key"],
        nama: json["nama"],
        lokasi: json["lokasi"],
        minimalGaji: json["minimalGaji"],
        maksimalGaji: json["maksimalGaji"],
        tipe: json["tipe"],
        kategori: json["kategori"],
        skill: List<Skill>.from(json["skill"].map((x) => Skill.fromJson(x))),
        minimalPendidikan: json["minimalPendidikan"],
        minimalPengalaman: json["minimalPengalaman"],
        workType: json["work_type"],
        status: json["status"],
        minimalUmur: json["minimalUmur"],
        deskripsi: json["deskripsi"],
        createdAt: json["created_at"],
      );

  @override
  List<Object?> get props => [key, nama, lokasi, deskripsi];
}

// 4. KELAS SKILL (Sub-model untuk list skill)
class Skill extends Equatable {
  final int id;
  final String name;

  const Skill({required this.id, required this.name});

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: json["id"],
        name: json["name"],
      );

  @override
  List<Object?> get props => [id, name];
}

// 5. KELAS PERUSAHAAN DETAIL
class PerusahaanDetail extends Equatable {
  final String key;
  final String nama; // Diperbaiki: String
  final String logo;
  final String alamat;
  final String deskripsi;
  final String website;

  const PerusahaanDetail({
    required this.key,
    required this.nama,
    required this.logo,
    required this.alamat,
    required this.deskripsi,
    required this.website,
  });

  factory PerusahaanDetail.fromJson(Map<String, dynamic> json) =>
      PerusahaanDetail(
        key: json["key"],
        nama: json["nama"],
        logo: json["logo"],
        alamat: json["alamat"],
        deskripsi: json["deskripsi"],
        website: json["website"],
      );

  @override
  List<Object?> get props => [key, nama, logo];
}

// 6. KELAS LAMARAN
class Lamaran extends Equatable {
  final String key;
  final String status;
  final bool isApply;

  const Lamaran({required this.key, required this.status, required this.isApply});

  factory Lamaran.fromJson(Map<String, dynamic> json) => Lamaran(
        key: json["key"],
        status: json["status"],
        isApply: json["isApply"],
      );

  @override
  List<Object?> get props => [key, status, isApply];
}