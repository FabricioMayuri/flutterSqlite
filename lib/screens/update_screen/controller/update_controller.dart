import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pruebatecnica/db/db_helper.dart';

class UpdateController extends GetxController {
  final dbHelper = DatabaseHelper.instance;

  List<Map<String, dynamic>>? dropTypes;
  String  valueDropdown = '1';
  List<DropdownMenuItem> typesDrop = [];
  int _idCarro = 0;

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
    loadData();
    super.onInit();    
  }

  loadData () {
    Map<String, dynamic>? car = Get.arguments['car'];
    if(car != null){
      controllerPlaca.text = car['placa'].toString();
      controllerKMMantenimiento.text = car['mantenimientoKM'].toString();
      controllerKMAnterior.text = car['ultimoKM'].toString();
      valueDropdown = car['idTypeCar'].toString();
      _idCarro = car['idCar'];
    } else {
      Get.back();
    }
    update();
  }

  loadDropTypes () {
    List<Map<String, dynamic>>? types = Get.arguments['types'];
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

  void guardar () async {
    int? count = await dbHelper.validarPlacaEditar(placa: controllerPlaca.text, id: _idCarro);
    count ??= 0;
    if(count == 0){
      await dbHelper.updateCar(
        {
          'idCar': _idCarro,
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