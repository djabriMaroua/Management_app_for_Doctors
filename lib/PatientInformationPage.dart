import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:mon_doctor/ExamenEntre.dart';
import 'TABLE.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient Information',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PatientInformationPage(),
    );
  }
}

class PatientInformationPage extends StatefulWidget {
  @override
  _PatientInformationPageState createState() => _PatientInformationPageState();
}
void _submitDataToFirestore(
      Map<String, dynamic> patientData, String patientId) {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Define the collection name (assuming "patientsinfo" is your collection name)
      CollectionReference patientsCollection = firestore.collection('patients');

      // Add the patient data to Firestore
      patientsCollection.doc(patientId).set(patientData).then((_) {
        print("Patient information added with ID: ${patientId}");
      }).catchError((error) {
        print("Error adding patient information: $error");
      });
    } catch (e) {
      // Handle any errors that occur during data submission
      print('Error adding data to Firestore: $e');
    }
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
  TextEditingController dureed = TextEditingController();
  TextEditingController ageMariageController = TextEditingController();

  int selectedMenarchie = 8; // Initialize with a default value of 8

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
 Map<String, dynamic> patientData = {};
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
        backgroundColor: Color(0xFF4F3981),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nomController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
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
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
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
                    style:
                    TextStyle(color: Color(0xFF4F3981)), // Set text color
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
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
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
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4F3981), // Set text color
                ),
              ),
              TextFormField(
                controller: motifConsultationController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Motif de consultation'),
                validator: (value) {
                  if (value!.isEmpty) 
                  {
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
                    style:
                        TextStyle(color: Color(0xFF4F3981)), // Set text color
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
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4F3981), // Set text color
                ),
              ),
              TextFormField(
                controller: menarchieController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
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
                    child: Text(
                      option,
                      style:
                          TextStyle(color: Color(0xFF4F3981)), // Set text color
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCaractereCycle = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Caractère du cycle',
                  labelStyle:
                      TextStyle(color: Color(0xFF4F3981)), // Set text color
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez choisir le caractère du cycle';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: dureed,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
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
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4F3981), // Set text color
                ),
              ),
              Wrap(
                spacing: 8,
                children: contraceptionOptions.map((option) {
                  return FilterChip(
                    label: Text(
                      option,
                      style:
                          TextStyle(color: Color(0xFF4F3981)), // Set text color
                    ),
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
                 
      // If the form is valid, update the patientData map with the information
      patientData['nom'] = nomController.text;
      // ... (add other fields to patientData)

      // Save patient information to Firestore
     

      // Navigate to the next page (TableWidget)
      
                    // If the form is valid, update the patientData map with the information
                    patientData['nom'] = nomController.text;
                    patientData['prenom'] = prenomController.text;
                    patientData['dateNaissance'] = dateNaissanceController.text;
                      patientData['adresse']= adresseController.text;
                      patientData ['numeroTelephone']= numeroTelephoneController.text;
                      patientData ['motifConsultation']= motifConsultationController.text;
                      patientData ['ddr']= ddrController.text;
                     patientData [ 'termeCalcule']= termeCalculeController.text;
                      patientData ['menarchie']= menarchieController.text;
                      patientData ['caractereCycle']= selectedCaractereCycle;
                      patientData ['dureed']= dureed.text;
                      patientData ['ageMariage']= ageMariageController.text;
                     patientData  ['contraception']= selectedContraception;
                    
                    String patientId = generatePatientId(nomController.text, prenomController.text);
                     _submitDataToFirestore(patientData,patientId);

                    // Save patient information to Firestore
                     


                    // Navigate to the next page (TableWidget)
                   Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => TablePage(patientId: patientId),
  ),
);
                  },

                child: Text(
                  'Continuer',
                  style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                     ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF4F3981), // Set button color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void savePatientInformation(Map<String, dynamic> patientData) {
    // Replace 'patients' with the name of the collection where you want to store the data
    // 'patients' is just an example, you can use any name for the collection
    CollectionReference patientsCollection =
        FirebaseFirestore.instance.collection('patients');

    patientsCollection.add(patientData).then((value) {
      print("Patient information added with ID: ${value.id}");
    }).catchError((error) {
      print("Error adding patient information: $error");
    });
  }
  
  String generatePatientId(String firstName, String lastName) {
  return '$firstName$lastName';
}
}
