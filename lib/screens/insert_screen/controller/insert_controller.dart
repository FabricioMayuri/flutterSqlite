import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pruebatecnica/db/db_helper.dart';

class InsertController extends GetxController {
  final dbHelper = DatabaseHelper.instance;

  List<Map<String, dynamic>>? dropTypes;
  String  valueDropdown = '1';
  List<DropdownMenuItem> typesDrop = [];

  //TextControllers
  final TextEditingController controllerPlaca = TextEditingController();
  final TextEditingController controllerKMMantenimiento = TextEditingController();
  final TextEditingController controllerKMAnterior = TextEditingController();

  void updateValueDropdonw (value){
    valueDropdown = value;
    update();
  }

  @override
  void onInit() {
    loadDropTypes();
    super.onInit();    
  }

  loadDropTypes () {
    List<Map<String, dynamic>>? types = Get.arguments;
    if(types != null){
      for (var e in types) {
        typesDrop.add(
          DropdownMenuItem(
            value: e['Id'].toString(),
            child: Text(e['Descripcion'].toString(), style: const TextStyle(fontSize: 13),)
          ),
        );
      }
    } else {
      typesDrop = [];
    }
    update();
  }

  void ingresar () async {
    int? count = await dbHelper.validarPlacaIngresar(placa: controllerPlaca.text);
    count ??= 0;
    if(count == 0){
      await dbHelper.inserCar(
        {
          'idTypeCar': int.parse(valueDropdown),
          'mantenimientoKM': double.parse(controllerKMMantenimiento.text),
          'ultimoKM': double.parse(controllerKMAnterior.text),
          'placa': controllerPlaca.text,
        }
      );
      Get.back(result: 1);
    } else {
      Get.snackbar('Ocurrió un error', 'Ya existe un vehículo con este numero de placa');
    }
  }
}