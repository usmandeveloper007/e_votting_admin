import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting_admin/Features/Dashboard/Model/election_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Features/Authentication/Models/user_model.dart';
import '../Features/Dashboard/Model/city_party_model.dart';
import 'firebase_exceptions.dart';

class FireStoreServices {
  static var usersCollection=FirebaseFirestore.instance.collection('Users');
  static var votesCollection=FirebaseFirestore.instance.collection('Votes');
  static var electionCollection=FirebaseFirestore.instance.collection('Election');
  static var cityPartyNamesCollection=FirebaseFirestore.instance.collection('CityPartyNames');
  static final auth = FirebaseAuth.instance;

 static Future<List<UserModel>> getAllUsers() async {
   try {
     List<UserModel> list=[];
     QuerySnapshot snapshot=await usersCollection.get();
     var docs=snapshot.docs;
     for(var doc in docs){
       list.add(UserModel.fromJson(doc.data() as Map<String,dynamic>));
     }
     return list;
   } on FirebaseException catch(firebase){
     throw FirebaseExceptions(firebase);
   }
   catch(e){
     throw e.toString();
   }
 }

  static Stream<List<UserModel>> getCandidatesStream() {
    final Query userQuery = usersCollection
        .where('userType', isEqualTo: "Candidate");
        // .where('isApproved', isEqualTo: true)
        // .where('electionType', isEqualTo: electionType)
        // .where('city', isEqualTo: cityName);

    return userQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromJson(data);
      }).toList();
    });
  }


  static Stream<List<UserModel>> getApprovedCandidatesStream() {
    final Query userQuery = usersCollection
        .where('userType', isEqualTo: "Candidate")
    .where('isApproved', isEqualTo: true);
    // .where('electionType', isEqualTo: electionType)
    // .where('city', isEqualTo: cityName);

    return userQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromJson(data);
      }).toList();
    });
  }

  static Stream<int> getVoteResultsStream({required String canId, required String electionType}) {
    final Query userQuery = votesCollection
        .where('electionType', isEqualTo: electionType)
        .where('votTo', isEqualTo: canId);

    return userQuery.snapshots().map((snapshot) {
      return snapshot.docs.length;
    });
  }

  static Stream<List<UserModel>> getVotersStream() {
    final Query userQuery = usersCollection
        .where('userType', isEqualTo: "Voter");
    // .where('isApproved', isEqualTo: true)
    // .where('electionType', isEqualTo: electionType)
    // .where('city', isEqualTo: cityName);

    return userQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromJson(data);
      }).toList();
    });
  }

  static Future<bool> updateCandidateStatus({required String uId, bool? approved}) async {
    try {
      final bool status = approved==true
          ? false
          : true;
      await usersCollection.doc(uId).update({
        "isApproved" : status
      });
      return true;
    }
    on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      print(e.toString());
      throw e.toString();
    }
  }

  static Stream<List<ElectionModel>> getElectionStream() {
    return electionCollection.snapshots().map((snapshot) {
      List<ElectionModel> elections = [];
      snapshot.docs.forEach((doc) {
        elections.add(ElectionModel.fromJson(doc.data()));
      });
      return elections;
    });
  }


  static Future<CityPartyModel?> getCityPartyNameStream() async {
    try {
      String userId = auth.currentUser!.uid;
      DocumentSnapshot documentSnapshot = await cityPartyNamesCollection.doc("cityPartyNames").get();
      if(documentSnapshot.data()!=null){
        CityPartyModel names = CityPartyModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
        return names;
      }else{
        return null;
      }

    }on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      throw e.toString();
    }
  }

  static Future<bool> updateElectionTime(ElectionModel election) async {
    try {
      await electionCollection.doc(election.type).set(election.toJson());
      return true;
    }
    on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<bool> updateCityPartyName(CityPartyModel cityParty) async {
    try {
      await cityPartyNamesCollection.doc("cityPartyNames").set(cityParty.toJson());
      return true;
    }
    on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      print(e.toString());
      throw e.toString();
    }
  }

  static Future<bool> resetElectionData() async {
    try {
      await electionCollection.get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs){
          ds.reference.delete();
        }
      });
      await votesCollection.get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs){
          ds.reference.delete();
        }
      });
      return true;
    }
    on FirebaseException catch(firebase){
      throw FirebaseExceptions(firebase);
    }
    catch(e){
      print(e.toString());
      throw e.toString();
    }
  }

}
