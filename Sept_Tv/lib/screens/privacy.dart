import 'package:flutter/material.dart';
import 'package:sept_tv/screens/home.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff007CD3),
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return HomePage();
                }),
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Image.asset(
            'assets/logo.png',
            height: 40,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg2.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset('assets/logo.png'),
              ),
              Text(
                '''
POLITIQUE DE CONFIDENTIALITÉ
Ce texte regroupe la Politique de Confidentialité de aCAN Group et/ou de ses Partenaires concernant la collection et utilisation des données personnelles des utilisateurs à travers ses applications et plateformes Web mais ne s’y limite pas.
INTRODUCTION
Devant le développement des nouveaux outils de communication, il est nécessaire de porter une attention particulière à la protection de la vie privée. C’est pourquoi, nous nous engageons à respecter la confidentialité des renseignements personnels que nous collectons.
Avertissement : Le(s) Site(s) Web et Applications mobiles développés par aCAN Group vous permettent uniquement de bénéficier d’un contenu multimédia (TV en direct, radio en direct, Rattrapages émissions etc.) mis à disposition gratuitement par nos partenaires (les ayants droits).
COLLECTE DES DONNÉES PERSONNELLES
Nous ne collectons aucuns renseignements provenant des utilisateurs
·                         (Nom/ Prénom, Adresse électronique, Genre / Sexe, Age / Date de naissance,
·                         Données médicales/ Données de santé.
En cas de besoin de collecte de données personnelles, ce sera après que vous nous ayez donné votre consentement, notamment lors de votre première connexion. Les renseignements personnels que nous collecterons en cas de besoin sont recueillis au travers de formulaires et grâce à l’interactivité établie entre vous et notre site Web/Application mobile. Vos données ne sont en aucun cas transmises à des partenaires de aCAN Group. Enfin, nous n’utilisons pas de cookies pour réunir des informations vous concernant.
FICHIERS JOURNAUX
Lorsque vous utilisez notre Site web/Application mobile, nous collectons et stockons des informations dans les fichiers journaux de nos serveurs. Cela comprend :
La façon dont vous avez utilisé le service concerné, telles que vos requêtes de recherche.
Votre adresse IP.
Des données relatives aux événements liés à l’appareil que vous utilisez, tels que plantages, activité du système, paramètres du matériel, type et langue de votre navigateur, date et heure de la requête et URL de provenance.
FORMULAIRES ET INTÉRACTIVITÉ
Vos renseignements personnels sont collectés par le biais de formulaire, à savoir :
Formulaire d’inscription au site Web/Application mobile
Sondage d’opinion
Nous utilisons les renseignements ainsi collectés pour les finalités suivantes :
Statistiques
Contact
Gestion du site Web/Application mobile (présentation, organisation)
Vos renseignements sont également collectés par le biais de l’interactivité pouvant s’établir entre vous et notre site Web/Application mobile et ce, de la façon suivante :
Contact
Gestion du site Web/Application mobile (présentation, organisation)
Nous utilisons les renseignements ainsi collectés pour les finalités suivantes :
Forum ou aire de discussion
Commentaires
Correspondance
DROIT D’OPPOSITION ET DE RETRAIT
Nous nous engageons à vous offrir un droit d’opposition et de retrait quant à vos renseignements personnels.
Le droit d’opposition s’entend comme étant la possibilité offerte aux internautes de refuser que leurs renseignements personnels soient utilisés à certaines fins mentionnées lors de la collecte.
Le droit de retrait s’entend comme étant la possibilité offerte aux internautes de demander à ce que leurs renseignements personnels ne figurent plus, par exemple, dans une liste de diffusion.
DROIT D’ACCÈS
Nous nous engageons à reconnaître un droit d’accès et de rectification aux personnes concernées désireuses de consulter, modifier, voire radier les informations les concernant.
L’exercice de ce droit se fera par courrier à l’adresse :

DIVULGATION D’INFORMATIONS PERSONNELLES
Il peut nous arriver de transmettre vos informations personnelles à nos employés ou équipes techniques afin de gérer les comptes utilisateur, le site web/application mobile et les Services qui vous sont proposés. Toute divulgation de données personnelles sera strictement contrôlée et réalisée en accord avec les législations sénégalaises, mais aussi des pays depuis lesquels notre site web/application mobile est disponible.
Nous ne divulguons pas vos données personnelles à une tierce partie sans votre consentement et conformément à la loi en vigueur. Nous vous encourageons à consulter nos termes et conditions d’utilisation
SÉCURITÉ
Les renseignements personnels que nous collectons en cas de besoin sont conservés dans un environnement sécurisé. Les personnes travaillant pour nous sont tenues de respecter la confidentialité de vos informations. Pour assurer la sécurité de vos renseignements personnels, nous avons recours aux mesures suivantes :
Protocole SSL (Secure Sockets Layer)
Gestion des accès – personne autorisée
Gestion des accès – personne concernée
Logiciel de surveillance du réseau
Sauvegarde informatique
Développement de certificat numérique
Identifiant / mot de passe
Pare-feu (Firewalls)
Nous nous engageons à maintenir un haut degré de confidentialité en intégrant les dernières innovations technologiques permettant d’assurer la confidentialité de vos données. Toutefois, comme aucun mécanisme n’offre une sécurité maximale, une part de risque est toujours présente lorsque l’on utilise Internet pour transmettre des renseignements personnels.
LÉGISLATION
Nous nous engageons à respecter les dispositions législatives énoncées dans conformément à la législation du Sénégal et/ou des pays concernés.
MISES À JOUR
Les présentes Règles de confidentialité peuvent être amenées à changer, nous publierons toute modification des règles de confidentialité sur cette page et une notification vous sera envoyée afin de vous inciter à consulter les nouvelles règles en vigueur.)
  ''',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
