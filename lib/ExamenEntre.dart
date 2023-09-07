import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'PatientInformationPage.dart';
import 'TABLE.dart';

class ExamenEntre extends StatefulWidget {
  final String patientId; // Declare the patientId variable as a parameter

  ExamenEntre({required this.patientId}); // Constructor that requires patientId

  @override
  _ExamenEntreState createState() => _ExamenEntreState();
}

class _ExamenEntreState extends State<ExamenEntre> {
  String get patientId => widget.patientId; // Access patientId using the getter

  // Retrieve the existing data from Firestore
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

  Map<String, dynamic> patientData = {};
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
  TextEditingController nombreDeFetusController = TextEditingController();
  TextEditingController activiteCardiaqueController = TextEditingController();
  TextEditingController frequenceCardiaqueController = TextEditingController();
  TextEditingController mobiliteController = TextEditingController();
  TextEditingController longueurCranioCaudaleController =
      TextEditingController();
  TextEditingController bipController = TextEditingController();
  TextEditingController perimetreCranienController = TextEditingController();
  TextEditingController perimetreAbdominaleController = TextEditingController();
  TextEditingController clarteNucaleController = TextEditingController();
  TextEditingController datController = TextEditingController();
  TextEditingController poleCephaliqueController = TextEditingController();
  TextEditingController abdomenController = TextEditingController();
  TextEditingController membreController = TextEditingController();
  TextEditingController annexesController = TextEditingController();
  TextEditingController conclusionController = TextEditingController();
  TextEditingController nombreDeFetusEchoDeuxiemeController =
      TextEditingController();
  TextEditingController activiteCardiaqueEchoDeuxiemeController =
      TextEditingController();
  TextEditingController frequenceCardiaqueEchoDeuxiemeController =
      TextEditingController();
  TextEditingController mobiliteEchoDeuxiemeController =
      TextEditingController();
  TextEditingController longueurCranioCaudaleEchoDeuxiemeController =
      TextEditingController();
  TextEditingController bipEchoDeuxiemeController = TextEditingController();
  TextEditingController perimetreCranienEchoDeuxiemeController =
      TextEditingController();
  TextEditingController perimetreAbdominaleEchoDeuxiemeController =
      TextEditingController();
  TextEditingController clarteNucaleEchoDeuxiemeController =
      TextEditingController();
  TextEditingController datEchoDeuxiemeController = TextEditingController();
  TextEditingController poleCephaliqueEchoDeuxiemeController =
      TextEditingController();
  TextEditingController abdomenEchoDeuxiemeController = TextEditingController();
  TextEditingController membreEchoDeuxiemeController = TextEditingController();
  TextEditingController annexesEchoDeuxiemeController = TextEditingController();
  TextEditingController conclusionEchoDeuxiemeController =
      TextEditingController();

