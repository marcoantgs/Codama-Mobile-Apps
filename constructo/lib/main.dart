import 'package:flutter/material.dart';
import 'components/comodo_user.dart';


main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.brown,
        accentColor: Colors.amber,
      ),
      
    );
  }
}

class MyHomePage extends StatelessWidget {
  

  /*
  _adicionarComodo(String titulo, String descricao){
    final novoComodo = Comodo(
      id:Random().nextDouble().toString(),
      titulo: titulo,
      descricao: descricao
    );
    setState((){

    })
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Constructor')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Container(
              color: Colors.brown,
              height: 130,
              width: double.infinity,
              child: 
              Center(
                child: Text(
                  "Seja bem-vindo(a)!!!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                  )
                
              ),
                 
            ),
            ComodosUser()
           
          ],
        ),
      ),
    );
  }
}
