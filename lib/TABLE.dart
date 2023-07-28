import 'package:flutter/material.dart';
import 'ExamenEntre.dart';

class GField {
  String? annee;
  String? aub;
  String? pn;
  String? e;
}

class TablePage extends StatefulWidget {
  final Map<String, dynamic> patientData;

  TablePage({required this.patientData, required String patientId});

  get patientId => null;

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  int? gpcaSelection;
  List<int> gpcaNumbers = List.generate(13, (index) => index + 1);
  List<GField> gFields = [];

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

  // Function to show the G number selection dialog
  Future<int?> _showGNumberSelectionDialog() async {
    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select G Number'),
          content: DropdownButton<int>(
            value: gpcaSelection,
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
        title: Text(
          'Table Page',
          style: TextStyle(
            color: Colors.white, // Change the color here
          ),
        ),
        backgroundColor: Color(0xFF4F3981),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Field: G Add Button
            ElevatedButton(
              onPressed: () async {
                // Show the G number selection dialog and get the selected number
                int? selectedGNumber = await _showGNumberSelectionDialog();

                if (selectedGNumber != null) {
                  setState(() {
                    gpcaSelection = selectedGNumber;
                    gFields.add(GField());
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
            Column(
              children: gFields.map((gField) {
                return Column(
                  children: [
                    TextField(
                      onChanged: (value) => gField.annee = value,
                      decoration: InputDecoration(labelText: 'Année'),
                    ),
                    TextField(
                      onChanged: (value) => gField.aub = value,
                      decoration: InputDecoration(labelText: 'AUB'),
                    ),
                    TextField(
                      onChanged: (value) => gField.pn = value,
                      decoration: InputDecoration(labelText: 'PN'),
                    ),
                    DropdownButtonFormField<String>(
                      value: gField.e,
                      onChanged: (newValue) {
                        setState(() {
                          gField.e = newValue!;
                        });
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
                setState(() {
                  pathologie = value;
                });
              },
              decoration: InputDecoration(labelText: 'Pathologie'),
            ),

            SizedBox(height: 16),

            // Subtitle: Familiaux
            Text(
              'Familiaux',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // Field: Paternelle
            TextFormField(
              onChanged: (value) {
                setState(() {
                  paternelle = value;
                });
              },
              decoration: InputDecoration(labelText: 'Paternelle'),
            ),

            // Field: Maternelle
            TextFormField(
              onChanged: (value) {
                setState(() {
                  maternelle = value;
                });
              },
              decoration: InputDecoration(labelText: 'Maternelle'),
            ),

            // Field: Autre
            TextFormField(
              onChanged: (value) {
                setState(() {
                  autre = value;
                });
              },
              decoration: InputDecoration(labelText: 'Autre'),
            ),

            ElevatedButton(
              onPressed: () {
                // Navigate to the NextPage and pass the data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExamenEntre(
                      patientId: widget.patientId,
                      gFields: gFields,
                      patientData: {},
                      pathologie: pathologie,
                      paternelle: paternelle,
                      maternelle: maternelle,
                      autre: autre,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF4F3981), // Background color
                onPrimary: Colors.white, // Text color
                padding: EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0), // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Button border radius
                ),
              ),
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
