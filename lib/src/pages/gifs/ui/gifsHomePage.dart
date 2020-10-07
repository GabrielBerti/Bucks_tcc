import 'dart:convert';

import 'package:bucks/src/pages/gifs/ui/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart'; 

class GifsHomePage extends StatefulWidget {
  @override
  _GifsHomePageState createState() => _GifsHomePageState();
}

class _GifsHomePageState extends State<GifsHomePage> {
  
  String _search;
  int _offSet = 0;
 
  // como faz requisicao na net, entao usar o async
  Future<Map>_getGifs() async {
    http.Response response;

    if (_search == null)
      response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=tP1x0iybju8k7OztUZnu5XWY116KSilQ&limit=20&rating=G");
    else
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=tP1x0iybju8k7OztUZnu5XWY116KSilQ&q=$_search&limit=19&offset=$_offSet&rating=G&lang=pt");
    
    return json.decode(response.body);
  }

  @override
  void initState(){
    super.initState();

    _getGifs().then((map){
      // print(map);
      null;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network("https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pesquise aqui",
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                border: OutlineInputBorder()
              ),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
              // chama qdo clica no texto e clica no icone pesquisar do teclado
              onSubmitted: (text){
                setState(() {
                  _search = text;  
                  _offSet = 0;
                });
              },
            ),

          ),
          Expanded(
            child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot){
                switch (snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                        ),
                      );
                      default: 
                        if (snapshot.hasError)
                          return Container();
                        else
                          return _createGifTable(context, snapshot);
                }
              },
          ))

        ],
      ),
      
    );
  }

  Widget _createGifTable(BuildContext contexto, AsyncSnapshot snapshot){
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      // como os itens serao demonstrados na tela
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        ),
      itemCount: _getCount(snapshot.data["data"]),
      // itemCount: snapshot.data["data"].length,
      itemBuilder: (context, index){
        // a cada item que ele imprime, é chamado essa function
        if (_search == null || index < snapshot.data["data"].length)
          return GestureDetector(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage, 
              image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
            // child: Image.network(snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 300.0,
              fit: BoxFit.cover,
            ),
            onTap: (){
              Navigator.push(context, 
                MaterialPageRoute(
                  builder: (context) => GifPage(snapshot.data["data"][index]) )
                  );
            },
            onLongPress: (){
              Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);
            },
          );
        else  
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add,
                    color: Colors.white,
                    size: 70.0,
                  ),
                  Text("Carregar mais...", style: TextStyle(color: Colors.white, fontSize: 22.0),),
                ],
              ),
              onTap: (){
                setState(() {
                  _offSet += 19;
                });
              },
            ),

          );
      },
      );

  }

  int _getCount(List data){
    if (_search == null){
      return data.length;
    } else {
      return data.length + 1;
    }
  }

}