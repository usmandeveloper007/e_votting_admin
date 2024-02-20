import 'package:e_voting_admin/Services/firestore_services.dart';
import 'package:e_voting_admin/Widgets/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../Model/city_party_model.dart';
import '../Model/election_model.dart';

class DashboardController extends GetxController {
   TextEditingController cityNameCont =  TextEditingController();
   TextEditingController partyNameCont =  TextEditingController();

  var nADate = Rxn<String>();
  var nAStartTime = Rxn<String>();
  var nAEndTime = Rxn<String>();
  var pADate = Rxn<String>();
  var pAStartTime = Rxn<String>();
  var pAEndTime = Rxn<String>();
  RxBool loader = false.obs;

  var cityNameList = <String>[].obs;
  var partyNameList = <String>[].obs;

  addCityName()async{
    if(cityNameCont.text.isNotEmpty){
      cityNameList.add(
          cityNameCont.text
      );
      await updateName();
      cityNameList.refresh();
      cityNameCont.text='';
    }
  }
  addPartyName()async{
    if(partyNameCont.text.isNotEmpty){
      partyNameList.add(
          partyNameCont.text
      );
      await updateName();
      partyNameList.refresh();
      partyNameCont.text='';
    }
  }


  deleteCityName(String name)async{
    cityNameList.removeWhere((element) => element==name);
    await updateName();
    cityNameList.refresh();
  }

   deletePartyName(String name)async{
     partyNameList.removeWhere((element) => element==name);
     await updateName();
     partyNameList.refresh();
   }

   updateName()async {
     try{
       await FireStoreServices.updateCityPartyName(
           CityPartyModel(
               cities: cityNameList.value,
               parties: partyNameList.value,
           )
       );
     }catch(error){
       print(error.toString());
     }
   }

  RxString canFilter = "National Assembly".obs;
  RxString resFilter = "National Assembly".obs;

  distributeElectionData(List<ElectionModel> elections){
    for(var election in elections){
      if(election.type=="National Assembly"){
        nADate(election.modDate);
        nAStartTime(election.startTime);
        nAEndTime(election.endTime);
      }else if(election.type=="Provincial Assembly"){
        pADate(election.modDate);
        pAStartTime(election.startTime);
        pAEndTime(election.endTime);
      }else{
        print("Election type not matched");
      }
    }
  }

  setOrUpdateTime({required String type, String? startTime, String? endTime, String? date}) async {
    try{
      final election = ElectionModel(
        type: type,
        startTime: startTime,
        endTime: endTime,
        modDate: date,
      );
      await FireStoreServices.updateElectionTime(election);
      customDialog(Get.context!, "Success", "Time Saved Successfully");
    }catch (error){
      print(error.toString());
      customDialog(Get.context!, "Error", "Time Not Saved");
    }
  }

  deleteAllElectionData() async {
    try{
      print("++++++++++++++++++++++++");
      loader(true);
      await FireStoreServices.resetElectionData().then((value){
        if(value){
          nADate.value=null;
          nAStartTime.value=null;
          nAEndTime.value=null;
          pADate.value=null;
          pAStartTime.value=null;
          pAEndTime.value=null;
          loader(false);
        }
      });
    }catch (error){
      loader(false);
      print(error.toString());
      customDialog(Get.context!, "Error", "Data not reset");
    }
  }
}