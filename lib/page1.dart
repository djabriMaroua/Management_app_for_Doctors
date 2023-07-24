import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final CollectionReference patientCollection =
      FirebaseFirestore.instance.collection('patient');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _numeroTelephoneController =
      TextEditingController();
  List<String> _selectedMotifs = [];
  DateTime? _selectedDate;

  List<String> consultationOptions = ['Gynécologique', 'Obstétrical'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      addPatientToFirestore();
    }
  }

  Future<void> addPatientToFirestore() async {
    try {
      await patientCollection.add({
        'Nom': _nomController.text,
        'Prenom': _prenomController.text,
        'Adresse': _adresseController.text,
        'Numero de telephone': _numeroTelephoneController.text,
        'Motif de consultation': _selectedMotifs,
        'Date des dernieres regles': _selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
            : null,
      });
      print('Patient added successfully!');
    } catch (e) {
      print('Error adding patient: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF4F3981), // Set the color to 4F3981
            colorScheme: ColorScheme.light(
              primary: Color(0xFF4F3981), // Set the color to 4F3981
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF4F3981), // Set the primary color to 4F3981
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF4F3981), // Set the color to 4F3981
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Patient',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF4F3981),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nomController,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    labelStyle: TextStyle(color: Color(0xFF4F3981)), // Set the color to 4F3981
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4F3981)), // Set the color to 4F3981
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _prenomController,
                  decoration: InputDecoration(
                    labelText: 'Prenom',
                    labelStyle: TextStyle(color: Color(0xFF4F3981)), // Set the color to 4F3981
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4F3981)), // Set the color to 4F3981
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _adresseController,
                  decoration: InputDecoration(
                    labelText: 'Adresse',
                    labelStyle: TextStyle(color: Color(0xFF4F3981)), // Set the color to 4F3981
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4F3981)), // Set the color to 4F3981
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _numeroTelephoneController,
                  decoration: InputDecoration(
                    labelText: 'Numero de telephone',
                    labelStyle: TextStyle(color: Color(0xFF4F3981)), // Set the color to 4F3981
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF4F3981)), // Set the color to 4F3981
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'Motifs de consultation:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F3981), // Set the color to 4F3981
                  ),
                ),
                SizedBox(height: 8.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: consultationOptions.length,
                  itemBuilder: (context, index) {
                    final option = consultationOptions[index];
                    return CheckboxListTile(
                      title: Text(
                        option,
                        style: TextStyle(color: Color(0xFF4F3981)), // Set the color to 4F3981
                      ),
                      value: _selectedMotifs.contains(option),
                      onChanged: (value) {
                        setState(() {
                          if (value != null && value) {
                            _selectedMotifs.add(option);
                          } else {
                            _selectedMotifs.remove(option);
                          }
                        });
                      },
                    );
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'Date des dernières règles:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F3981), // Set the color to 4F3981
                  ),
                ),
                SizedBox(height: 8.0),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Select a date',
                      labelStyle: TextStyle(color: Color(0xFF4F3981)), // Set the color to 4F3981
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4F3981)), // Set the color to 4F3981
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF4F3981)), // Set the color to 4F3981
                      ),
                    ),
                    child: Text(
                      _selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                          : 'Select a date',
                      style: TextStyle(color: Color(0xFF4F3981)), // Set the color to 4F3981
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
