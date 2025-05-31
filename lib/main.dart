
import 'package:app_salud_citas/providers/EspecialidadProvider.dart';
import 'package:app_salud_citas/providers/anamnesis_provider.dart';
import 'package:app_salud_citas/providers/cliente_foto_provider.dart';
import 'package:app_salud_citas/providers/procedimiento_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_salud_citas/vistas/NewLoginScreen.dart';
import 'package:app_salud_citas/providers/login_provider.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async {

  
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es', null);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => EspecialidadProvider()),
        ChangeNotifierProvider(create: (_) => AnamnesisProvider()),
        ChangeNotifierProvider(create: (_) => ProcedimientoProvider()),
        ChangeNotifierProvider(create: (_) => ClienteFotoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Principal',
      home: const NewLoginScreen(),
    );
  }
}
