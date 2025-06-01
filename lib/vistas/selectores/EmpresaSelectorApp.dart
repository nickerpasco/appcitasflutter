import 'package:app_salud_citas/vistas/selectores/models/EmpresaModel.dart';
import 'package:flutter/material.dart';
import 'select_item_dialog.dart';
 

Future<EmpresaModel?> seleccionarEmpresa(
    BuildContext context, List<EmpresaModel> empresas) {
  return showSelectItemDialog<EmpresaModel>(
    context: context,
    title: 'Selecciona una Empresa',
    items: empresas,
    itemBuilder: (context, empresa) => ListTile(
      leading: Icon(empresa.icono, color: Colors.deepPurple),
      title: Text(empresa.nombre),
    ),
  );
}
