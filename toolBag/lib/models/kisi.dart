class Kisi {
  int kisiID;
  int kisiNo;
  String kisiAd;
  String tarih;

  Kisi({this.kisiAd, this.kisiNo, this.tarih});

  Kisi.withID(
      {this.kisiID,
      this.kisiAd,
      this.kisiNo,
      this.tarih});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["kisiID"] = kisiID;
    map["kisiAd"] = kisiAd;
    map["kisiNo"] = kisiNo;
    map["tarih"] = tarih;


    return map;
  }

  Kisi.fromMap(Map<String, dynamic> map) {
    this.kisiID = map["kisiID"];
    this.kisiNo = map["kisiNo"];
    this.kisiAd = map["kisiAd"];
    this.tarih = map["tarih"];

  }
}
