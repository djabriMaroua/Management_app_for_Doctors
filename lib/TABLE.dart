import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ExamenEntre.dart';

class GField {
  String? gNumber; // G number
  String? aub;
  String? pn;
  String? e;
}


class TablePage extends StatefulWidget {
  final String patientId; // Declare the patientId variable as a parameter

  TablePage({required this.patientId}); // Constructor that requires patientId

  @override
  _TablePageState createState() => _TablePageState();
}

// Access patientId using the getter

class _TablePageState extends State<TablePage> {
  String get patientId => widget.patientId;
  final _formKey = GlobalKey<FormState>();
  int? gpcaSelection;
  List<int> gpcaNumbers = List.generate(13, (index) => index + 1);
  List<GField> gFields = [];
  Map<String, dynamic> patientData = {};
  List<String> eOptions = [
    'VBP',
    'MIU',
    'Mort de travail',
    'Mal formation',
    'Autre'
  ];
  String? pathologie;
  String? paternelle;
  String? maternelle;
  String? autre;

  // ... Other fields and functions ...

  // Function to update patientData map
  void updatePatientData(String fieldName, dynamic value) {
    setState(() {
      patientData[fieldName] = value;
    });
  }

  Future<int?> _showGNumberSelectionDialog() async {
    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select G Number'),
          content: DropdownButton<int>(
            value: gpcaNumbers.first, // Default to the first G number
            onChanged: (newValue) {
              Navigator.pop(context, newValue);
            },
            items: gpcaNumbers
                .map((number) => DropdownMenuItem(
                      value: number,
                      child: Text('G$number'),
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Page'),
        backgroundColor: Color(0xFF4F3981),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () async {
                  int? selectedGNumber = await _showGNumberSelectionDialog();

if (selectedGNumber != null) {
  setState(() {
    GField newGField = GField();
    newGField.gNumber = 'G$selectedGNumber';

    gFields.add(newGField);
    updatePatientData('G', selectedGNumber); // Assign the selected G number to the "G" field
  });
}

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4F3981),
                ),
                child: Text(
                  'Add G',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              // Field: GPCA
              if (gpcaSelection != null)
                DropdownButtonFormField<int>(
                  value: gpcaSelection,
                  onChanged: (newValue) {
                    setState(() {
                      gpcaSelection = newValue;
                      updatePatientData('gpcaSelection', newValue);
                    });
                  },
                  items: gpcaNumbers
                      .map((number) => DropdownMenuItem(
                            value: number,
                            child: Text('G$number'),
                          ))
                      .toList(),
                  decoration: InputDecoration(labelText: 'GPCA'),
                ),

              // Dynamic Fields: G
             // Dynamic Fields: G
Column(
  children: gFields.map((gField) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(gField.gNumber!), // Display the G number

        TextFormField(
          onChanged: (value) {
            gField.aub = value; // Associate AUB with the corresponding G number
            updatePatientData('G_AUB_${gField.gNumber}', value);
          },
          decoration: InputDecoration(labelText: 'AUB'),
        ),
        TextFormField(
          onChanged: (value) {
            gField.pn = value; // Associate PN with the corresponding G number
            updatePatientData('G_PN_${gField.gNumber}', value);
          },
          decoration: InputDecoration(labelText: 'PN'),
        ),
        DropdownButtonFormField<String>(
          value: gField.e,
          onChanged: (newValue) {
            setState(() {
              gField.e = newValue;
            });
            updatePatientData('G_E_${gField.gNumber}', newValue); // Associate E with the corresponding G number
          },
          items: eOptions
              .map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
          decoration: InputDecoration(labelText: 'E'),
        ),

        SizedBox(height: 8),
      ],
    );
  }).toList(),
),

                
                 

              SizedBox(height: 16),
              TextFormField(
                onChanged: (value) {
                  updatePatientData('pathologie', value);
                },
                decoration: InputDecoration(labelText: 'Pathologie'),
              ),

              SizedBox(height: 16),

              Text(
                'Familiaux',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              TextFormField(
                onChanged: (value) {
                  updatePatientData('paternelle', value);
                },
                decoration: InputDecoration(labelText: 'Paternelle'),
              ),

              TextFormField(
                onChanged: (value) {
                  updatePatientData('maternelle', value);
                },
                decoration: InputDecoration(labelText: 'Maternelle'),
              ),

              TextFormField(
                onChanged: (value) {
                  updatePatientData('autre', value);
                },
                decoration: InputDecoration(labelText: 'Autre'),
              ),

              ElevatedButton(
                onPressed: () {
                  print(patientData);
                  // Call the function to submit data to Firestore
                  updateDataInFirestore(patientData, patientId);

                  // Navigate to the next page or perform other actions
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExamenEntre(patientId: patientId),
                    ),
                  );
                  // ...
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF4F3981),
                  onPrimary: Colors.white,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to submit data to Firestore
  Future<void> updateDataInFirestore(
      Map<String, dynamic> newData, String documentId) async {
    try {
      // Reference to the Firestore document
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('patients').doc(documentId);

      // Fetch the existing data
      DocumentSnapshot documentSnapshot = await documentReference.get();

      if (documentSnapshot.exists) {
        print("exsiste");
        // Merge the existing data with the new data
        Map<String, dynamic> existingData =
            documentSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> mergedData = {...existingData, ...newData};

        // Update the document with the merged data
        await documentReference.update(mergedData);

        print('Data updated in Firestore for document $documentId');
      } else {
        print('Document with ID $documentId does not exist.');
      }
    } catch (error) {
      print('Error updating data in Firestore: $error');
    }
  }
}
