import 'package:flutter/material.dart';
import 'package:phonebook/screens/anasayfa.dart';
import 'package:math_expressions/math_expressions.dart';


class HesapMakinesi extends StatefulWidget {
  @override
  _HesapMakinesiState createState() => _HesapMakinesiState();
}

class _HesapMakinesiState extends State<HesapMakinesi> {
  String denklem = "0";
  String sonuc = "0";
  String expression = "";
  double denklemFontSize = 35.0;
  double sonucFontSize = 45.0;

  buttonPressed(String buttonText) {
    setState(() {
      //C'ye basarsan hepsini 0 la sil e basarsan sondan eksilt
      if (buttonText == "C") {
        denklem = "0";
        sonuc = "0";
        
      } else if (buttonText == "⌫") {
        denklem = denklem.substring(0, denklem.length - 1);
        //hicbir sey kalmadiysa 0 yazdir denklem yerine
        if (denklem == "") {
          denklem = "0";
        }
      } else if (buttonText == "=") {
        denklemFontSize = 35.0;
        sonucFontSize = 45.0;

        //butonlari kodun anlamasini sagladik
        expression = denklem;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        //kutuphanemiz
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          sonuc = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          sonuc = "Error";
        }
      } else {
        denklemFontSize = 45.0;
        sonucFontSize = 3.0;
        if (denklem == "0") {
          denklem = buttonText;
        } else {
          denklem = denklem + buttonText;
        }
      }
    });
  }

      //tasarim
      //kendi widgetimi yazdim butun butonlarda esit bir sekilde olmasi icin
  Widget benimButonum( String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text('Calculator'),
        //geri don butonu icin
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            );
          },
        ),
      ),

      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(10),
            //en yukari
            child: Text(
              denklem,
              style: TextStyle(fontSize: denklemFontSize),
            ),
          ),
           //2. satiri
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              sonuc,
              style: TextStyle(fontSize: sonucFontSize),
            ),
          ),
          //kod asagi tasmasin diye
          Expanded(
            child: Divider(),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //sol taraf
                Container(
                  width: MediaQuery.of(context).size.width * .77,
                  child: Table(
                    children: [
                      TableRow(children: [
                        benimButonum("C", 1.1, Colors.red[400]),
                        benimButonum("⌫", 1.1, Colors.red[200]),
                        benimButonum("÷", 1.1, Colors.red[200]),
                      ]),
                      TableRow(children: [
                        benimButonum("7", 1.1, Colors.black54),
                        benimButonum("8", 1.1, Colors.black54),
                        benimButonum("9", 1.1, Colors.black54),
                      ]),
                      TableRow(children: [
                        benimButonum("4", 1.1, Colors.black54),
                        benimButonum("5", 1.1, Colors.black54),
                        benimButonum("6", 1.1, Colors.black54),
                      ]),
                      TableRow(children: [
                        benimButonum("1", 1.1, Colors.black54),
                        benimButonum("2", 1.1, Colors.black54),
                        benimButonum("3", 1.1, Colors.black54),
                      ]),
                      TableRow(children: [
                        benimButonum(".", 1.1, Colors.black54),
                        benimButonum("0", 1.1, Colors.black54),
                        benimButonum("00", 1.1, Colors.black54),
                      ]),
                    ],
                  ),
                ),

                //sag taraf
                Container(
                  width: MediaQuery.of(context).size.width * 0.23,
                  child: Table(
                    children: [
                      TableRow(children: [
                        benimButonum("×", 1.1, Colors.red[200]),
                      ]),
                      TableRow(children: [
                        benimButonum("-", 1.1, Colors.red[200]),
                      ]),
                      TableRow(children: [
                        benimButonum("+", 1.1, Colors.red[200]),
                      ]),
                      TableRow(children: [
                        benimButonum("=", 2.2, Colors.red[400]),
                      ]),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),

      
    );

    
    
  }
}
