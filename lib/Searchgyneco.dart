import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'TABLE.dart';
import 'examen_gyne.dart';

class SearchPatientPage extends StatefulWidget {
  @override
  _SearchPatientPageState createState() => _SearchPatientPageState();
}

class _SearchPatientPageState extends State<SearchPatientPage> {
  final TextEditingController _docIdController = TextEditingController();
  Map<String, dynamic>? _patientData;
  String _errorMessage = '';
  bool _isLoading = false;

  void searchPatient(String docId) {
    setState(() {
      _isLoading = true;
    });

    FirebaseFirestore.instance
        .collection('gynecologique')
        .doc(docId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          _patientData = documentSnapshot.data() as Map<String, dynamic>;
          _errorMessage = '';
          _isLoading = false;
        });
      } else {
        setState(() {
          _patientData = null;
          _errorMessage = 'Patient not found.';
          _isLoading = false;
        });
      }
    }).catchError((error) {
      setState(() {
        _patientData = null;
        _errorMessage = 'Error: $error';
        _isLoading = false;
      });
    });
  }

  // Function to create spaced Text widgets
  Widget spacedText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  // Function to generate widgets based on data structure
  List<Widget> buildPatientInfo(List<Map<String, dynamic>> data) {
    List<Widget> widgets = [];

    for (var group in data) {
      widgets.add(
        Text(
          group['title'] + ':',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );

      for (var field in group['fields']) {
        widgets.add(
          spacedText(field + ':', _patientData?[field] ?? 'N/A'),
        );
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Patient by ID'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _docIdController,
              decoration: InputDecoration(
                labelText: 'Enter Document ID',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    String docId = _docIdController.text.trim();
                    if (docId.isNotEmpty) {
                      searchPatient(docId);
                    } else {
                      setState(() {
                        _errorMessage = 'Please enter a valid Document ID.';
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          if (_isLoading)
            CircularProgressIndicator()
          else if (_errorMessage.isNotEmpty)
            Text(
              _errorMessage,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            )
          else if (_patientData != null)
            Column(
              children: buildPatientInfo([
                {
                  'title': 'Personal Information',
                  'fields': [
                    'nom',
                    'prenom',
                    'dateNaissance',
                    'adresse',
                    'numeroTelephone',
                  ],
                },
                {
                  'title': 'Observation à l\'entrée',
                  'fields': ['motifConsultation', 'ddr', 'termeCalcule'],
                },
                {
                  'title': 'Antécédent',
                  'fields': [
                    'menarchie',
                    'dureed',
                    'ageMariage',
                    'caractereCycle',
                    'contraception',
                  ],
                },
                {
                  'title': 'Obstétricaux',
                  'fields': [
                    'G_AUB_G1',
                    'G_PN_G1',
                    'G_E_G1',
                    'G_AUB_G2',
                    'G_PN_G2',
                    'G_E_G2',
                    'G_AUB_G3',
                    'G_PN_G3',
                    'G_E_G3',
                    'G_AUB_G4',
                    'G_PN_G4',
                    'G_E_G4',
                    'G_AUB_G5',
                    'G_PN_G5',
                    'G_E_G5',
                    'G_AUB_G6',
                    'G_PN_G6',
                    'G_E_G6',
                    'G_AUB_G7',
                    'G_PN_G7',
                    'G_E_G7',
                  ],
                },
                {
                  'title': 'Pathologie',
                  'fields': ['pathologie'],
                },
                {
                  'title': 'Familiaux',
                  'fields': ['paternelle', 'maternelle', 'autre'],
                },
                {
                  'title': 'Examen Générale',
                  'fields': [
                    'poids',
                    'taille',
                    'pouls',
                    'ta',
                    'oedemes',
                    'labstix',
                    'particularites',
                  ],
                },
                {
                  'title': 'Examen obstétricale',
                  'fields': [
                    'hu',
                    'contractionUterine',
                    'presentation',
                    'bcf',
                    'uterus',
                    'speculum',
                    'toucherVaginal',
                  ],
                },
                {
                  'title': 'Examen complémentaire',
                  'fields': [
                    'Examen complémentaire',
                    'groupeSanguin',
                    'fns',
                    'glycemie',
                    'ureeSanguine',
                    'albuminurie',
                    'bw',
                    'serodiagnostixsTaxoplasmose',
                    'serodiagnostixsRubeole'
                  ],
                },
              ]),
              ),
            
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 100.0,
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => gynecologiqueedit(
                      patientId: _docIdController.text,
                    ),
                  ),
                );
              },
              child: Text('Edit'),
            ),
          ),
        ],
      ),
    );
  }
}
