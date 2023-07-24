import 'package:flutter/material.dart';

import 'ExamenEntre.dart';

class TableWidget extends StatefulWidget {final Map<String, dynamic> patientData;

  TableWidget({required this.patientData});

  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  TextEditingController pathologiquesController = TextEditingController();
  // Create a list of TextEditingController for each cell in the table
  List<List<TextEditingController>> controllers = List.generate(
    10,
    (_) => List.generate(8, (_) => TextEditingController()),
  );

  String selectedFamiliauxOption =
      "Maternelle"; // Default value for Familiaux option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Example'),
        backgroundColor: Color(0xFF4F3981),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2),
                  4: FlexColumnWidth(2),
                  5: FlexColumnWidth(2),
                  6: FlexColumnWidth(2),
                  7: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Année'))),
                      TableCell(
                          child: Center(child: Text('Accouchement à terme'))),
                      TableCell(
                          child: Center(child: Text('Accouchement prématuré'))),
                      TableCell(child: Center(child: Text('ARBT spontané'))),
                      TableCell(child: Center(child: Text('ARBT provoqué'))),
                      TableCell(child: Center(child: Text('MIU'))),
                      TableCell(child: Center(child: Text('Mort-nés'))),
                      TableCell(
                          child: Center(child: Text('Décédés néo-nataux'))),
                    ],
                  ),
                  for (int i = 0; i < 8; i++)
                    TableRow(
                      children: [
                        TableCell(child: Center(child: Text(''))),
                        for (int j = 0; j < 7; j++)
                          TableCell(
                            child: TextField(
                              controller: controllers[i][j],
                              keyboardType: TextInputType.text,
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'PATHOLOGIQUES',
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                value: selectedFamiliauxOption,
                onChanged: (newValue) {
                  setState(() {
                    selectedFamiliauxOption = newValue!;
                  });
                },
                items: ["Maternelle", "Paternelle", "Autre"]
                    .map((option) => DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        ))
                    .toList(),
                decoration: InputDecoration(
                  labelText: '2-Familiaux',
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(       onPressed: () {
                // Update the patientData map with the information from this page
                for (int i = 0; i < 8; i++) {
                  for (int j = 0; j < 7; j++) {
                    String key = 'cell_$i$j';
                    widget.patientData[key] = controllers[i][j].text;
                  }
                }

                // Update the patientData map with the additional information
                widget.patientData['pathologiques'] = pathologiquesController.text;
                widget.patientData['familiauxOption'] = selectedFamiliauxOption;

                // Navigate to the next page (ExamenEntre)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExamenEntre(patientData: widget.patientData),
                  ),
                );
              },
              child: Text('Continuer '),
            ),
          ],
        ),
      ),
    );
  }
}
