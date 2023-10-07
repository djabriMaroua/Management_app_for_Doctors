import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class GField {
  String? gNumber; // G number
  String? aub;
  String? pn;
  String? e;
}

class gynecologique extends StatefulWidget {
  @override
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

  State<gynecologique> createState() => _gynecologiqueState();
}

void _submitDataToFirestore(
    Map<String, dynamic> patientData, String patientId) {
  try {
    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Define the collection name (assuming "patientsinfo" is your collection name)
    CollectionReference patientsCollection =
        firestore.collection('gyne');

    // Add the patient data to Firestore
    patientsCollection.doc(patientId).set(patientData).then((_) {
      print("Patient information added with ID: ${patientId}");
    }).catchError((error) {
      print("Error adding patient information: $error");
    });
  } catch (e) {
    // Handle any errors that occur during data submission
    print('Error adding data to Firestore: $e');
  }
}

class _gynecologiqueState extends State<gynecologique> {
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

  List<int> gpcaNumbers = List.generate(13, (index) => index + 1);
  final _formKey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController datedenaissanceController = TextEditingController();
  TextEditingController lieudenaissanceController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController profduconjointController = TextEditingController();
  TextEditingController groupesanguinController = TextEditingController();
  TextEditingController motifconsultationController = TextEditingController();
  TextEditingController paternelleController = TextEditingController();
  TextEditingController maternelleController = TextEditingController();
  TextEditingController autreController = TextEditingController();
  int selectedMenarchie = 8; // Initialize with a default value of 8
  int selectedmenopose = 25;
  List<String> caractereCycleOptions = ['Régulier', 'Irégulier'];
  String selectedCaractereCycle = 'Régulier'; // Initialize with a default value

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != datedenaissanceController.text) {
      setState(() {
        final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        datedenaissanceController.text = formattedDate;
      });
    }
  }

  List<String> contraceptionOptions = [
    'Naturelle',
    'Obstropiogestatif',
    'Microprogestatif',
    'DIU',
    'Implant'
  ];
  int? gpcaSelection;
  TextEditingController affectionsController = TextEditingController();
  TextEditingController debutControllerController = TextEditingController();
  TextEditingController signesfonctionnelsController = TextEditingController();
  TextEditingController signesgenerauxController = TextEditingController();
  TextEditingController inspectionController = TextEditingController();
  TextEditingController palpationController = TextEditingController();
  TextEditingController speculumController = TextEditingController();
  TextEditingController colposcopieController = TextEditingController();
  TextEditingController touchevagianelController = TextEditingController();
  TextEditingController toucherrectaleController = TextEditingController();
  TextEditingController examenseinsController = TextEditingController();
  TextEditingController poindsController = TextEditingController();
  TextEditingController tailleController = TextEditingController();
  TextEditingController TAController = TextEditingController();
  TextEditingController cardiovasculaireController = TextEditingController();
  TextEditingController pulmonaireController = TextEditingController();
  TextEditingController digestifController = TextEditingController();
  TextEditingController frottisController = TextEditingController();
  TextEditingController datefrottisController = TextEditingController();
  TextEditingController BEController = TextEditingController();
  TextEditingController dateBEController = TextEditingController();

  TextEditingController autrebiopsieController = TextEditingController();
  TextEditingController dateautrebiopsieController = TextEditingController();

  TextEditingController HSGController = TextEditingController();
  TextEditingController dateHSGController = TextEditingController();

  TextEditingController echograpghieCOntroller = TextEditingController();
  TextEditingController dateechograpghieCOntroller = TextEditingController();

  TextEditingController dateautreexamneController = TextEditingController();

  TextEditingController autreexamneController = TextEditingController();
  TextEditingController diagnosticController = TextEditingController();
  TextEditingController decisionthController = TextEditingController();
  TextEditingController medicauxController = TextEditingController();
  TextEditingController menarchieController = TextEditingController();
  TextEditingController menoposeCOPntroller = TextEditingController();
  List<String> selectedContraception = [];
  TextEditingController urinaireController = TextEditingController();
  List<GField> gFields = [];
  List<String> eOptions = [
    'VBP',
    'MIU',
    'Mort de travail',
    'Mal formation',
    'Autre'
  ];
  TextEditingController chirurgicauxController = TextEditingController();
  Map<String, dynamic> patientData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Consulation gynecologuique'),
          backgroundColor: Color(0xFF4F3981),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                controller: nomController,
                style: TextStyle(color: Color(0xFF4F3981)),
                decoration: InputDecoration(labelText: 'Nom'),
                onChanged: (value) {
                  updatePatientData('nom', value);
                },
              ),
              TextFormField(
                controller: prenomController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Prénom'),
                onChanged: (value) {
                  updatePatientData('prenom', value);
                },
              ),
              GestureDetector(
                onTap: () => _selectDateOfBirth(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: datedenaissanceController,
                    style:
                        TextStyle(color: Color(0xFF4F3981)), // Set text color
                    decoration: InputDecoration(labelText: 'Date de naissance'),
                    onChanged: (value) {
                      updatePatientData('date de naissance', value);
                    },
                  ),
                ),
              ),
              TextFormField(
                controller: lieudenaissanceController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'lieu de naissance'),
                onChanged: (value) {
                  updatePatientData('lieu de naissance', value);
                },
              ),
              TextFormField(
                controller: professionController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Proffesion'),
                onChanged: (value) {
                  updatePatientData('proffesion', value);
                },
              ),
              TextFormField(
                controller: profduconjointController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Prof du conjoint'),
                onChanged: (value) {
                  updatePatientData('profduconjoint', value);
                },
              ),
              TextFormField(
                controller: groupesanguinController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Groupe sanguin'),
                onChanged: (value) {
                  updatePatientData('gsanguin', value);
                },
              ),
              TextFormField(
                controller: motifconsultationController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Motif de consulation'),
                onChanged: (value) {
                  updatePatientData('motifconsultation', value);
                },
              ),
              Text(
                'Antecedent',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Familiaux',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: maternelleController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'maternelle '),
 onChanged: (value) {
                  updatePatientData('maternelle', value);
                },
                
              ),
              TextFormField(
                controller: paternelleController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'paternelle'),
                onChanged: (value) {
                  updatePatientData('paternelle', value);
                }, 
              ),
              TextFormField(
                controller: autreController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'autre '),
                onChanged: (value) {
                  updatePatientData('autre', value);
                }, 
              ),
              Text(
                'Mediaux',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: medicauxController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'medicaux '),
                onChanged: (value) {
                  updatePatientData('medicaux', value);
                },
              ),
              Text(
                'Chirurgucaux',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: chirurgicauxController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'chirurgicaux '),
                onChanged: (value) {
                  updatePatientData('chirurgucaux', value);
                },
              ),
              Text(
                'Obstétricaux',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        int? selectedGNumber =
                            await _showGNumberSelectionDialog();

                        if (selectedGNumber != null) {
                          setState(() {
                            GField newGField = GField();
                            newGField.gNumber = 'G$selectedGNumber';

                            gFields.add(newGField);
                            updatePatientData('G',
                                selectedGNumber); // Assign the selected G number to the "G" field
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
                                gField.aub =
                                    value; // Associate AUB with the corresponding G number
                                updatePatientData(
                                    'G_AUB_${gField.gNumber}', value);
                              },
                              decoration: InputDecoration(labelText: 'AUB'),
                            ),
                            TextFormField(
                              onChanged: (value) {
                                gField.pn =
                                    value; // Associate PN with the corresponding G number
                                updatePatientData(
                                    'G_PN_${gField.gNumber}', value);
                              },
                              decoration: InputDecoration(labelText: 'PN'),
                            ),
                            DropdownButtonFormField<String>(
                              value: gField.e,
                              onChanged: (newValue) {
                                setState(() {
                                  gField.e = newValue;
                                });
                                updatePatientData('G_E_${gField.gNumber}',
                                    newValue); // Associate E with the corresponding G number
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

                    // ElevatedButton(
                    //   onPressed: () {
                    //     print(patientData);
                    //     // Call the function to submit data to Firestore
                        

                    //     // Navigate to the next page or perform other actions

                    //     // ...
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Color(0xFF4F3981),
                    //     onPrimary: Colors.white,
                    //     padding: EdgeInsets.symmetric(
                    //         vertical: 16.0, horizontal: 24.0),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //   ),
                    //   child: Text('Continue'),
                    // ),
                    Text(
                      'Gynecologique ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: menarchieController,
                      style:
                          TextStyle(color: Color(0xFF4F3981)), // Set text color
                      decoration: InputDecoration(labelText: 'Menarchie'),
                     onChanged: (value) {
                  updatePatientData('menarchi', value);
                },
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    TextFormField(
                      controller: menoposeCOPntroller,
                      style:
                          TextStyle(color: Color(0xFF4F3981)), // Set text color
                      decoration: InputDecoration(labelText: 'Ménopose'),
                     onChanged: (value) {
                  updatePatientData('menopose', value);
                },
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    TextFormField(
                      controller: affectionsController,
                      style:
                          TextStyle(color: Color(0xFF4F3981)), // Set text color
                      decoration: InputDecoration(
                          labelText: 'affections et traitement anterieurs  '),
                     onChanged: (value) {
                  updatePatientData('affection', value);
                },
                    ),
                    Text(
                      "Contraception",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4F3981), // Set text color
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      children: contraceptionOptions.map((option) {
                        return FilterChip(
                          label: Text(
                            option,
                            style: TextStyle(
                                color: Color(0xFF4F3981)), // Set text color
                          ),
                          selected: selectedContraception.contains(option),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedContraception.add(option);
                              } else {
                                selectedContraception.remove(option);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Text(
                'Histoire de la maladie',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: debutControllerController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Debut de la maladie  '),
               onChanged: (value) {
                  updatePatientData('debut', value);
                },
              ),
              Text(
                'Examen physique ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: signesfonctionnelsController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Signes fonctionnels  '),
                onChanged: (value) {
                  updatePatientData('signefonctio', value);
                },
              ),
              TextFormField(
                controller: signesgenerauxController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Signes generaux   '),
               onChanged: (value) {
                  updatePatientData('signesgeneraux', value);
                },
              ),
              Text(
                'Examen gynécologique',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: inspectionController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Inspection '),
                onChanged: (value) {
                  updatePatientData('inspection', value);
                },
              ),
              TextFormField(
                controller: palpationController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Palpation '),
                onChanged: (value) {
                  updatePatientData('palpation', value);
                },
              ),
              TextFormField(
                controller: speculumController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Speculum  '),
                onChanged: (value) {
                  updatePatientData('speculum', value);
                },
              ),
              TextFormField(
                controller: colposcopieController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Colposcopie  '),
               onChanged: (value) {
                  updatePatientData('colposcopie', value);
                },
              ),
              TextFormField(
                controller: touchevagianelController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Touché vagianle  '),
                onChanged: (value) {
                  updatePatientData('touché vagianale', value);
                },
              ),
              TextFormField(
                controller: examenseinsController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Examens des seins  '),
               onChanged: (value) {
                  updatePatientData('examen seins', value);
                },
              ),
              TextFormField(
                controller: poindsController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Poids '),
               onChanged: (value) {
                  updatePatientData('poids', value);
                },
              ),
              TextFormField(
                controller: tailleController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Poids '),
                onChanged: (value) {
                  updatePatientData('taille', value);
                },
              ),
              TextFormField(
                controller: TAController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'T.A '),
                onChanged: (value) {
                  updatePatientData('TA', value);
                },
              ),
              TextFormField(
                controller: cardiovasculaireController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'cardiovasculaire  '),
                onChanged: (value) {
                  updatePatientData('cardiovasculaire', value);
                },
              ),
              TextFormField(
                controller: pulmonaireController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'pulmonaire   '),
               onChanged: (value) {
                  updatePatientData('pulmonaire', value);
                },
              ),
              TextFormField(
                controller: digestifController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Digestif '),
                onChanged: (value) {
                  updatePatientData('digestif', value);
                },
              ),
              TextFormField(
                controller: urinaireController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'urinaire   '),
                onChanged: (value) {
                  updatePatientData('urianire', value);
                },
              ),
              Text(
                'Examen complementaires',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: frottisController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Frottis   '),
                onChanged: (value) {
                  updatePatientData('frottis', value);
                },
              ),
              TextFormField(
                controller: datefrottisController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'date dufrottis   '),
                onChanged: (value) {
                  updatePatientData('datefrottis', value);
                },
              ),
              TextFormField(
                controller: BEController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration:
                    InputDecoration(labelText: 'B E Curetage biopsique    '),
                onChanged: (value) {
                  updatePatientData('BE', value);
                },
              ),
              TextFormField(
                controller: dateBEController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(
                    labelText: 'date du BE Curetage biopsique    '),
               onChanged: (value) {
                  updatePatientData('dateBE', value);
                },
              ),
              TextFormField(
                controller: autrebiopsieController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Autre biopsies   '),
               onChanged: (value) {
                  updatePatientData('autrebioscopie', value);
                },
              ),
              TextFormField(
                controller: dateautrebiopsieController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration:
                    InputDecoration(labelText: 'date des autres biopsies   '),
                onChanged: (value) {
                  updatePatientData('dateautrebiopsie', value);
                },
              ),
              TextFormField(
                controller: HSGController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'H S G     '),
                
                 onChanged: (value) {
                  updatePatientData('HSG', value);
                },
              ),
              TextFormField(
                controller: dateHSGController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'date du HSG    '),
               onChanged: (value) {
                  updatePatientData('dateHSG', value);
                },
              ),
              TextFormField(
                controller: echograpghieCOntroller,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'echographie  '),
                onChanged: (value) {
                  updatePatientData('echo', value);
                },
              ),
              TextFormField(
                controller: dateechograpghieCOntroller,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration:
                    InputDecoration(labelText: 'Date de l\'echographie  '),
              onChanged: (value) {
                  updatePatientData('dateecho', value);
                },
              ),
              TextFormField(
                controller: autreexamneController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Autre examen     '),
                onChanged: (value) {
                  updatePatientData('autreexamen', value);
                },
              ),
              TextFormField(
                controller: diagnosticController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(labelText: 'Diagnostic   '),
                onChanged: (value) {
                  updatePatientData('diagnistic', value);
                },
              ),
              TextFormField(
                controller: decisionthController,
                style: TextStyle(color: Color(0xFF4F3981)), // Set text color
                decoration: InputDecoration(
                    labelText: 'La décision thérapeutique     '),
               onChanged: (value) {
                  updatePatientData('decision', value);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  print(patientData);
                  String patientId;
                  patientId = generatePatientId(
                      nomController.text, prenomController.text);
                  updateDataInFirestore(patientData, patientId);
                  // Call the function to submit data to Firestore
                  //savePatientInformation(patientData );

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
                child: Text('Submit'),
              ),
            ],
          ),
        ));
  }

  // Function to submit data to Firestore
  

  String generatePatientId(String firstName, String lastName) {
    return '$firstName$lastName';
  }

  Future<void> updateDataInFirestore(
  Map<String, dynamic> newData, String documentId) async {
  try {
    // Reference to the Firestore document
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('gyne').doc(documentId);

    // Fetch the existing data
    DocumentSnapshot documentSnapshot = await documentReference.get();

    if (documentSnapshot.exists) {
      print("exists");
      // Merge the existing data with the new data
      Map<String, dynamic> existingData =
          documentSnapshot.data() as Map<String, dynamic>;
      Map<String, dynamic> mergedData = {...existingData, ...newData};

      // Update the document with the merged data
      await documentReference.update(mergedData);

      print('Data updated in Firestore for document $documentId');
    } else {
      print('Document with ID $documentId does not exist. Creating a new document.');

      // Create a new document with the provided data
      await documentReference.set(newData);

      print('New document created in Firestore for document $documentId');
    }
  } catch (error) {
    print('Error updating data in Firestore: $error');
  }
}

}
