import 'package:flutter/material.dart';
import 'package:phonebook/models/kisi.dart';
import 'package:phonebook/screens/kisiekle.dart';

import '../databasehelper.dart';

class KisiListesi extends StatefulWidget {
  @override
  _KisiListesiState createState() => _KisiListesiState();
}

class _KisiListesiState extends State<KisiListesi> {
  List<Kisi> tumKisiler;
  DatabaseHelper databaseHelper;

  @override
  initState() {
    super.initState();
    tumKisiler = List<Kisi>();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text('Phone Book'),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[400],
          tooltip: 'New Contact',
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => KisiEkle()));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: FutureBuilder(
        future: databaseHelper.kisiListesiniGetir(),
        builder: (context, AsyncSnapshot<List<Kisi>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            tumKisiler = snapshot.data;
            return tumKisiler.length <= 0
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      //siralama
                      tumKisiler.sort(
                        (Kisi a, Kisi b) => a.kisiAd[0]
                            .toLowerCase()
                            .compareTo(b.kisiAd[0].toLowerCase()),
                      );
                      return ExpansionTile(
                        //isim ilk harfini basa ekleme
                        leading: CircleAvatar(
                          backgroundColor: Colors.red[200],
                          child: Text(
                            tumKisiler[index].kisiAd[0].toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        //baslik
                        title: Text(tumKisiler[index].kisiAd),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 50),
                                      child: Text('Name'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child: Text(tumKisiler[index].kisiAd),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 50),
                                      child: Text('Phone Number'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child: Text(
                                          tumKisiler[index].kisiNo.toString()),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 50),
                                      child: InkWell(
                                          child: Icon(
                                            Icons.delete_forever,
                                            color: Colors.red[400],
                                          ),
                                          onTap: () {
                                            kisiSil(tumKisiler[index].kisiID);
                                          }),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                    itemCount: tumKisiler.length,
                  );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void kisiListesiniGuncelle() {
    databaseHelper.kisiListesiniGetir().then((katList) {
      setState(() {
        tumKisiler = katList;
      });
    });
  }

  void kisiSil(kisiID) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Contact'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Are you sure you want to delete ?'),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Cancel'),
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      child: Text('Delete'),
                      color: Colors.red[400],
                      onPressed: () {
                        databaseHelper.kisiSil(kisiID).then((silinecek) {
                          if (silinecek != 0) {
                            setState(() {
                              kisiListesiniGuncelle();
                              Navigator.pop(context);
                            });
                          }
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
