import 'package:flutter/material.dart';
import 'PatientInformationPage.dart';
import 'TABLE.dart';

class ExamenEntre extends StatefulWidget {
  final Map<String, dynamic> patientData;

  ExamenEntre({required this.patientData});

  @override
  _ExamenEntreState createState() => _ExamenEntreState();
}

class _ExamenEntreState extends State<ExamenEntre> {
  // Create TextEditingController for each field
  TextEditingController poidsController = TextEditingController();
  TextEditingController tailleController = TextEditingController();
  TextEditingController poulsController = TextEditingController();
  TextEditingController taController = TextEditingController();
  TextEditingController oedemesController = TextEditingController();
  TextEditingController labstixController = TextEditingController();
  TextEditingController particularitesController = TextEditingController();

  // Create TextEditingController for Examen Obstétrical fields
  TextEditingController huController = TextEditingController();
  TextEditingController contractionUterineController = TextEditingController();
  TextEditingController presentationController = TextEditingController();
  TextEditingController bcfController = TextEditingController();
  TextEditingController uterusController = TextEditingController();
  TextEditingController speculumController = TextEditingController();
  TextEditingController toucherVaginalController = TextEditingController();

  // Create TextEditingController for Examen Complémentaire fields
  TextEditingController groupeSanguinController = TextEditingController();
  TextEditingController fnsController = TextEditingController();
  TextEditingController glycemieController = TextEditingController();
  TextEditingController ureeSanguineController = TextEditingController();
  TextEditingController albuminurieController = TextEditingController();
  TextEditingController bwController = TextEditingController();
  TextEditingController serodiagnostixsTaxoplasmoseController =
      TextEditingController();
  TextEditingController serodiagnostixsRubeoleController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Examen d\'Entrée'),
        backgroundColor: Color(0xFF4F3981),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '1- Examen Général',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: poidsController,
              decoration: InputDecoration(labelText: 'Poids'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: tailleController,
              decoration: InputDecoration(labelText: 'Taille'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: poulsController,
              decoration: InputDecoration(labelText: 'Pouls'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: taController,
              decoration: InputDecoration(labelText: 'TA'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: oedemesController,
              decoration: InputDecoration(labelText: 'Oedèmes'),
            ),
            TextField(
              controller: labstixController,
              decoration: InputDecoration(labelText: 'Labstix'),
            ),
            TextField(
              controller: particularitesController,
              decoration: InputDecoration(labelText: 'Particularités'),
            ),
            SizedBox(height: 20),
            Text(
              '2- Examen Obstétrical',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: huController,
              decoration: InputDecoration(labelText: 'HU'),
            ),
            TextField(
              controller: contractionUterineController,
              decoration: InputDecoration(labelText: 'Contraction Utérine'),
            ),
            TextField(
              controller: presentationController,
              decoration: InputDecoration(labelText: 'Présentation'),
            ),
            TextField(
              controller: bcfController,
              decoration: InputDecoration(labelText: 'BCF'),
            ),
            TextField(
              controller: uterusController,
              decoration: InputDecoration(labelText: 'Utérus'),
            ),
            TextField(
              controller: speculumController,
              decoration: InputDecoration(labelText: 'Spéculum'),
            ),
            TextField(
              controller: toucherVaginalController,
              decoration: InputDecoration(labelText: 'Toucher Vaginal'),
            ),
            SizedBox(height: 20),
            Text(
              '3- Examen Complémentaire',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: groupeSanguinController,
              decoration: InputDecoration(labelText: 'Groupe Sanguin'),
            ),
            TextField(
              controller: fnsController,
              decoration: InputDecoration(labelText: 'FNS'),
            ),
            TextField(
              controller: glycemieController,
              decoration: InputDecoration(labelText: 'Glycémie'),
            ),
            TextField(
              controller: ureeSanguineController,
              decoration: InputDecoration(labelText: 'Urée Sanguine'),
            ),
            TextField(
              controller: albuminurieController,
              decoration: InputDecoration(labelText: 'Albuminurie'),
            ),
            TextField(
              controller: bwController,
              decoration: InputDecoration(labelText: 'BW'),
            ),
            TextField(
              controller: serodiagnostixsTaxoplasmoseController,
              decoration:
                  InputDecoration(labelText: 'Sérodiagnostixs Taxoplasmose'),
            ),
            TextField(
              controller: serodiagnostixsRubeoleController,
              decoration: InputDecoration(labelText: 'Sérodiagnostixs Rubéole'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Update the patientData map with the information from this page

                // ... (add other fields)

                // Save patient information to Firestore
                widget.patientData['poids'] = poidsController.text;
                widget.patientData['taille'] = tailleController.text;
                widget.patientData['albuminurie'] = albuminurieController.text;
                widget.patientData['bcf'] = bcfController.text;
                widget.patientData['bw'] = bwController.text;
                widget.patientData['contractionUterine'] =
                    contractionUterineController;
                widget.patientData['contractionUterine'] =
                    contractionUterineController.text;
                widget.patientData['glycemie'] = glycemieController.text;
                widget.patientData['groupeSanguin'] =
                    groupeSanguinController.text;
                widget.patientData['hu'] = huController.text;
                widget.patientData['labstix'] = labstixController.text;
                widget.patientData['oedemes'] = oedemesController.text;
                widget.patientData['particularites'] = particularitesController;
                widget.patientData['pouls'] = poulsController;
                widget.patientData['poids'] = poidsController;
                widget.patientData['presentation'] = presentationController;
                widget.patientData['serodiagnostixsRubeole'] =
                    serodiagnostixsRubeoleController.text;
                widget.patientData['serodiagnostixsTaxoplasmose'] =
                    serodiagnostixsTaxoplasmoseController.text;
                widget.patientData['speculum'] = speculumController.text;
                widget.patientData['ta'] = taController.text;
                widget.patientData['taille'] = tailleController.text;
                widget.patientData['toucherVaginal'] =
                    toucherVaginalController.text;

                // Handle button press here
              },
              child: Text('Submit'), // Change the button text as needed
            ),
          ],
        ),
      ),
    );
  }
}
