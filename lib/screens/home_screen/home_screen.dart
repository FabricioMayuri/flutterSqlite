import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pruebatecnica/screens/home_screen/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Mis vehículos'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: GetBuilder<HomeController>(
              id: 'listCars',
              builder: (__) => Column(
                children: [
                  if(__.cars != null)
                  for (var car in __.cars!)
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(top: 20, left: 25),
                      width: size.width - 50,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/placa.png', width: 30),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Placa: ${car['placa']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black.withOpacity(0.57)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(width: 12,),
                                      Image.asset('assets/km.png', width: 19),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Marca: ${car['Descripcion']}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: Colors.black.withOpacity(0.57)
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Kilometraje: ${car['ultimoKM']} Km',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: Colors.black.withOpacity(0.57)
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  child: Image.asset('assets/tacho.png', width: 30),
                                  onPressed: (){
                                    _.deleteCarController(car['idCar']);
                                  }
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                            child: CupertinoButton(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50),
                              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                              child: const Text(
                                'Editar',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                )
                              ),
                              onPressed: (){
                                _.toEdit(car);
                              }
                            ),
                          )
                        ],
                      ),
                    )
                ],
                  
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _.toInsert,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}