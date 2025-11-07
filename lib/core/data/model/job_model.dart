
import 'dart:convert';

class JobModel {
    final Meta meta;
    final dynamic permission;
    final List<Datum> data;
    final dynamic other;

    JobModel({
        required this.meta,
        required this.permission,
        required this.data,
        required this.other,
    });

    factory JobModel.fromRawJson(String str) => JobModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        meta: Meta.fromJson(json["meta"]),
        permission: json["permission"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        other: json["other"],
    );

    Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "permission": permission,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "other": other,
    };
}

class Datum {
    final Pekerjaan pekerjaan;
    final Perusahaan perusahaan;

    Datum({
        required this.pekerjaan,
        required this.perusahaan,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        pekerjaan: Pekerjaan.fromJson(json["pekerjaan"]),
        perusahaan: Perusahaan.fromJson(json["perusahaan"]),
    );

    Map<String, dynamic> toJson() => {
        "pekerjaan": pekerjaan.toJson(),
        "perusahaan": perusahaan.toJson(),
    };
}

class Pekerjaan {
  final String key;
  final String nama;
  final String jenis; // <-- DIUBAH
  final String lokasi; // <-- DIUBAH
  final int minimalGaji;
  final int maksimalGaji;
  final Tipe tipe; // Biarkan (ini benar)
  final WorkType workType; // Biarkan (ini benar)
  final Kategori kategori; // Biarkan (ini benar)
  final String minimalPendidikan;
  final String minimalPengalaman;
  final String minimalUmur;
  final String createdAt; // <-- DIUBAH
  final String updatedAt; // <-- DIUBAH
  final bool isApply;

  Pekerjaan({
    required this.key,
    required this.nama,
    required this.jenis, // <-- DIUBAH
    required this.lokasi, // <-- DIUBAH
    required this.minimalGaji,
    required this.maksimalGaji,
    required this.tipe,
    required this.workType,
    required this.kategori,
    required this.minimalPendidikan,
    required this.minimalPengalaman,
    required this.minimalUmur,
    required this.createdAt, // <-- DIUBAH
    required this.updatedAt, // <-- DIUBAH
    required this.isApply,
  });

  factory Pekerjaan.fromRawJson(String str) =>
      Pekerjaan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  // Bagian factory ini SANGAT PENTING untuk diubah
  factory Pekerjaan.fromJson(Map<String, dynamic> json) => Pekerjaan(
        key: json["key"] ?? '', 
        nama: json["nama"] ?? '',
        jenis: json["jenis"] ?? '', // <-- DIUBAH (langsung ambil String)
        lokasi: json["lokasi"] ?? '', // <-- DIUBAH (langsung ambil String)
        minimalGaji: json["minimalGaji"] ?? 0,
        maksimalGaji: json["maksimalGaji"] ?? 0,
        tipe: tipeValues.map[json["tipe"]]?? Tipe.PARTIME, // Biarkan
        workType: workTypeValues.map[json["work_type"]]?? WorkType.WFO, // Biarkan
        kategori: kategoriValues.map[json["kategori"]] ?? Kategori.KOMPUTER_IT, // Biarkan
        minimalPendidikan: json["minimalPendidikan"] ?? '',
        minimalPengalaman: json["minimalPengalaman"] ?? '',
        minimalUmur: json["minimalUmur"] ?? '',
        createdAt: json["created_at"] ?? '', // <-- DIUBAH (langsung ambil String)
        updatedAt: json["updated_at"] ?? '', // <-- DIUBAH (langsung ambil String)
        isApply: json["isApply"] ?? false,
      );

  // Kita juga ubah toJson agar sesuai
  Map<String, dynamic> toJson() => {
        "key": key,
        "nama": nama,
        "jenis": jenis, // <-- DIUBAH
        "lokasi": lokasi, // <-- DIUBAH
        "minimalGaji": minimalGaji,
        "maksimalGaji": maksimalGaji,
        "tipe": tipeValues.reverse[tipe],
        "work_type": workTypeValues.reverse[workType],
        "kategori": kategoriValues.reverse[kategori],
        "minimalPendidikan": minimalPendidikan,
        "minimalPengalaman": minimalPengalaman,
        "minimalUmur": minimalUmur,
        "created_at": createdAt, // <-- DIUBAH
        "updated_at": updatedAt, // <-- DIUBAH
        "isApply": isApply,
      };
}


enum Kategori {
    DESIGN,
    KOMPUTER_IT,
    MARKETING,
    OPERATIONS
}

final kategoriValues = EnumValues({
    "Design": Kategori.DESIGN,
    "Komputer & IT": Kategori.KOMPUTER_IT,
    "Marketing": Kategori.MARKETING,
    "Operations": Kategori.OPERATIONS
});



enum Tipe {
    FULLTIME,
    KONTRAK,
    MAGANG,
    PARTIME
}

final tipeValues = EnumValues({
    "Fulltime": Tipe.FULLTIME,
    "Kontrak": Tipe.KONTRAK,
    "Magang": Tipe.MAGANG,
    "Partime": Tipe.PARTIME
});

enum WorkType {
    HYBRID,
    WFH,
    WFO
}

final workTypeValues = EnumValues({
    "Hybrid": WorkType.HYBRID,
    "WFH": WorkType.WFH,
    "WFO": WorkType.WFO
});

class Perusahaan {
  final String key;
  final String nama; // <-- DIUBAH
  final String logo;

  Perusahaan({
    required this.key,
    required this.nama, // <-- DIUBAH
    required this.logo,
  });

  factory Perusahaan.fromRawJson(String str) =>
      Perusahaan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  // Bagian factory ini SANGAT PENTING untuk diubah
  factory Perusahaan.fromJson(Map<String, dynamic> json) => Perusahaan(
        key: json["key"],
        nama: json["nama"], // <-- DIUBAH (langsung ambil String)
        logo: json["logo"],
      );

  // Kita juga ubah toJson agar sesuai
  Map<String, dynamic> toJson() => {
        "key": key,
        "nama": nama, // <-- DIUBAH
        "logo": logo,
      };
}


class Meta {
    final int currentPage;
    final String firstPageUrl;
    final int from;
    final int lastPage;
    final String lastPageUrl;
    final String nextPageUrl;
    final String path;
    final int perPage;
    final dynamic prevPageUrl;
    final int to;
    final int total;

    Meta({
        required this.currentPage,
        required this.firstPageUrl,
        required this.from,
        required this.lastPage,
        required this.lastPageUrl,
        required this.nextPageUrl,
        required this.path,
        required this.perPage,
        required this.prevPageUrl,
        required this.to,
        required this.total,
    });

    factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        // --- TAMBAHKAN '?? 0' DI SEMUA INT ---
        currentPage: json["current_page"] ?? 0,
        firstPageUrl: json["first_page_url"] ?? '',
        from: json["from"] ?? 0,
        lastPage: json["last_page"] ?? 0,
        lastPageUrl: json["last_page_url"] ?? '',
        nextPageUrl: json["next_page_url"] ?? '',
        path: json["path"] ?? '',
        perPage: json["per_page"] ?? 0,
        prevPageUrl: json["prev_page_url"], // prevPageUrl boleh null (karena 'dynamic')
        to: json["to"] ?? 0,
        total: json["total"] ?? 0,
      );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
