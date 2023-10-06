import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController etablissementController = TextEditingController();
  TextEditingController numeroTelController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController lieuNaissanceController = TextEditingController();
  TextEditingController diplomeController = TextEditingController();
  TextEditingController anneeDiplomeController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController dateDerniereVisiteController = TextEditingController();
  TextEditingController notelastController = TextEditingController();
  List<TimeSlot> emploiDuTemps = [];

  void saveDataToFirestore() async {
    try {
      await _firestore.collection('my_teachers').add({
        'nom': nomController.text,
        'prenom': prenomController.text,
        'etablissement': etablissementController.text,
        'numero_tel': numeroTelController.text,
        'email': emailController.text,
        'lieu_naissance': lieuNaissanceController.text,
        'diplome': diplomeController.text,
        'annee_diplome': anneeDiplomeController.text,
        'grade': gradeController.text,
        'date_derniere_visite': dateDerniereVisiteController.text,
        'notelast': notelastController.text,
        'emploi_du_temps': emploiDuTemps.map((slot) {
          return {
            'heure_debut': slot.heureDebut,
            'heure_fin': slot.heureFin,
            'jour': slot.jour,
            'classe_enseignee': slot.classeEnseignee,
          };
        }).toList(),
      });

      nomController.clear();
      prenomController.clear();
      etablissementController.clear();
      numeroTelController.clear();
      emailController.clear();
      lieuNaissanceController.clear();
      diplomeController.clear();
      anneeDiplomeController.clear();
      gradeController.clear();
      dateDerniereVisiteController.clear();
      notelastController.clear();
      setState(() {
        emploiDuTemps.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data saved to Firestore successfully'),
      ));
    } catch (e) {
      print('Error saving data to Firestore: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error saving data to Firestore'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Form Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nomController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: prenomController,
                decoration: InputDecoration(labelText: 'Prénom'),
              ),
              TextField(
                controller: etablissementController,
                decoration: InputDecoration(labelText: 'Etablissement'),
              ),
              TextField(
                controller: numeroTelController,
                decoration: InputDecoration(labelText: 'Numéro de téléphone'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: lieuNaissanceController,
                decoration:
                    InputDecoration(labelText: 'date et Lieu de naissance'),
              ),
              TextField(
                controller: diplomeController,
                decoration: InputDecoration(labelText: 'Diplôme obtenu'),
              ),
              TextField(
                controller: anneeDiplomeController,
                decoration:
                    InputDecoration(labelText: 'Année d\'obtention du diplôme'),
              ),
              TextField(
                controller: gradeController,
                decoration: InputDecoration(labelText: 'Grade'),
              ),
              TextField(
                controller: dateDerniereVisiteController,
                decoration:
                    InputDecoration(labelText: 'Date de la dernière visite'),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (selectedDate != null) {
                    dateDerniereVisiteController.text =
                        selectedDate.toLocal().toString().split(' ')[0];
                  }
                },
              ),
               TextField(
                controller:notelastController,
                decoration: InputDecoration(labelText: 'Dernière note d\'inspection'),
              ),
              SizedBox(height: 20),
              Text('Emploi du Temps:'),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TimeSlotDialog(
                        onTimeSlotAdded: (TimeSlot timeSlot) {
                          setState(() {
                            emploiDuTemps.add(timeSlot);
                          });
                          //  Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
                child: Text('Ajouter un créneau horaire'),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: emploiDuTemps.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Créneau ${index + 1}'),
                    subtitle: Text(
                        'De ${emploiDuTemps[index].heureDebut} à ${emploiDuTemps[index].heureFin}'),
                    trailing: Text(
                        'Jour: ${emploiDuTemps[index].jour}, Classe: ${emploiDuTemps[index].classeEnseignee}'),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  saveDataToFirestore();
                },
                child: Text('Enregistrer dans Firestore'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeSlot {
  String heureDebut;
  String heureFin;
  String jour;
  String classeEnseignee;

  TimeSlot(
      {required this.heureDebut,
      required this.heureFin,
      required this.jour,
      required this.classeEnseignee});
}

class TimeSlotDialog extends StatefulWidget {
  final Function(TimeSlot) onTimeSlotAdded;

  TimeSlotDialog({required this.onTimeSlotAdded});

  @override
  _TimeSlotDialogState createState() => _TimeSlotDialogState();
}

class _TimeSlotDialogState extends State<TimeSlotDialog> {
  TextEditingController heureDebutController = TextEditingController();
  TextEditingController heureFinController = TextEditingController();
  TextEditingController jourController = TextEditingController();
  TextEditingController classeEnseigneeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ajouter un créneau horaire'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: heureDebutController,
              decoration: InputDecoration(labelText: 'Heure de début'),
            ),
            TextField(
              controller: heureFinController,
              decoration: InputDecoration(labelText: 'Heure de fin'),
            ),
            TextField(
              controller: jourController,
              decoration: InputDecoration(labelText: 'Jour'),
            ),
            TextField(
              controller: classeEnseigneeController,
              decoration: InputDecoration(labelText: 'Classe enseignée'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Annuler'),
        ),
        TextButton(
          onPressed: () {
            String heureDebut = heureDebutController.text;
            String heureFin = heureFinController.text;
            String jour = jourController.text;
            String classeEnseignee = classeEnseigneeController.text;

            if (heureDebut.isNotEmpty &&
                heureFin.isNotEmpty &&
                jour.isNotEmpty &&
                classeEnseignee.isNotEmpty) {
              TimeSlot timeSlot = TimeSlot(
                  heureDebut: heureDebut,
                  heureFin: heureFin,
                  jour: jour,
                  classeEnseignee: classeEnseignee);
              widget.onTimeSlotAdded(timeSlot);
            }

            Navigator.of(context).pop();
          },
          child: Text('Ajouter'),
        ),
      ],
    );
  }
}
