import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:bucks/src/shared/widgets/flat_button_app.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ReceitaPage extends StatefulWidget {
  @override
  _ReceitaPageState createState() => _ReceitaPageState();
}

class _ReceitaPageState extends State<ReceitaPage> {

  // ReceitaController store;
 
  TextEditingController _tecReceitasQtd = TextEditingController();
  TextEditingController _tecIngredAgua = TextEditingController();
  TextEditingController _tecIngredAcucar = TextEditingController();
  TextEditingController _tecIngredChaVerde = TextEditingController();
  TextEditingController _tecIngredChaArranque = TextEditingController();
  TextEditingController _tecIngredScoby = TextEditingController();
  TextEditingController _tecTotalChaPreparado = TextEditingController();

  // receita - valores pré determinado
  int _qtdAgua = 1000;
  int _qtdAcucar = 80;
  int _qtdChaVerde = 8;
  int _qtdChaArranque = 100;
  int _qtdScoby = 100;

  List toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receita'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: _body()
    );
  }

  _body(){
    return Stack(
      children: <Widget>[
         _imagemFundo(),
        Container(
          padding: EdgeInsets.all(50.0),
          child: Column(
            children: <Widget>[
              _meuTextField(
                pController: _tecReceitasQtd, 
                pLabelText: 'Receita(s)',
                pEnabled: true,
              ),
              _meuTextField(
                pController: _tecIngredAgua, 
                pLabelText: 'Água (ml)',
                pEnabled: false,
              ),
              _meuTextField(
                pController: _tecIngredAcucar, 
                pLabelText: 'Açucar (gr)',
                pEnabled: false,
              ),
              _meuTextField(
                pController: _tecIngredChaVerde, 
                pLabelText: 'Chá (gr)',
                pEnabled: false,
              ),
              _meuTextField(
                pController: _tecIngredChaArranque, 
                pLabelText: 'Chá de Arranque (ml)',
                pEnabled: false,
              ),
              _meuTextField(
                pController: _tecIngredScoby, 
                pLabelText: 'Scoby (gr)',
                pEnabled: false,
              ),

              FlatButtonApp(
                label: 'Calcular',
                onPressed: _botaoCalcular,
              ),
              
              // RaisedButton(
              //   onPressed: _botaoCalcular,
              //   child: Text(
              //     'Calcular',
              //     style: TextStyle(
              //       fontSize: 20,
              //     ),
              //   ),
              // ),

              _meuTextField(
                pController: _tecTotalChaPreparado, 
                pLabelText: 'Chá Preparado(ml)',
                pEnabled: false,
              ),
              

            ],
          ),
        ),
       ],
    );      
  }

  Widget _meuTextField({TextEditingController pController, 
                        String pLabelText,
                        bool pEnabled}) {
    return TextField(
      controller: pController,
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: Colors.white
      ) ,
      decoration: InputDecoration(
        labelText: pLabelText,
        enabled: pEnabled,
        enabledBorder:OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
          ),
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0 ),
      ),
    );      
  }

  Widget _imagemFundo(){
    return Image.asset("images/kombucha1.jpeg",
             fit: BoxFit.cover,
             height: 1000.0,
            );
  }

  void _botaoCalcular(){
    print('<<<_botaoCalcular>>>');

    setState(() {
      var qtd = int.parse(_tecReceitasQtd.text);
      int aux;
      var auxDouble;
      
      aux = qtd * _qtdAgua;
      _tecIngredAgua.text = aux.toString()+'(ml)';
      if (aux >= 1000){
        auxDouble = aux / 1000;
        _tecIngredAgua.text = _tecIngredAgua.text + ' = ' + (auxDouble).toString() + '(lt)'; 
      }

      aux = qtd * _qtdChaVerde;
      _tecIngredChaVerde.text = aux.toString();

      aux = qtd * _qtdAcucar;
      _tecIngredAcucar.text = aux.toString();

      aux = qtd * _qtdChaArranque;
      _tecIngredChaArranque.text = aux.toString();

      aux = qtd * _qtdScoby; 
      _tecIngredScoby.text = aux.toString(); 
      
      // total
      aux = qtd * (_qtdAgua + _qtdChaArranque); 
      _tecTotalChaPreparado.text = aux.toString() + '(ml)';

      if (aux >= 1000){
        auxDouble = aux / 1000;
        _tecTotalChaPreparado.text = _tecTotalChaPreparado.text + ' = ' + (auxDouble).toString() + '(lt)'; 
      }

    });

    print('_tecTotalChaPreparado.text = $_tecTotalChaPreparado.text');

  }

  @override
  void initState(){
    super.initState();
    
    _tecReceitasQtd.text = '1';
     _botaoCalcular();

    readData().then((data){
      setState(() {
        toDoList = json.decode(data);
      });
    });
    
  }

  Future<File> getFile() async {
    // pega o diretorio do meu S.O. 
    final directory = await getApplicationDocumentsDirectory();
    print('diretorio: $directory');
    return File("${directory.path}/receita.json");
  }

  Future<File> saveData() async {
    String data = json.encode(toDoList);
    final file = await getFile();
    return file.writeAsString(data);
  }

  Future<String> readData() async {
    try {
      final file = await getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

}