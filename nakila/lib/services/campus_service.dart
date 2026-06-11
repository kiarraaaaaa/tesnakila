import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/campus_model.dart';

class CampusService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> addCampus(
    CampusModel campus,
  ) async {

    await _firestore
        .collection("campuses")
        .doc(campus.id)
        .set(
          campus.toMap(),
        );
  }

  Future<void> deleteCampus(
    String campusId,
  ) async {

    await _firestore
        .collection("campuses")
        .doc(campusId)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
      getCampuses() {

    return _firestore
        .collection("campuses")
        .snapshots();
  }

  static CampusModel getCampusById(
    String id,
  ) {

    final campuses = [

      CampusModel(
        id: "harvard",
        name: "Harvard University",
        image:
            "assets/Additional/Harvard.jpg",
        location: "Cambridge",
        country: "United States",
        rating: 4.9,
        verified: true,
        foundedYear: "1636",
        worldRanking: "#4",
        description:
            "Harvard University is one of the most prestigious universities in the world.",
        history:
            "Founded in 1636, Harvard is the oldest institution of higher education in the United States.",
        achievements: [
          "161 Nobel Prize Winners",
          "8 US Presidents",
          "Global Research Excellence",
        ],
        programs: [
          "Business",
          "Law",
          "Medicine",
          "Engineering",
        ],
      ),

      CampusModel(
        id: "oxford",
        name:
            "University of Oxford",
        image:
            "assets/Additional/Oxford.jpg",
        location: "Oxford",
        country:
            "United Kingdom",
        rating: 4.9,
        verified: true,
        foundedYear: "1096",
        worldRanking: "#1",
        description:
            "The University of Oxford is the oldest university in the English-speaking world.",
        history:
            "Oxford has been teaching students since 1096.",
        achievements: [
          "Nobel Laureates",
        ],
        programs: [
          "Law",
          "Medicine",
        ],
      ),

      CampusModel(
        id: "stanford",
        name:
            "Stanford University",
        image:
            "assets/Additional/Stanford.jpg",
        location:
            "California",
        country:
            "United States",
        rating: 4.8,
        verified: true,
        foundedYear: "1885",
        worldRanking: "#3",
        description:
            "Stanford is globally recognized.",
        history:
            "Founded in 1885.",
        achievements: [
          "Google Founders",
        ],
        programs: [
          "Computer Science",
        ],
      ),
    ];

    return campuses.firstWhere(
      (e) => e.id == id,
    );
  }
}