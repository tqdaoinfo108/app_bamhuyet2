import 'service_model.dart';

class ServiceBranchPartner {
  int branchID;
  int partnerID;

  List<LstServiceDetails> initData;
  ServiceBranchPartner({required this.branchID, required this.partnerID, required this.initData});
}
