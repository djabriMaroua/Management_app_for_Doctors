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
        .collection('patients')
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
              fontWeight: FontWeight.bold, // Make section title bold
            ),
          ),
          SizedBox(height: 10), // Add spacing below section title
          for (var entry in patientData.entries)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8), // Add space before each entry
                Text(
                  '${entry.key}:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Make key bold
                  ),
                ),
                SizedBox(height: 4), // Add spacing between key and value
                Text('${entry.value}'),
                SizedBox(height: 12), // Add spacing between entries
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

