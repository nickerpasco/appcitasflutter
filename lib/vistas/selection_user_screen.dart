import 'dart:convert';

import 'package:app_salud_citas/models/LoginResponse.dart';
import 'package:app_salud_citas/utils/UIHelper.dart';
import 'package:app_salud_citas/vistas/selectores/EmpresaSelectorApp.dart';
import 'package:app_salud_citas/vistas/selectores/models/EmpresaModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import 'main_screen.dart';

class SelectionUserScreen extends StatefulWidget {
  const SelectionUserScreen({super.key});

  @override
  State<SelectionUserScreen> createState() => _SelectionUserScreenState();
}

class _SelectionUserScreenState extends State<SelectionUserScreen> {
  EmpresaModel? empresaSeleccionada;

  


  // This will hold the user data after loading from SharedPreferences
  LoginResponse? userData;

  @override
  void initState() {
    super.initState();
  
  }

  // Method to load user data from SharedPreferences
  Future<List<EmpresaModel>> _loadEmpresas() async {


  List<EmpresaModel> empresas = []; 

    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('user_data');
    if (json != null) {
      setState(() {
        userData = LoginResponse.fromJson(jsonDecode(json));


    // var todasLasEmpresas = userData?.data?.pacienteEmpresa
    // ?.where((p) => p.empresa != null)
    // .expand((p) => p.empresa!)
    // .toList();

      
// Iterar sobre la lista de empresas recibidas del backend
        // for (var i = 0; i < userData.data.pacienteEmpresa.empresa.length; i++) {
        //   var empresa = userData.data.pacienteEmpresa.empresa[i];

          
        // }


      userData?.data?.pacienteEmpresa?.forEach((pacienteEmpresa) {
        var idnegocio = pacienteEmpresa.empresa?.idUneg;
        var razonSocial = pacienteEmpresa.empresa?.razonSocial;
        // print('Empresa: $razonSocial');


        empresas.add(
          EmpresaModel(
             int.parse('$idnegocio'), // puedes usar el índice como ID temporal
            'Empresa : $razonSocial',
            Icons.business, // puedes cambiar el ícono según algún campo si deseas
          ),
        );

      });

   

  


      });
    }

    return empresas;
  }

 

  // Method to handle selecting an empresa
  Future<void> _seleccionarEmpresa() async {

//  final List<EmpresaModel> empresas = [
//     EmpresaModel(1, 'GlobalTech', Icons.business),
//     EmpresaModel(2, 'InnovaCorp', Icons.lightbulb),
//     EmpresaModel(3, 'BioHealth', Icons.local_hospital),
//     EmpresaModel(4, 'GreenEnergy', Icons.bolt),
//     EmpresaModel(5, 'SoftSolutions', Icons.devices),
//   ];

 List<EmpresaModel> empresas = await _loadEmpresas();


    final seleccion = await seleccionarEmpresa(context, empresas);
    if (seleccion != null) {
      setState(() {
        empresaSeleccionada = seleccion;
      });

      // Navigate to the MainScreen after selecting empresa
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.60;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          SizedBox.expand(
            child: Image.asset(
              'assets/selectionuserNew.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset('assets/drLink.png', height: 80),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: SizedBox(
                      width: buttonWidth,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Show maintenance message for doctors
                          UIHelper.mostrarMensaje(context, "En mantenimiento");
                        },
                        icon: Image.asset(
                          'assets/iconDoctor.png',
                          height: 40,
                          width: 40,
                        ),
                        label: const Text('DOCTOR'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6EE4A3),
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFF6EE4A3)),
                          minimumSize: const Size.fromHeight(40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: buttonWidth,
                      child: ElevatedButton.icon(
                        onPressed: _seleccionarEmpresa,
                        icon: Image.asset(
                          'assets/iconPaciente.png',
                          height: 40,
                          width: 40,
                        ),
                        label: const Text('PACIENTE'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF26A69A),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
