import 'package:app_salud_citas/controllers/paciente_controller.dart';
import 'package:flutter/material.dart';
 

// void main() => runApp(MaterialApp(home: CrearPacienteScreen()));

class CrearPacienteScreen extends StatefulWidget {
  @override
  _CrearPacienteScreenState createState() => _CrearPacienteScreenState();
}

class _CrearPacienteScreenState extends State<CrearPacienteScreen> {
  final PacienteController _controller = PacienteController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.08,
              child: Center(
                child: Icon(
                  Icons.account_circle,
                  size: 300,
                  color: Colors.teal.shade200,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Header
                Row(
                  children: [
                    Image.asset(
                      'assets/ic_back.png',
                      width: 40,
                      height: 40,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        color: const Color(0xFF2E687A),
                        child: const Center(
                          child: Text(
                            'Nuevo usuario',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Form(
                  key: _controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Tipo de documento"),
                                const SizedBox(height: 4),
                                DropdownButtonFormField<String>(
                                  value: _controller.selectedDocType,
                                  onChanged: (value) {
                                    setState(() => _controller.selectedDocType = value!);
                                  },
                                  items: ["DNI", "CE", "Pasaporte"]
                                      .map((e) =>
                                          DropdownMenuItem(value: e, child: Text(e)))
                                      .toList(),
                                  decoration: inputDecoration(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Documento"),
                                const SizedBox(height: 4),
                                TextFormField(
                                  controller: _controller.documentoController,
                                  decoration: inputDecoration(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (_) {}),
                          const Text("No tiene número de documento"),
                        ],
                      ),
                      const SizedBox(height: 12),
                      buildRequiredLabel('Nombre'),
                      TextFormField(
                        controller: _controller.nombreController,
                        decoration: inputDecoration(),
                      ),
                      const SizedBox(height: 12),
                      buildRequiredLabel('Apellidos'),
                      TextFormField(
                        controller: _controller.apellidoController,
                        decoration: inputDecoration(),
                      ),
                      const SizedBox(height: 12),
                      buildRequiredLabel('Teléfono'),
                      Row(
                        children: [
                          DropdownButton<String>(
                            value: _controller.selectedCountryCode,
                            underline: Container(),
                            onChanged: (value) {
                              final country = _controller.countryOptions.firstWhere(
                                  (c) => c['code'] == value);
                              setState(() {
                                _controller.selectedCountryCode = value!;
                                _controller.selectedFlag = country['flag']!;
                              });
                            },
                            items: _controller.countryOptions
                                .map((country) => DropdownMenuItem<String>(
                                      value: country['code'],
                                      child: Text('${country['flag']} ${country['code']}'),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _controller.telefonoController,
                              keyboardType: TextInputType.phone,
                              decoration: inputDecoration(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text('Email'),
                      TextFormField(
                        controller: _controller.emailController,
                        decoration: inputDecoration(hint: 'ejemplo@gmail.com'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),
                      const Text('F. Nacimiento'),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _controller.selectedDia,
                              hint: const Text("Día"),
                              items: List.generate(31, (i) => '${i + 1}')
                                  .map((day) =>
                                      DropdownMenuItem(value: day, child: Text(day)))
                                  .toList(),
                              onChanged: (val) => setState(() => _controller.selectedDia = val),
                              decoration: inputDecoration(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _controller.selectedMes,
                              hint: const Text("Mes"),
                              items: List.generate(12, (i) => '${i + 1}')
                                  .map((month) =>
                                      DropdownMenuItem(value: month, child: Text(month)))
                                  .toList(),
                              onChanged: (val) => setState(() => _controller.selectedMes = val),
                              decoration: inputDecoration(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _controller.selectedAnio,
                              hint: const Text("Año"),
                              items: List.generate(100, (i) => '${DateTime.now().year - i}')
                                  .map((year) =>
                                      DropdownMenuItem(value: year, child: Text(year)))
                                  .toList(),
                              onChanged: (val) => setState(() => _controller.selectedAnio = val),
                              decoration: inputDecoration(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      buildRequiredLabel("Usuario"),
                      TextFormField(
                        controller: _controller.usuarioController,
                        decoration: inputDecoration(),
                      ),
                      const SizedBox(height: 12),
                      buildRequiredLabel("Clave"),
                      TextFormField(
                        controller: _controller.claveController,
                        decoration: inputDecoration(),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _controller.submitForm(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2EF7B7),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Crear paciente'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF83FAD9), width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF83FAD9), width: 1.5),
      ),
    );
  }

  Widget buildRequiredLabel(String label) {
    return RichText(
      text: TextSpan(
        text: '$label ',
        style: const TextStyle(color: Colors.black, fontSize: 16),
        children: const [
          TextSpan(
            text: '*',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ],
      ),
    );
  }
}