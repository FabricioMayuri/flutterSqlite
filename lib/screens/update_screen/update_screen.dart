import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pruebatecnica/screens/update_screen/controller/update_controller.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    return GetBuilder<UpdateController>(
      init: UpdateController(),
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Editar Vehículo'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.3)
                  )
                ],
                borderRadius: BorderRadius.circular(15)
              ),
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 20),
              width: size.width - 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: Text(
                      'Selecciona tu marca',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.black.withOpacity(0.57)
                      ),
                    ),
                  ),
                  const SizedBox(height: 6,),
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<dynamic>(
                        value: _.valueDropdown,
                        onChanged: (value){
                          _.updateValueDropdonw(value);
                        },
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        items: _.typesDrop,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6,),
                  Row(
                    children: [
                      Image.asset('assets/placa.png', width: 30),
                      const SizedBox(width: 6,),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                          ),
                          controller: _.controllerPlaca,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            label: const Text(
                              'Ingresa tu placa',
                            ),
                            floatingLabelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.57),
                              fontSize: 17.5
                            ),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6,),
                  Row(
                    children: [
                      Image.asset('assets/km.png', width: 30),
                      const SizedBox(width: 6,),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                          ),
                          keyboardType: TextInputType.number,
                          controller: _.controllerKMMantenimiento,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            label: const Text(
                              'Cada cuantos KM haces mantenimiento',
                            ),
                            floatingLabelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.57),
                              fontSize: 17.5
                            ),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6,),
                  Row(
                    children: [
                      Image.asset('assets/km.png', width: 30),
                      const SizedBox(width: 6,),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                          ),
                          keyboardType: TextInputType.number,
                          controller: _.controllerKMAnterior,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            label: const Text(
                              'Kilometraje del último mantenimiento',
                            ),
                            floatingLabelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.57),
                              fontSize: 17.5
                            ),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: size.width - 30,
          height: 45,
          child: CupertinoButton(
            color: Colors.pink,
            onPressed: _.guardar,
            padding: EdgeInsets.zero,
            child: const Center(child: Text("Guardar cambios")),
          ),
        ),
      ),
    );
  }
}