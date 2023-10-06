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
          _patientData =
              null; // Reset patient data if the document does not exist
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
        builder: (context) => TablePage(patientId: _docIdController.text),
      ),
    );
  },
  parentDocumentId: _docIdController.text, // Pass the parent document ID
  subcollectionName: 'updates', // Replace with your subcollection name
)

        ],
      ),
    );
  }
}

class PatientDataWidget extends StatelessWidget {
 final Map<String, dynamic> patientData;
  final VoidCallback onEditPressed;
  final String parentDocumentId;
  final String subcollectionName;

  PatientDataWidget({
    required this.patientData,
    required this.onEditPressed,
    required this.parentDocumentId,
    required this.subcollectionName,
  });

  // Define a function to create a spaced Text widget
  Widget spacedText(String label, String value) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 8.0), // Adjust the spacing as needed
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 20), // Adjust the horizontal padding as needed
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Personal Information
          Text('Personal Information:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('Nom:', patientData['nom'] ?? 'N/A'),
          spacedText('Prenom:', patientData['prenom'] ?? 'N/A'),
          spacedText(
              'Date de Naissance:', patientData['dateNaissance'] ?? 'N/A'),
          spacedText('Adresse:', patientData['adresse'] ?? 'N/A'),
          spacedText(
              'Numéro de Téléphone:', patientData['numeroTelephone'] ?? 'N/A'),

          //Observation à l'entrée
          Text('Observation à l\'entrée:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('Motif de Consultation:',
              patientData['motifConsultation'] ?? 'N/A'),

          //     // Antécédent

          Text('Antécédent:', style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('Menarchie:', patientData['menarchie'] ?? 'N/A'),
          spacedText('Durée des règles:', patientData['dureed'] ?? 'N/A'),
          spacedText('Âge au Mariage:', patientData['ageMariage'] ?? 'N/A'),
          spacedText(
              'Caractère du Cycle:', patientData['caractereCycle'] ?? 'N/A'),
          // Caractère du Cycle
          Text('contraception:', style: TextStyle(fontWeight: FontWeight.bold)),
          if (patientData['contraception'] != null &&
              patientData['contraception'] is List)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: patientData['contraception'].map<Widget>((cycleItem) {
                return Text(cycleItem.toString());
              }).toList(),
            ),

          // Obstétricaux
          Text('Obstétricaux:', style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('G_AUB_G1:', patientData['G_AUB_G1'] ?? 'N/A'),
          spacedText('G_PN_G1:', patientData['G_PN_G1'] ?? 'N/A'),
          spacedText('G_E_G1:', patientData['G_E_G1'] ?? 'N/A'),
          spacedText('G_AUB_G2:', patientData['G_AUB_G2'] ?? 'N/A'),
          spacedText('G_PN_G2:', patientData['G_PN_G2'] ?? 'N/A'),
          spacedText('G_E_G2:', patientData['G_E_G2'] ?? 'N/A'),
          spacedText('G_AUB_G3:', patientData['G_AUB_G3'] ?? 'N/A'),
          spacedText('G_PN_G3:', patientData['G_PN_G3'] ?? 'N/A'),
          spacedText('G_E_G3:', patientData['G_E_G3'] ?? 'N/A'),
          spacedText('G_AUB_G4:', patientData['G_AUB_G4'] ?? 'N/A'),
          spacedText('G_PN_G4:', patientData['G_PN_G4'] ?? 'N/A'),
          spacedText('G_E_G4:', patientData['G_E_G4'] ?? 'N/A'),
          spacedText('G_AUB_G5:', patientData['G_AUB_G5'] ?? 'N/A'),
          spacedText('G_PN_G5:', patientData['G_PN_G5'] ?? 'N/A'),
          spacedText('G_E_G5:', patientData['G_E_G5'] ?? 'N/A'),
          spacedText('G_AUB_G6:', patientData['G_AUB_G6'] ?? 'N/A'),
          spacedText('G_PN_G6:', patientData['G_PN_G6'] ?? 'N/A'),
          spacedText('G_E_G6:', patientData['G_E_G6'] ?? 'N/A'),
          spacedText('G_AUB_G7:', patientData['G_AUB_G7'] ?? 'N/A'),
          spacedText('G_PN_G7:', patientData['G_PN_G7'] ?? 'N/A'),
          spacedText('G_E_G7:', patientData['G_E_G7'] ?? 'N/A'),

          // Pathologie
          Text('Pathologie:', style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('Pathologie:', patientData['pathologie'] ?? 'N/A'),

          // Familiaux
          Text('Familiaux:', style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('Paternelle:', patientData['paternelle'] ?? 'N/A'),
          spacedText('Maternelle:', patientData['maternelle'] ?? 'N/A'),
          spacedText('Autre:', patientData['autre'] ?? 'N/A'),

          // Examen Générale
          Text('Examen Générale:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('Poids:', patientData['poids'] ?? 'N/A'),
          spacedText('Taille:', patientData['taille'] ?? 'N/A'),
          spacedText('Pouls:', patientData['pouls'] ?? 'N/A'),
          // Continue for TA, oedemes, labstix, particularites

          // Examen obstétricale
          Text('Examen obstétricale:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('HU:', patientData['hu'] ?? 'N/A'),
          spacedText('Contraction Uterine:',
              patientData['contractionUterine'] ?? 'N/A'),
          spacedText('Presentation:', patientData['presentation'] ?? 'N/A'),
          // Continue for bcf, uterus, speculum, toucherVaginal

          // Examen complémentaire
          Text('Examen complémentaire:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('Examen complémentaire:',
              patientData['Examen complémentaire'] ?? 'N/A'),
          spacedText('Groupe Sanguin:', patientData['groupeSanguin'] ?? 'N/A'),
          spacedText('FNS:', patientData['fns'] ?? 'N/A'),
          
  StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('patients')
      .doc(parentDocumentId)
      .collection(subcollectionName)
      .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subcollection Title:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('No data available'),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subcollection Title:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          for (var index = 0; index < snapshot.data!.docs.length; index++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'La visite ${index + 1}', // Generate the title based on the index
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Display other subcollection fields as needed
                  Text('Personal Information:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('Nom:', patientData['nom'] ?? 'N/A'),
          spacedText('Prenom:', patientData['prenom'] ?? 'N/A'),
          spacedText(
              'Date de Naissance:', patientData['dateNaissance'] ?? 'N/A'),
          spacedText('Adresse:', patientData['adresse'] ?? 'N/A'),
          spacedText(
              'Numéro de Téléphone:', patientData['numeroTelephone'] ?? 'N/A'),

          //Observation à l'entrée
          Text('Observation à l\'entrée:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('Motif de Consultation:',
              patientData['motifConsultation'] ?? 'N/A'),

          //     // Antécédent

          Text('Antécédent:', style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('Menarchie:', patientData['menarchie'] ?? 'N/A'),
          spacedText('Durée des règles:', patientData['dureed'] ?? 'N/A'),
          spacedText('Âge au Mariage:', patientData['ageMariage'] ?? 'N/A'),
          spacedText(
              'Caractère du Cycle:', patientData['caractereCycle'] ?? 'N/A'),
          // Caractère du Cycle
          Text('contraception:', style: TextStyle(fontWeight: FontWeight.bold)),
          if (patientData['contraception'] != null &&
              patientData['contraception'] is List)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: patientData['contraception'].map<Widget>((cycleItem) {
                return Text(cycleItem.toString());
              }).toList(),
            ),

          // Obstétricaux
          Text('Obstétricaux:', style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('G_AUB_G1:', patientData['G_AUB_G1'] ?? 'N/A'),
          spacedText('G_PN_G1:', patientData['G_PN_G1'] ?? 'N/A'),
          spacedText('G_E_G1:', patientData['G_E_G1'] ?? 'N/A'),
          spacedText('G_AUB_G2:', patientData['G_AUB_G2'] ?? 'N/A'),
          spacedText('G_PN_G2:', patientData['G_PN_G2'] ?? 'N/A'),
          spacedText('G_E_G2:', patientData['G_E_G2'] ?? 'N/A'),
          spacedText('G_AUB_G3:', patientData['G_AUB_G3'] ?? 'N/A'),
          spacedText('G_PN_G3:', patientData['G_PN_G3'] ?? 'N/A'),
          spacedText('G_E_G3:', patientData['G_E_G3'] ?? 'N/A'),
          spacedText('G_AUB_G4:', patientData['G_AUB_G4'] ?? 'N/A'),
          spacedText('G_PN_G4:', patientData['G_PN_G4'] ?? 'N/A'),
          spacedText('G_E_G4:', patientData['G_E_G4'] ?? 'N/A'),
          spacedText('G_AUB_G5:', patientData['G_AUB_G5'] ?? 'N/A'),
          spacedText('G_PN_G5:', patientData['G_PN_G5'] ?? 'N/A'),
          spacedText('G_E_G5:', patientData['G_E_G5'] ?? 'N/A'),
          spacedText('G_AUB_G6:', patientData['G_AUB_G6'] ?? 'N/A'),
          spacedText('G_PN_G6:', patientData['G_PN_G6'] ?? 'N/A'),
          spacedText('G_E_G6:', patientData['G_E_G6'] ?? 'N/A'),
          spacedText('G_AUB_G7:', patientData['G_AUB_G7'] ?? 'N/A'),
          spacedText('G_PN_G7:', patientData['G_PN_G7'] ?? 'N/A'),
          spacedText('G_E_G7:', patientData['G_E_G7'] ?? 'N/A'),

          // Pathologie
          Text('Pathologie:', style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('Pathologie:', patientData['pathologie'] ?? 'N/A'),

          // Familiaux
          Text('Familiaux:', style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('Paternelle:', patientData['paternelle'] ?? 'N/A'),
          spacedText('Maternelle:', patientData['maternelle'] ?? 'N/A'),
          spacedText('Autre:', patientData['autre'] ?? 'N/A'),

          // Examen Générale
          Text('Examen Générale:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('Poids:', patientData['poids'] ?? 'N/A'),
          spacedText('Taille:', patientData['taille'] ?? 'N/A'),
          spacedText('Pouls:', patientData['pouls'] ?? 'N/A'),
          // Continue for TA, oedemes, labstix, particularites

          // Examen obstétricale
          Text('Examen obstétricale:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('HU:', patientData['hu'] ?? 'N/A'),
          spacedText('Contraction Uterine:',
              patientData['contractionUterine'] ?? 'N/A'),
          spacedText('Presentation:', patientData['presentation'] ?? 'N/A'),
          // Continue for bcf, uterus, speculum, toucherVaginal

          // Examen complémentaire
          Text('Examen complémentaire:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          spacedText('Examen complémentaire:',
              patientData['Examen complémentaire'] ?? 'N/A'),
          spacedText('Groupe Sanguin:', patientData['groupeSanguin'] ?? 'N/A'),
          spacedText('FNS:', patientData['fns'] ?? 'N/A'),
                 

              ],
            ),
        ],
      );
    }
  },
),

            Padding(
          padding: const EdgeInsets.symmetric(
         vertical: 4.0,
              horizontal: 100.0,),
          child: ElevatedButton(
            onPressed: onEditPressed,
            child: Text('Edit'),
          ),
        ),// Continue for glycemie, ureeSanguine, albuminurie, bw, serodiagnostixsTaxoplasmose, serodiagnostixsRubeole
        ],
      ),
    );
    
  }
}
