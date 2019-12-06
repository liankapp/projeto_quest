import 'package:flutter/material.dart';
import 'package:quest/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/helpers/task_helper.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/views/task_dialog.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter_picker/flutter_picker.dart';


class CriarTarefa extends StatefulWidget {
  @override
  _CriarTarefaState createState() => _CriarTarefaState();
}
class _CriarTarefaState extends State<CriarTarefa> {

  TextEditingController _controllerTema = TextEditingController();
  TextEditingController _controllerArea = TextEditingController();
  
  class DatePicker extends StatelessWidget {
  DatePicker({
    this.formatedDate,
    this.selectedDate,
  });

  final String formatedDate;
  final Function selectedDate;
  TimeOfDay _currentTime = new TimeOfDay.now();

  String timeText = 'Set A Time';
  Future<Null> selectTime(BuildContext context) async {
      TimeOfDay selectedTime = await showTimePicker(
        context: context,
        initialTime: _currentTime,
      );

      MaterialLocalizations localizations = MaterialLocalizations.of(context);
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: false);

      if (formattedTime != null) {
        setState(() {
          timeText = formattedTime;
        });
      }
    };

  TextEditingController _controllerAtividades = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();
  String _mensagemErro = "";
  bool _carregando = false;

  _validarCampos(){

    //Preencher campos corretamente
    String tema = _controllerTema.text;
    String area = _controllerArea.text;
    String atividades = _controllerAtividades.text;
    String descricao = _controllerDescricao.text;

    //validar campos
    if( tema.isNotEmpty && tema.contains !=null ){

      if( area.isNotEmpty && area.contains !=null ){

        if ( atividades.isNotEmpty && atividades.contains !=null ){

          if descricao.isNotEmpty && descricao.contains !=null {
            CriarTarefa criartarefa = CriarTarefa();
            criartarefa.tema = criartarefa;
            criartarefa.area = criartarefa;
            criartarefa.atividades = criartarefa;
            criartarefa.descricao = criartarefa;
            _criartarefa( criartarefa );
          }else{
            setState(() {
            _mensagemErro = "Preencha o campo vazio";
          });
      }else{
        setState(() {
          _mensagemErro = "Preencha o campo vazio";
        });
      }
      }else{
        setState(() {
          _mensagemErro = "Preencha o campo vazio";
        });
      }

    }else{
      setState(() {
        _mensagemErro = "Preencha o campo vazio";
      });
    }

  }

  _createtarefa( CriarTarefa criartarefa ){

    setState(() {
      _carregando = true;
    });

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createNewFile(
        tema: criartarefa.tema,
        area: criartarefa.area,
        atividade: criartarefa.atvidade,
        descricao: criartarefa.descricao;
    ).then((firebaseUser){

      _redirecionaPainelPorTipodeTarefa( firebaseUser.user.uid );

    }).catchError((error){
      _mensagemErro = "Erro ao autenticar criar essa tarefa, verifique e tente novamente!";
    });

  }

  _redirecionaPainelPorTipodeTarefa(String idTarefa) async {

    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot = await db.collection("tarefas")
          .document( idTarefas )
          .get();

    Map<String, dynamic> dados = snapshot.data;

    setState(() {
      _carregando = false;
    });
        Navigator.pushReplacementNamed(context, "/Tarefas");
  }


  
class TaskHelper {
  static final TaskHelper _instance = TaskHelper.internal();

  factory TaskHelper() => _instance;

  TaskHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "todo_list.db");

    return openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE task("
          "id INTEGER PRIMARY KEY, "
          "title TEXT, "
          "description TEXT, "
          "isDone INTEGER)");
    });
  }
}

//Adicionar uma nova atividade à tarefa

/*Widget _buildTaskItemSlidable(BuildContext context, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: _buildTaskItem(context, index),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Editar',
          color: ,
          icon: Icons.edit,
          onTap: () {
            _addNewTask(editedTask: _taskList[index], index: index);
          },
        ),
      ],
    );
  } */ 


  