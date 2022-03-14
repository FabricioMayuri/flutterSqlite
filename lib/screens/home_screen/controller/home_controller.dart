import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pruebatecnica/api/list_type_car_api.dart';
import 'package:pruebatecnica/db/db_helper.dart';

class HomeController extends GetxController {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>>? types;
  List<Map<String, dynamic>>? cars;

  @override
  void onReady() { 
    super.onReady();
    getTypes();
    getCars();
  }

  void toInsert () async {
    dynamic result = await Get.toNamed('/insert', arguments: types);
    getCars();
    if(result != null){
      Get.snackbar('Vehículo ingresado', 'Se registró correctamente el vehiculo');
    }
  }

  void toEdit (car) async {
    dynamic result = await Get.toNamed('/edit', arguments: {
      'types': types,
      'car': car
    });
    getCars();
    if(result != null){
      Get.snackbar('Vehículo actualizado', 'Se actualizó correctamente el vehiculo');
    }
  }

  void getTypes() async {

    types = await dbHelper.queryAllRowsTypeCar();
    if(types!.isEmpty){
      List<dynamic>? inserttypes = await listTypeCarApi();
      if(inserttypes != null){
        for (var row in inserttypes) {
          await dbHelper.inserTypeCar(row);
        }
        types = await dbHelper.queryAllRowsTypeCar();
      } else {
        Get.snackbar('Ocurrió un error', 'Error al consultar');
      }
    }
  }

  void getCars() async {
    cars = await dbHelper.queryAllRowsCar();
    update(['listCars']);
  }

  void deleteCarController(int id) {
    Get.dialog(
      AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('¿Seguro que desea eliminar este vehículo?'),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30,
                  width: 75,
                  child: CupertinoButton(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50),
                    padding: EdgeInsets.zero,
                    child: const Text('No'),
                    onPressed: () async {
                      Get.back();
                    }
                  ),
                ),
                const SizedBox(width: 10,),
                SizedBox(
                  height: 30,                  
                  width: 75,
                  child: CupertinoButton(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                    padding: EdgeInsets.zero,
                    child: const Text('Sí'),
                    onPressed: () async {
                      await dbHelper.deleteCar(id);
                      Get.back();
                      Get.snackbar('Se eliminó', 'El vehículo fue removido de forma correcta');
                      getCars();
                    }
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}