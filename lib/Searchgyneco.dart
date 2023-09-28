import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'editPatieny.dart';

class SearchPatientPage extends StatefulWidget {
  @override
  _SearchPatientPageState createState() => _SearchPatientPageState();
}

class _SearchPatientPageState extends State<SearchPatientPage> {
  final TextEditingController _docIdController = TextEditingController();
  Map<String, dynamic>? _patientData;
  String _errorMessage = '';
  bool _isLoading = false;
  
  get docId => null;

  // Function to search for a patient by document ID
  void searchPatient(String docId) {
    setState(() {
      _isLoading = true;
    });

    FirebaseFirestore.instance
        .collection('gynecologique')
        .doc(docId) // Specify the document ID to retrieve
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
          _patientData = null; // Reset patient data if the document does not exist
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
                fontWeight: FontWeight.bold, // Make error message bold
              ),
            )
          else if (_patientData != null)
            PatientDataWidget(
              patientData: _patientData!,
              onEditPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TablePage (patientId: _docIdController.text),
                      
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class PatientDataWidget extends StatelessWidget {
  final Map<String, dynamic> patientData;
  final VoidCallback onEditPressed;

  PatientDataWidget({
    required this.patientData,
    required this.onEditPressed,
  });

  final List<Map<String, dynamic>> displayGroups = [
    {
      'title': 'Personal Information',
      'fields': ['nom', 'prenom', 'dateNaissance','adresse','numeroTelephone'],
    },
    {
      'title': 'Observation à l\'entré',
      'fields': ['motifConsultation', 'ddr', 'termeCalcule'],
    },
    {
      'title':'Antecédent',
      'fields': ['menarchie','dureed','ageMariage','caractereCycle','contraception'],
    },
    {
      'title':'Obstétricaux',
      'fields':['G_AUB_G1','G_PN_G1','G_E_G1','G_AUB_G2','G_PN_G2','G_E_G2','G_AUB_G3','G_PN_G3','G_E_G3','G_AUB_G4','G_PN_G4','G_E_G4','G_AUB_G5','G_PN_G5','G_E_G5','G_AUB_G6','G_PN_G6','G_E_G6','G_AUB_G7','G_PN_G7','G_E_G7'],
    },
    {
      'title':'Pathologie',
      'fields':'pathologie',
    },
    {
       'title':'Familiaux',
      'fields':['paternelle','maternelle','autre'],
    },
    {
      'title':'Examen Générale',
      'fields':['poids','taille','pouls','ta','oedemes','labstix','particularites'],
    },
    { 
      'title':'Examen obstétricale',
      'fields':['hu','contractionUterine','presentation','bcf','uterus','speculum','toucherVaginal',],

    },
    { 
      'title':'Examen complémentaire',
      'fields':['Examen complémentaire', 'groupeSanguin ',
  'fns ',
   ' glycemie ',
 ' ureeSanguine ',
  'albuminurie ',
   ' bw '
    'serodiagnostixsTaxoplasmose '
      ' serodiagnostixsRubeole ']

    },
    // Add other group titles and fields as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patient Data:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          for (var group in displayGroups)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group['title'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                for (var field in group['fields'])
                  if (patientData.containsKey(field))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$field:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${patientData[field]}'),
                        SizedBox(height: 12),
                      ],
                    ),
              ],
            ),
          ElevatedButton(
            onPressed: onEditPressed,
            child: Text('Edit'),
          ),
        ],
      ),
    );
  }
}
