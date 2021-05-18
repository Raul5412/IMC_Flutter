import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IMCStateful(),
    );
  }
}

class IMCStateful extends StatefulWidget{
  @override
  IMCState createState() => IMCState();

}
class IMCState extends State<IMCStateful>{
  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();

  GlobalKey<FormState> formEstado = GlobalKey<FormState>();
  String mensajes = "Bienvenido!!!";
  void reiniciar(){
    peso.text = "";
    altura.text = "";
    setState(() {
      mensajes = "Calcula tu IMC!";
    });
  }

  void calculaImc(){
    setState(() {
      double peso_d = double.parse(peso.text);
      double altura_d = double.parse(altura.text);
      double imc = peso_d / (altura_d * altura_d);
      if(imc<18.5){
        mensajes = "Bajo Peso (tu IMC = ${imc.toStringAsPrecision(3)})";
      }else if(imc>=18.5 && imc<=24.9){
        mensajes = "Peso Normal (tu IMC = ${imc.toStringAsPrecision(3)})";
      }else if(imc>=25 && imc<=29.9){
        mensajes = "Sobrepeso (tu IMC = ${imc.toStringAsPrecision(3)})";
      }else if(imc>=30 && imc<=34.9){
        mensajes = "Obesidad Tipo 1 (tu IMC = ${imc.toStringAsPrecision(3)})";
      }else if(imc>=35 && imc<=39.9){
        mensajes = "Obesidad Tipo 2 (tu IMC = ${imc.toStringAsPrecision(3)})";
      }else if(imc>=40){
        mensajes = "Obesidad Tipo 3 (tu IMC = ${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC APP:"),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: reiniciar,
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Form(
          key: formEstado,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.account_box_outlined, size: 100, color: Colors.deepOrange),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso: ",
                  labelStyle: TextStyle(color: Colors.blueAccent)
                ),
                textAlign: TextAlign.center,
                controller: peso,
                style: TextStyle(color: Colors.deepOrange, fontSize: 30.0),
                validator: (value){
                  if(value.isEmpty){
                    return "Peso vacío";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura: ",
                    labelStyle: TextStyle(color: Colors.blueAccent)
                ),
                textAlign: TextAlign.center,
                controller: altura,
                style: TextStyle(color: Colors.deepOrange, fontSize: 30.0),
                validator: (value){
                  if(value.isEmpty){
                    return "Altura vacía";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 55.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (formEstado.currentState.validate()) {
                        calculaImc();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                mensajes,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )

            ],
          ),
        ),
      ),

    );
  }

}