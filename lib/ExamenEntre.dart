import 'package:flutter/material.dart';
import 'PatientInformationPage.dart';
import 'TABLE.dart';

class ExamenEntre extends StatefulWidget {
  final Map<String, dynamic> patientData;

  ExamenEntre(
      {required this.patientData,
      required patientId,
      required List<GField> gFields,
      String? pathologie,
      String? paternelle,
      String? maternelle,
      String? autre});

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
  String? contractionUterineValue;
  String? relachementValue;
  bool isBonEtRegulier = false;
  bool isIrregulier = false;
  bool isBradycardie = false;
  bool isTachycardie = false;
  List<String> presentationOptions = ['Sommet', 'Siège', 'Transversale'];
  String? selectedPresentation;
  List<String> UterusOptions = ['GAL', 'GAT'];
  String? selectedUterus;
  List<String> positionOptions = ['Antérieur', 'Médiant', 'Postérieur'];
  String? selectedPosition;

  List<String> longueurOptions = [
    'Long',
    'Mi-long',
    'Court',
    'Envoi d\'éfacement'
  ];
  String? selectedLongueur;

  List<String> ouvertureOptions = ['1 doigt', '2 doigt', 'effacé'];
  String? selectedOuverture;
  List<String> effaceOptions = [
    '3 cm',
    '4 cm',
    '5 cm',
    '6 cm',
    '7 cm',
    '8 cm',
    '9 cm',
    '10 cm'
  ];
  String? selectedEfface;
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
            DropdownButtonFormField<String>(
              value: contractionUterineValue,
              onChanged: (newValue) {
                setState(() {
                  contractionUterineValue = newValue;
                  // Reset the relachementValue when changing contractionUterineValue
                  relachementValue = null;
                });
              },
              items: [
                DropdownMenuItem(value: 'Positive', child: Text('Positive')),
                DropdownMenuItem(value: 'Negative', child: Text('Negative')),
              ],
              decoration: InputDecoration(labelText: 'Contraction Utérine'),
            ),

            // Show the relachement dropdown only if contractionUterineValue is positive
            if (contractionUterineValue == 'Positive')
              DropdownButtonFormField<String>(
                value: relachementValue,
                onChanged: (newValue) {
                  setState(() {
                    relachementValue = newValue;
                  });
                },
                items: [
                  DropdownMenuItem(
                      value: 'Bon Relachement', child: Text('Bon Relachement')),
                  DropdownMenuItem(
                      value: 'Mauvais Relachement',
                      child: Text('Mauvais Relachement')),
                ],
                decoration: InputDecoration(labelText: 'Relachement'),
              ),

            DropdownButtonFormField<String>(
              value: selectedPresentation, // Set the value from the variable
              onChanged: (newValue) {
                setState(() {
                  selectedPresentation = newValue; // Update the selected value
                });
              },
              items: presentationOptions.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Présentation'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BCF',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isBonEtRegulier,
                      onChanged: (value) {
                        setState(() {
                          isBonEtRegulier = value!;
                          // Reset other checkboxes when selecting "Bon et régulier"
                          if (isBonEtRegulier) {
                            isIrregulier = false;
                            isBradycardie = false;
                            isTachycardie = false;
                          }
                        });
                      },
                    ),
                    Text('Bon et régulier'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isIrregulier,
                      onChanged: (value) {
                        setState(() {
                          isIrregulier = value!;
                          // Reset other checkboxes when selecting "Irrégulier"
                          if (isIrregulier) {
                            isBonEtRegulier = false;
                            isBradycardie = false;
                            isTachycardie = false;
                          }
                        });
                      },
                    ),
                    Text('Irrégulier'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isBradycardie,
                      onChanged: (value) {
                        setState(() {
                          isBradycardie = value!;
                          // Reset other checkboxes when selecting "Bradycardie"
                          if (isBradycardie) {
                            isBonEtRegulier = false;
                            isIrregulier = false;
                            isTachycardie = false;
                          }
                        });
                      },
                    ),
                    Text('Bradycardie'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isTachycardie,
                      onChanged: (value) {
                        setState(() {
                          isTachycardie = value!;
                          // Reset other checkboxes when selecting "Tachycardie"
                          if (isTachycardie) {
                            isBonEtRegulier = false;
                            isIrregulier = false;
                            isBradycardie = false;
                          }
                        });
                      },
                    ),
                    Text('Tachycardie'),
                  ],
                ),
              ],
            ),

            DropdownButtonFormField<String>(
              value: selectedUterus, // Set the value from the variable
              onChanged: (newValue) {
                setState(() {
                  selectedUterus = newValue; // Update the selected value
                });
              },
              items: UterusOptions.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Uterus'),
            ),
            TextField(
              controller: speculumController,
              decoration: InputDecoration(labelText: 'Spéculum'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Toucher Vaginal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                DropdownButtonFormField<String>(
                  value: selectedPosition,
                  onChanged: (newValue) {
                    setState(() {
                      selectedPosition = newValue;
                    });
                  },
                  items: positionOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Position'),
                ),
                DropdownButtonFormField<String>(
                  value: selectedLongueur,
                  onChanged: (newValue) {
                    setState(() {
                      selectedLongueur = newValue;
                    });
                  },
                  items: longueurOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Longueur'),
                ),
                DropdownButtonFormField<String>(
                  value: selectedOuverture,
                  onChanged: (newValue) {
                    setState(() {
                      selectedOuverture = newValue;
                    });
                  },
                  items: ouvertureOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Ouverture'),
                ),
                if (selectedOuverture == 'effacé')
                  DropdownButtonFormField<String>(
                    value: selectedEfface,
                    onChanged: (newValue) {
                      setState(() {
                        selectedEfface = newValue;
                      });
                    },
                    items: effaceOptions.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    decoration: InputDecoration(labelText: 'Effacement'),
                  ),
              ],
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