  // Create TextEditingController for Écho du troisième trimestre fields
  TextEditingController nombreDeFetusEchoTroisiemeController =
      TextEditingController();
  TextEditingController activiteCardiaqueEchoTroisiemeController =
      TextEditingController();
  TextEditingController frequenceCardiaqueEchoTroisiemeController =
      TextEditingController();
  TextEditingController mobiliteEchoTroisiemeController =
      TextEditingController();
  TextEditingController longueurCranioCaudaleEchoTroisiemeController =
      TextEditingController();
  TextEditingController bipEchoTroisiemeController = TextEditingController();
  TextEditingController perimetreCranienEchoTroisiemeController =
      TextEditingController();
  TextEditingController perimetreAbdominaleEchoTroisiemeController =
      TextEditingController();
  TextEditingController clarteNucaleEchoTroisiemeController =
      TextEditingController();
  TextEditingController datEchoTroisiemeController = TextEditingController();
  TextEditingController poleCephaliqueEchoTroisiemeController =
      TextEditingController();
  TextEditingController abdomenEchoTroisiemeController =
      TextEditingController();
  TextEditingController membreEchoTroisiemeController = TextEditingController();
  TextEditingController annexesEchoTroisiemeController =
      TextEditingController();
  TextEditingController conclusionEchoTroisiemeController =
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
            Text(
              '4- Échographie du premier trimestre',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: nombreDeFetusController,
              decoration: InputDecoration(labelText: 'Nombre de fœtus'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Text(
              'Vitalité',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: activiteCardiaqueController,
              decoration: InputDecoration(labelText: 'Activité cardiaque'),
            ),
            TextField(
              controller: frequenceCardiaqueController,
              decoration: InputDecoration(labelText: 'Fréquence cardiaque'),
            ),
            TextField(
              controller: mobiliteController,
              decoration: InputDecoration(labelText: 'Mobilité'),
            ),

            SizedBox(height: 10),
            Text(
              'Biometrie',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: longueurCranioCaudaleController,
              decoration: InputDecoration(labelText: 'Longueur cranio-caudale'),
            ),
            TextField(
              controller: bipController,
              decoration: InputDecoration(labelText: 'BIP'),
            ),
            TextField(
              controller: perimetreCranienController,
              decoration: InputDecoration(labelText: 'Périmètre crânien'),
            ),
            TextField(
              controller: perimetreAbdominaleController,
              decoration: InputDecoration(labelText: 'Périmètre abdominal'),
            ),
            TextField(
              controller: clarteNucaleController,
              decoration: InputDecoration(labelText: 'Clarté nucale'),
            ),
            TextField(
              controller: datController,
              decoration: InputDecoration(labelText: 'DAT'),
            ),

            SizedBox(height: 10),
            Text(
              'Morphologie',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: poleCephaliqueController,
              decoration: InputDecoration(labelText: 'Pôle céphalique'),
            ),
            TextField(
              controller: abdomenController,
              decoration: InputDecoration(labelText: 'Abdomen'),
            ),
            TextField(
              controller: membreController,
              decoration: InputDecoration(labelText: 'Membre'),
            ),

            SizedBox(height: 10),
            Text(
              'Annexes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: annexesController,
              decoration: InputDecoration(labelText: 'Annexes'),
            ),

            SizedBox(height: 10),
            Text(
              'Conclusion',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: conclusionController,
              decoration: InputDecoration(labelText: 'Conclusion'),
            ),

            SizedBox(height: 20),

            SizedBox(height: 20),
            SizedBox(height: 20),
            Text(
              '4- Échographie du deuxime trimestre',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: nombreDeFetusEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'Nombre de fœtus'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Text(
              'Vitalité',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: activiteCardiaqueEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'Activité cardiaque'),
            ),
            TextField(
              controller: frequenceCardiaqueEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'Fréquence cardiaque'),
            ),
            TextField(
              controller: mobiliteEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'Mobilité'),
            ),

