import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:proyecto/dtos/usuario.dart';

class UsuarioProvider extends ChangeNotifier{
  final List<Usuario> _listaUsuarios=[];
  UnmodifiableListView<Usuario> get usuariosGetter => UnmodifiableListView(_listaUsuarios);

  void addUsuario(String nombre,int edad, String descripcion,String genero, String imagen){
    Usuario us=Usuario(_listaUsuarios.length+1,nombre, edad, descripcion, genero, imagen);
    _listaUsuarios.add(us);
  }

  void initalizeUsuarios(){

    Usuario u1= Usuario(1,"Javier", 23, "Full stack asdasdashkhdgahsid aw dashdb ahjs dbasjhdb ajskhdb iqwna hdbasd ashdboaud asijd asid ashdb ahjs dbasjhdb ajskhdb iqwna hdbasd ashdboaud asijd asid db iqwna hdbasd ashdboaud asijd asid ashdb ahjs dbasjhdb ajskhdb iqwna hdbasd ashdboaud asijd asid", "Masculino", "https://media.licdn.com/dms/image/D4E03AQEzG20xT26emg/profile-displayphoto-shrink_800_800/0/1690312306731?e=2147483647&v=beta&t=3ulTkz7zhGjADkaDHymceM5h1xJP1BlKdqrWoZ_YXyE");
    Usuario u2=Usuario(2,"Juan", 24, "Back end developer", "Masculino", "https://scontent.fuio5-1.fna.fbcdn.net/v/t31.18172-8/22861746_1480120132057569_5859221830910884783_o.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeHKRdO7cUXDcW0n8TZ1Iv8jjntIhFT2XUGOe0iEVPZdQdm5F5xfCWCHB0s-Htyr0UtmiNCK7PZ8YGeO4hdwIf6-&_nc_ohc=_N02MM4EoNwAX9ib3lf&_nc_ht=scontent.fuio5-1.fna&oh=00_AfAOfqi4MGE_eolLEFQd122rg5KvRSRBdGItbWD9_WtU_Q&oe=6517AC28");
    Usuario u3=Usuario(3,"Juano", 22, "Front end", "Masculino", "https://scontent.fuio5-1.fna.fbcdn.net/v/t39.30808-6/240528460_3843748882393504_793647231228756592_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=a2f6c7&_nc_eui2=AeHKS-8JDYhQ1HaTElQwMCpzlyddapup4qqXJ11qm6niqvF7AX3K_4pTgXTN3Uoxac1eXBfRgejbp55HCduRFAx9&_nc_ohc=iekq3I2-0GEAX_bL_kP&_nc_ht=scontent.fuio5-1.fna&oh=00_AfBIfZTSAjK4VmOKEWY-DYSuVHflCme9wYG-vWlz3dvwHQ&oe=64F50F47");
    Usuario u4=Usuario(4,"Cristian", 21, "Relaciones personales", "Masculino", "https://scontent.fuio5-1.fna.fbcdn.net/v/t39.30808-6/370280819_3165811190387812_1354042009081655656_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=a2f6c7&_nc_eui2=AeHGopc_rr46jY4nEx8OsHd7JDsYz8wnFZgkOxjPzCcVmA6JUZjtlQignq8izj4FmHpOVl_EQfbYJxBMXnJXmmWa&_nc_ohc=F1B5cgUuyB8AX-yxrii&_nc_ht=scontent.fuio5-1.fna&oh=00_AfBXSYb3DSuPFNWb6ZzG5UsfJNKoyqfO_pK7EPYHYMGf8w&oe=64F44916");
    Usuario u5=Usuario(5,"Valery", 22, "UX/UI designer", "Femenino", "");

    _listaUsuarios.add(u1);
    _listaUsuarios.add(u2);
    _listaUsuarios.add(u3);
    _listaUsuarios.add(u4);
    _listaUsuarios.add(u5);
  }
}