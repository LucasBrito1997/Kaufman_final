import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SingleChildScrollView(
          child: Form(
              child: Column(children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF00C853), Color(0xFFB9F6CA)]),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  child: Text(
                    'O que é o',
                    style: TextStyle(
                        fontSize: 60.0,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Align(
                  child: Text(
                    'Oroscópio ?',
                    style: TextStyle(
                        fontSize: 60.0,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            )),
        Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
          child: Column(
            children: <Widget>[
              Align(
                child: Text(
                  "     O oroscópio com câmera fotográfica integrada, vem para incrementar o seu exame físico, da forma que você possa explicar melhor a enfermidade aos seus clientes. Também auxiliar no arquivamento de imagens, viabilizando comparações de avaliações passadas ou futuras , num App simples do seu celular, conectado ao aparelho.",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Align(
                child: Text(
                  "     Desta forma temos a certeza que seu diagnóstico será transmitido com mais clareza e segurança aos clientes, que se sentirão mais tranquilos e protegidos.",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              Align(
                child: Text(
                  "Modo de Usar",
                  style: TextStyle(fontSize: 40, color: Colors.green[900]),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20, left: 8.0, right: 8.0),
          child: Column(
            children: <Widget>[
              Align(
                child: Text(
                  "Para a utilização do aparelho os seguintes passos devem ser seguidos:",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ),
              Align(
                child: ListBody(
                  children: [
                    Text(
                      "1.	Ligue o Aparelho e espere um tempo;",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "2.	Desligue os dados móveis do celular;",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "3.	Verifique se o wi-fi “ESP-32” está disponível;",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "4. Conecete o celular no wi-fi",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "5.	Abra o Aplicativo e clique no botão câmera para ver a imagem;",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "6.	Para tirar a foto aperte o botão localizado perto da câmera e Led;",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "7.	Para ligar o Led acione o botão a esquerda do aparelho;",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "8.	Caso o wi-fi não apareça desligue e ligue novamente.",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ]))), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
