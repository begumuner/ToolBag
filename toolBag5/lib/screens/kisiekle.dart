import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phonebook/databasehelper.dart';
import 'package:phonebook/models/kisi.dart';
import 'package:phonebook/screens/phoneBook.dart';
import 'dart:io';



class KisiEkle extends StatefulWidget {

  @override
  _KisiEkleState createState() => _KisiEkleState();
}

class _KisiEkleState extends State<KisiEkle> {
  var formKey2 = GlobalKey<FormState>();

  DatabaseHelper databaseHelper;
  String kisiAd;
  int kisiNo;
  DateTime tarih;
  File _file;


  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("New Contact"),backgroundColor: Colors.red[400]),

        body: Column(
      children: <Widget>[
        Stack(children: [
          Image.asset(
            _file == null ? "assets/person.jpg" : _file.path,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Positioned(
            bottom: 8,
              right: 8,
              child: IconButton(
            onPressed: getFile,
                        icon: Icon(Icons.camera_alt),
                        color: Colors.white,
                        
                      ))
                    ]),
                     Form(
                      key: formKey2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          //kisi Adi
                          Padding(
                              padding: EdgeInsets.all(20),
                              child: TextFormField(
                                onChanged: (ad) {
                                  kisiAd = ad;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Name',
                                    labelText: 'Name',
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          
            
                          //kisi no
                          
                             Padding(
                              padding: EdgeInsets.all(20),
                              child: TextFormField(
                                onChanged: (no) {
                                  kisiNo = int.parse(no);
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    hintText: 'Phone Number',
                                    labelText: 'Phone Number',
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          
            
                          // TARIHI
                        /*  Padding(
                                padding: EdgeInsets.all(20),
                                child: InkWell(
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2001),
                                            lastDate: DateTime(2023))
                                        .then((t) {
                                      setState(() {
                                        tarih = t;
                                      });
                                    });
                                  },
                                  child: Container(
                                    child: Center(
                                      child: Text(tarih == null
                                          ? 'Tarih Giriniz'
                                          : DateFormat.yMd().format(tarih)),
                                    ),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blueGrey)),
                                  ),
                                )),
                          
                          */
            
                          
            
                          //VAZGEC BUTONU
                          ButtonBar(
                            alignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                child: Text('Cancel'),
                                color: Colors.red[400],
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => KisiEkle()));
                                },
                              ),
            
                              //KAYDET BUTONU
                              RaisedButton(
                                child: Text('Done'),
                                color: Colors.red[400],
                                onPressed: () {
                                  databaseHelper.kisiEkle(Kisi(
                                      kisiAd: kisiAd,
                                      kisiNo: kisiNo,
                                      tarih: tarih.toString(),
                                      ));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => KisiListesi()));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    )
      ],
      ),
                    
                   );
              }
            
            
               void getFile() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _file = image;
    });
  }
}
