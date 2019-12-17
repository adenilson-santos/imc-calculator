import 'package:flutter/material.dart';

void main () {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  
  String _calcResult = 'Informe seus dados!';

  void _resetFields () {
    weightController.text = '';
    heightController.text = '';

    setState(() {
      _calcResult = 'Informe seus dados!';
    });
  }

  void _calculate () {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if(imc < 18.6) {
        _calcResult = 'Abaixo do Peso! (${imc.toStringAsPrecision(4)})';
      } else {
        _calcResult = 'Tanto faz.';
      }
    });
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC Calculator'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields,)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          Icon(Icons.person, size: 100.0, color: Colors.deepPurple),
          TextFormField(
            keyboardType: TextInputType.number, 
            decoration: InputDecoration(
              labelText: 'Weight (kg)', 
              labelStyle: TextStyle(color: Colors.deepPurple)
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
            controller: weightController,
            validator: (value) {
              if(value.isEmpty) {
                return 'Insira seu peso!';
              }
            }
          ),
          TextFormField(
            keyboardType: TextInputType.number, 
            decoration: InputDecoration(
              labelText: 'Height (cm)', 
              labelStyle: TextStyle(color: Colors.deepPurple)
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.deepPurple, fontSize: 25.0),
            controller: heightController,
            validator: (value) {
              if(value.isEmpty) {
                return 'Insira sua altura!';
              }
            }
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
            child: Container (
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    return _calculate();
                  }
                },
                child: Text('Calculate', style: TextStyle(color: Colors.white, fontSize: 25.0)),
                color: Colors.deepPurple
              ),
            ),),
          Text(
            _calcResult,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.deepPurple)
          )
        ],),),
      )
    );
  }
}