import 'package:flutter/material.dart';
import 'package:quest/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarCampos(){

    //Recuperar dados dos campos
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    //validar campos
    if( nome.isNotEmpty ){

      if( email.isNotEmpty && email.contains("@") ){

        if( senha.isNotEmpty && senha.length > 6 ){

          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;
          _cadastrarUsuario( usuario );

        }else{
          setState(() {
            _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
          });
        }

      }else{
        setState(() {
          _mensagemErro = "Preencha o E-mail válido";
        });
      }

    }else{
      setState(() {
        _mensagemErro = "Preencha o Nome";
      });
    }

  }

  _cadastrarUsuario( Usuario usuario ){

    FirebaseAuth auth = FirebaseAuth.instance;
    Firestore db = Firestore.instance;

    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

      db.collection("usuarios")
          .document( firebaseUser.user.uid )
          .setData( usuario.toMap() );

      //redireciona para o painel, de acordo com o tipoUsuario
      
          Navigator.pushNamedAndRemoveUntil(
              context,
              "/home",
              (_) => false
          );
         
      

    }).catchError((error){
      _mensagemErro = "Erro ao cadastrar usuário, verifique os campos e tente novamente!";
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xfffaf4e4),
          image: DecorationImage(
              image: AssetImage("imagens/fundo.png"),
              fit: BoxFit.cover
          )
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Image.asset(
                      "imagens/Logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child:
                    TextField(
                      controller: _controllerNome,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "Nome completo",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)
                          )
                      ),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child:
                    TextField(
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "e-mail",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)
                          )
                      ),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child:
                    TextField(
                      controller: _controllerSenha,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          hintText: "senha",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)
                          )
                      ),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'Play'),
                      ),
                      color: Color(0xffF6404F),
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      onPressed: (){
                        _validarCampos();
                      }
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(color: Colors.red, fontSize: 20, fontFamily: 'Play'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}