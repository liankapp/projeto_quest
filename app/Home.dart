import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  String _data = "Selecione a Data";
 
List<String> itensMenu = ["Configurações", "Deslogar"];

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/");
  }
_escolhaMenuItem(String escolha) {
    switch (escolha) {
      case "Deslogar":
        _deslogarUsuario();
        break;
      case "Configurações":
        break;
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF6404F),
          centerTitle:true,
          title: Text('Criar Nova Tarefa'),
          actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
        ),
         body: Container(
        decoration: BoxDecoration(
          color: Color(0xfffaf4e4),
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child:
                    TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "Tema",
                      ),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child:
                    TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "Área",
                      ),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child:
                    TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "Atividade",
                      ),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child:
                    RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    elevation: 4.0,
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          theme: DatePickerTheme(
                            containerHeight: 210.0,
                          ),
                          showTitleActions: true,
                          minTime: DateTime(1998, 1, 1),
                          maxTime: DateTime(2020, 12, 31), onConfirm: (date) {
                        print('confirme $date');
                        _data = '  ${date.day} - ${date.month} - ${date.year}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.pt);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      " $_data",
                                      style: TextStyle(
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text(
                            "  Data",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child:
                    TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "Descrição",
                      ),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: RaisedButton(
                      child: Text(
                        "Adicionar tarefa",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Color(0xffF6404F),
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      onPressed: (){
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
        
      ),
    //   bottomNavigationBar: BottomNavigationBar(
    //   items: const <BottomNavigationBarItem>[
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home),
    //       title: Text('Home'),
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.business),
    //       title: Text('Business'),
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.school),
    //       title: Text('School'),
    //     ),
    //   ],
    //   currentIndex: _selectedIndex,
    //   selectedItemColor: Colors.amber[800],
    //   onTap: _onItemTapped,
    // ),
  );
  }
}