import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerCep = TextEditingController();
  String _resultado = "";



  _recuperarCEP() async{

    /*síncrono = responsta instantanea
      assincrono = aguarda o serve responder
     */
    String cepDigitado = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cepDigitado}/json/";

    http.Response response;

    /*await = aguarda a resposta do server*/
    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];

    setState((){
      _resultado = "${logradouro}";
    });



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo API"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o CEP (sem pontuação)"
              ),
              style: TextStyle(
                fontSize: 20
              ),
              controller: _controllerCep
            ),
           RaisedButton(
             child: Text("Clique !"),
             onPressed: _recuperarCEP,
           ),
        Text(_resultado)
        ],
        ),
      ),
    );
  }
}