            SizedBox(height: 10),
            Text(
              'Biometrie',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: longueurCranioCaudaleEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'Longueur cranio-caudale'),
            ),
            TextField(
              controller: bipEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'BIP'),
            ),
            TextField(
              controller: perimetreCranienEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'Périmètre crânien'),
            ),
            TextField(
              controller: perimetreAbdominaleEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'Périmètre abdominal'),
            ),
            TextField(
              controller: clarteNucaleEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'Clarté nucale'),
            ),
            TextField(
              controller: datEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'DAT'),
            ),

            SizedBox(height: 10),
            Text(
              'Morphologie',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: poleCephaliqueEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'Pôle céphalique'),
            ),
            TextField(
              controller: abdomenEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'Abdomen'),
            ),
            TextField(
              controller: membreEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'Membre'),
            ),

            SizedBox(height: 10),
            Text(
              'Annexes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: annexesEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'Annexes'),
            ),

            SizedBox(height: 10),
            Text(
              'Conclusion',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: conclusionEchoDeuxiemeController,
              decoration: InputDecoration(labelText: 'Conclusion'),
            ),

            SizedBox(height: 20),

            Text(
              '6- Échographie du troisième trimestre',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: nombreDeFetusEchoTroisiemeController,
              decoration: InputDecoration(labelText: 'Nombre de fœtus'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Text(
              'Vitalité',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: activiteCardiaqueEchoTroisiemeController,
              decoration: InputDecoration(labelText: 'Activité cardiaque'),
            ),
            TextField(
              controller: frequenceCardiaqueEchoTroisiemeController,
              decoration: InputDecoration(labelText: 'Fréquence cardiaque'),
            ),
            TextField(
              controller: mobiliteEchoTroisiemeController,
              decoration: InputDecoration(labelText: 'Mobilité'),
            ),

            SizedBox(height: 10),
            Text(
              'Biometrie',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: longueurCranioCaudaleEchoTroisiemeController,
              decoration: InputDecoration(labelText: 'Longueur cranio-caudale'),
            ),
            TextField(
              controller: bipController,
              decoration: InputDecoration(labelText: 'BIP'),
            ),
            TextField(
              controller: perimetreCranienEchoTroisiemeController,
              decoration: InputDecoration(labelText: 'Périmètre crânien'),
            ),
            TextField(
              controller: perimetreAbdominaleEchoTroisiemeController,
              decoration: InputDecoration(labelText: 'Périmètre abdominal'),
            ),
            TextField(
              controller: clarteNucaleEchoTroisiemeController,
              decoration: InputDecoration(labelText: 'Clarté nucale'),
            ),
            TextField(
              controller: datEchoTroisiemeController,
              decoration: InputDecoration(labelText: 'DAT'),
            ),

            SizedBox(height: 10),
            Text(
              'Morphologie',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: poleCephaliqueEchoTroisiemeController,
              decoration: InputDecoration(labelText: 'Pôle céphalique'),
            ),
            TextField(
              controller: abdomenEchoTroisiemeController,
              decoration: InputDecoration(labelText: 'Abdomen'),
            ),
            TextField(
              controller: membreEchoTroisiemeController,
              decoration: InputDecoration(labelText: 'Membre'),
            ),

            SizedBox(height: 10),
            Text(
              'Annexes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: annexesEchoTroisiemeController,
              decoration: InputDecoration(labelText: 'Annexes'),
            ),

            SizedBox(height: 10),
            Text(
              'Conclusion',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: conclusionEchoTroisiemeController,
              decoration: InputDecoration(labelText: 'Conclusion'),
            ),

            SizedBox(height: 20),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Update the patientData map with the information from this page

                // ... (add other fields)

                // Save patient information to Firestore
                patientData['poids'] = poidsController.text;
                patientData['taille'] = tailleController.text;
                patientData['albuminurie'] = albuminurieController.text;
                patientData['bcf'] = bcfController.text;
                patientData['bw'] = bwController.text;
                patientData['contractionUterine'] =
                    contractionUterineController;
                patientData['contractionUterine'] =
                    contractionUterineController.text;
                patientData['glycemie'] = glycemieController.text;
                patientData['groupeSanguin'] = groupeSanguinController.text;
                patientData['hu'] = huController.text;
                patientData['labstix'] = labstixController.text;
                patientData['oedemes'] = oedemesController.text;
                patientData['particularites'] = particularitesController.text;
                patientData['pouls'] = poulsController.text;
                patientData['poids'] = poidsController.text;
                patientData['presentation'] = presentationController.text;
                patientData['serodiagnostixsRubeole'] =
                    serodiagnostixsRubeoleController.text;
                patientData['serodiagnostixsTaxoplasmose'] =
                    serodiagnostixsTaxoplasmoseController.text;
                patientData['speculum'] = speculumController.text;
                patientData['ta'] = taController.text;
                patientData['taille'] = tailleController.text;
                patientData['toucherVaginal'] = toucherVaginalController.text;
                patientData['nombreDeFetus'] = nombreDeFetusController.text;
                patientData['activiteCardiaque'] =
                    activiteCardiaqueController.text;
                patientData['frequenceCardiaque'] =
                    frequenceCardiaqueController.text;
                patientData['mobilite'] = mobiliteController.text;
                patientData['longueurCranioCaudale'] =
                    longueurCranioCaudaleController.text;
                patientData['bip'] = bipController.text;
                patientData['perimetreCranien'] =
                    perimetreCranienController.text;
                patientData['perimetreAbdominale'] =
                    perimetreAbdominaleController.text;
                patientData['clarteNucale'] = clarteNucaleController.text;
                patientData['dat'] = datController.text;
                patientData['poleCephalique'] = poleCephaliqueController.text;
                patientData['abdomen'] = abdomenController.text;
                patientData['membre'] = membreController.text;
                patientData['annexes'] = annexesController.text;
                patientData['conclusion'] = conclusionController.text;

//                   //////////////////////////////////////////////:
                patientData['nombreDeFetusEchoDeuxieme '] =
                    nombreDeFetusEchoDeuxiemeController.text;
                patientData['activiteCardiaqueEchoDeuxieme'] =
                    activiteCardiaqueEchoDeuxiemeController.text;
                patientData['frequenceCardiaqueEchoDeuxieme'] =
                    frequenceCardiaqueEchoDeuxiemeController.text;
                patientData['mobiliteEchoDeuxieme'] =
                    mobiliteEchoDeuxiemeController.text;
                patientData['longueurCranioCaudaleEchoDeuxieme'] =
                    longueurCranioCaudaleEchoDeuxiemeController.text;
                patientData['bipEchoDeuxieme'] = bipEchoDeuxiemeController.text;
                patientData['perimetreCranienEchoDeuxieme'] =
                    perimetreCranienEchoDeuxiemeController.text;
                patientData['perimetreAbdominaleEchoDeuxieme'] =
                    perimetreAbdominaleEchoDeuxiemeController.text;
                patientData['clarteNucaleEchoDeuxieme'] =
                    clarteNucaleEchoDeuxiemeController.text;
                patientData['datEchoDeuxieme'] = datEchoDeuxiemeController.text;
                patientData['poleCephaliqueEchoDeuxieme'] =
                    poleCephaliqueEchoDeuxiemeController.text;
                patientData['abdomenEchoDeuxieme'] =
                    abdomenEchoDeuxiemeController.text;
                patientData['membreEchoDeuxieme'] =
                    membreEchoDeuxiemeController.text;
                patientData['annexesEchoDeuxieme'] =
                    annexesEchoDeuxiemeController.text;
                patientData['conclusionEchoDeuxieme'] =
                    conclusionEchoDeuxiemeController.text;
// ////////////////////////////////////////////
//                   patientData['nombreDeFetusEchoTroisieme'] =
//                       nombreDeFetusEchoTroisiemeController.text;
//                   patientData['activiteCardiaqueEchoTroisieme'] =
//                       activiteCardiaqueEchoTroisiemeController.text;
//                   patientData['frequenceCardiaqueEchoTroisieme'] =
//                       frequenceCardiaqueEchoTroisiemeController.text;
//                   patientData['mobiliteEchoTroisieme'] =
//                       mobiliteEchoTroisiemeController.text;
//                   patientData['longueurCranioCaudaleEchoTroisieme'] =
//                       longueurCranioCaudaleEchoTroisiemeController.text;
//                   patientData['bipEchoTroisieme'] =
//                       bipEchoTroisiemeController.text;
//                   patientData['perimetreCranienEchoTroisieme'] =
//                       perimetreCranienEchoTroisiemeController.text;
//                   patientData['perimetreAbdominaleEchoTroisieme'] =
//                       perimetreAbdominaleEchoTroisiemeController.text;
//                   patientData['clarteNucaleEchoTroisieme'] =
//                       clarteNucaleEchoTroisiemeController.text;
//                   patientData['datEchoTroisieme'] =
//                       datEchoTroisiemeController.text;
//                   patientData['poleCephaliqueEchoTroisieme'] =
//                       poleCephaliqueEchoTroisiemeController.text;
//                   patientData['abdomenEchoTroisieme'] =
//                       abdomenEchoTroisiemeController.text;
//                   patientData['membreEchoTroisieme'] =
//                       membreEchoTroisiemeController.text;
//                   patientData['annexesEchoTroisieme'] =
//                       annexesEchoTroisiemeController.text;
//                   patientData['conclusionEchoTroisieme'] =
//                       conclusionEchoTroisiemeController.text;

                // Update the patientData map with the information from this page
                updateDataInFirestore(patientData, patientId);
                // ... (add other fields)
                // S ave patient information to Firestore

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
