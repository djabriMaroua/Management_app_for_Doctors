import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PatientInformationPage extends StatefulWidget {
  @override
  _PatientInformationPageState createState() => _PatientInformationPageState();
}

class _PatientInformationPageState extends State<PatientInformationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController dateNaissanceController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController numeroTelephoneController = TextEditingController();
  TextEditingController motifConsultationController = TextEditingController();
  TextEditingController ddrController = TextEditingController();
  TextEditingController termeCalculeController = TextEditingController();
  TextEditingController menarchieController = TextEditingController();
  TextEditingController dureeReglesController = TextEditingController();
  TextEditingController ageMariageController = TextEditingController();

  List<String> caractereCycleOptions = ['Régulier', 'Irégulier'];
  String selectedCaractereCycle = 'Régulier'; // Initialize with a default value

  List<String> contraceptionOptions = [
    'Naturelle',
    'Obstropiogestatif',
    'Microprogestatif',
    'DIU',
    'Implant'
  ];
  List<String> selectedContraception = [];

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != dateNaissanceController.text) {
      setState(() {
        final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        dateNaissanceController.text = formattedDate;
      });
    }
  }

  Future<void> _selectDDR(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != ddrController.text) {
      setState(() {
        final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        ddrController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SERVICE DE GYNECOLOGIE OBSTETRIQUE"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nomController,
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le nom du patient';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: prenomController,
                decoration: InputDecoration(labelText: 'Prénom'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le prénom du patient';
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: () => _selectDateOfBirth(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dateNaissanceController,
                    decoration: InputDecoration(labelText: 'Date de naissance'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Veuillez entrer la date de naissance du patient';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              TextFormField(
                controller: adresseController,
                decoration: InputDecoration(labelText: 'Adresse'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer l\'adresse du patient';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: numeroTelephoneController,
                decoration: InputDecoration(labelText: 'Numéro de téléphone'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le numéro de téléphone du patient';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                "Observation à l'entrée",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: motifConsultationController,
                decoration: InputDecoration(labelText: 'Motif de consultation'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le motif de consultation';
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: () => _selectDDR(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: ddrController,
                    decoration: InputDecoration(labelText: 'DDR'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Veuillez entrer la date de dernières règles';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              TextFormField(
                controller: termeCalculeController,
                decoration: InputDecoration(labelText: 'Terme calculé'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le terme calculé';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                "Antécédents",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: menarchieController,
                decoration: InputDecoration(labelText: 'Menarchie'),
                validator: (value) {
                  final int menarchie = int.tryParse(value!) ?? 0;
                  if (menarchie < 8 || menarchie > 18) {
                    return 'Veuillez entrer une valeur entre 8 et 18';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              DropdownButtonFormField<String>(
                value: selectedCaractereCycle,
                items: caractereCycleOptions.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCaractereCycle = newValue!;
                  });
                },
                decoration: InputDecoration(labelText: 'Caractère du cycle'),
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez choisir le caractère du cycle';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: dureeReglesController,
                decoration: InputDecoration(labelText: 'Durée des règles'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer la durée des règles';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: ageMariageController,
                decoration: InputDecoration(labelText: 'Âge du mariage'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer l\'âge du mariage';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                "Contraception",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8,
                children: contraceptionOptions.map((option) {
                  return FilterChip(
                    label: Text(option),
                    selected: selectedContraception.contains(option),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedContraception.add(option);
                        } else {
                          selectedContraception.remove(option);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save the patient information to the database
                    // Implement your data storage logic here.
                    // For example, you can use Firebase Firestore or other database solutions.
                    // You can access the entered information using the controller values.
                    // For instance, nomController.text will give you the value of the "Nom" field.
                    // selectedContraception will give you the selected contraception options.

                    // Reset the form after submission
                    _formKey.currentState?.reset();

                    selectedContraception.clear();

                    // Show a success message or navigate to the next screen.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Patient information saved!')),
                    );
                  }
                },
                child: Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
