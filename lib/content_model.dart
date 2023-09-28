class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Bienvenue sur'
      'Med Connect Pro',
      image: 'images/Group.svg',
      discription: "L'outil ultime pour les gynécologues et les professionnels de la santé. "
     " Med Connect Pro est conçu pour simplifier" 
      "la gestion de vos patients et améliorer votre pratique."),
           
  UnbordingContent(
      title: 'Gérez les Dossiers Patients Facilement',
      image: 'images/dossier.svg',
      discription:
          "Stockez et accédez facilement aux dossiers patients, "
          "à l'historique médical et aux plans de traitement. "
          "Moins de temps passé sur la paperasse, plus de temps consacré à vos patients."),
  UnbordingContent(
      title: 'Des Antécédents Médicaux Complets',
      image: 'images/gynecologue.svg',
      discription:
          "Accédez à des historiques médicaux détaillés et suivez l'évolution de vos  "
          "patients dans le temps. Prenez des décisions éclairées pour une meilleure prise en charge des patients."
       ),
];
