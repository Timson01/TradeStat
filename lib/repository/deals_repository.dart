import 'package:trade_stat/database_helper/database_helper.dart';
import 'package:trade_stat/models/image_path.dart';

import '../models/deal.dart';

class DealsRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<Deal> addDeal(Deal deal) async{
    Deal response = await _databaseHelper.createDeal(deal);
    return response;
  }

  Future<List<Deal>> getDeals() async{
    List<Deal> deals = await _databaseHelper.readAllDeals();
    return deals;
  }

  Future<int> updateDeal(Deal deal) async{
    int response = await _databaseHelper.update(deal: deal);
    return response;
  }

  Future<int> deleteDeal({required int id}) async{
    int response = await _databaseHelper.delete(id: id);
    return response;
  }

  Future<DealImage> addDealImage(DealImage imagePath) async{
    DealImage response = await _databaseHelper.addImage(imagePath);
    return response;
  }

}