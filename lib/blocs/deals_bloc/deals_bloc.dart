import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/models/image_path.dart';
import 'package:trade_stat/repository/deals_repository.dart';

import '../../models/deal.dart';

part 'deals_event.dart';
part 'deals_state.dart';

class DealsBloc extends HydratedBloc<DealsEvent, DealsState> {
  final DealsRepository dealsRepository;

  DealsBloc({required this.dealsRepository}) : super(DealsState(
      hashtags: const <String>['Add a new hashtag'],
  )) {
    on<AddDeal>(_onAddDeal);
    on<UpdateDeal>(_onUpdateDeal);
    on<FetchDeals>(_onFetchDeals);
    on<FetchDealsWithDate>(_onFetchDealsWithDate);
    on<DeleteDeal>(_onDeleteDeal);
    on<DeleteDealByHashtag>(_deleteDealByHashtag);
    on<AddHashtag>(_onAddHashtag);
    on<DeleteHashtag>(_onDeleteHashtag);
    on<AddDealImage>(_onAddDealImage);
    on<DeleteDealImage>(_onDeleteDealImage);
    on<FetchPositiveDeals>(_onFetchPositiveDeals);
    on<FetchNegativeDeals>(_onFetchNegativeDeals);
  }

  FutureOr<void> _onAddDeal(AddDeal event, Emitter<DealsState> emit) async {
    var deal = await dealsRepository.addDeal(event.deal);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("lastId", deal.id!);
    emit(DealsState(
        hashtags: List.from(state.hashtags),
      deals: state.deals,
    ));
    add(const FetchDeals());
  }

  FutureOr<void> _onUpdateDeal(
      UpdateDeal event, Emitter<DealsState> emit) async {
    await dealsRepository.updateDeal(event.deal);
    add(const FetchDeals());
  }

  FutureOr<void> _onFetchDeals(
      FetchDeals event, Emitter<DealsState> emit) async {
    List<Deal> deals = await dealsRepository.getDeals();
    emit(DealsState(
        hashtags: List.from(state.hashtags),
        deals: deals,
    ));
  }

  FutureOr<void> _onFetchDealsWithDate(
      FetchDealsWithDate event, Emitter<DealsState> emit) async {
    List<Deal> deals = await dealsRepository.getDealsWithDate(event.startDate, event.endDate);
    emit(DealsState(
        hashtags: List.from(state.hashtags),
        deals: deals
    ));
  }

  FutureOr<void> _onFetchPositiveDeals(
      FetchPositiveDeals event, Emitter<DealsState> emit) async {
    List<Deal> deals = await dealsRepository.getPositiveDeals(event.startDate, event.endDate);
    emit(DealsState(
        hashtags: List.from(state.hashtags),
        deals: deals
    ));
  }

  FutureOr<void> _onFetchNegativeDeals(
      FetchNegativeDeals event, Emitter<DealsState> emit) async {
    List<Deal> deals = await dealsRepository.getNegativeDeals(event.startDate, event.endDate);
    emit(DealsState(
        hashtags: List.from(state.hashtags),
        deals: deals
    ));
  }

  FutureOr<void> _onDeleteDeal(DeleteDeal event, Emitter<DealsState> emit) async {
    await dealsRepository.deleteDeal(id: event.id);
    add(const FetchDeals());
  }

  FutureOr<void> _deleteDealByHashtag(DeleteDealByHashtag event, Emitter<DealsState> emit) async {
    await dealsRepository.deleteDealByHashtag(hashtag: event.hashtag);
    add(const FetchDeals());
  }

  void _onAddHashtag(AddHashtag event, Emitter<DealsState> emit) {
    final state = this.state;
    List<String> hashtags  = List.from(state.hashtags);
    if(hashtags.contains(event.hashtag)){
      emit(DealsState(
          hashtags: List.from(state.hashtags)
      ));
    }else{
      hashtags.add(event.hashtag);
      emit(DealsState(
          hashtags: hashtags
      ));
    }
  }

  void _onDeleteHashtag(DeleteHashtag event, Emitter<DealsState> emit) {
    final state = this.state;
    List<String> hashtags = List.from(state.hashtags);
    hashtags.remove(event.hashtag);
    emit(DealsState(
        hashtags: hashtags
    ));
  }

  FutureOr<void> _onAddDealImage(AddDealImage event, Emitter<DealsState> emit) async {
    await dealsRepository.addDealImage(event.imagePath);
  }

  FutureOr<void> _onDeleteDealImage(DeleteDealImage event, Emitter<DealsState> emit) async {
    await dealsRepository.deleteDealImage(id: event.id);
  }

  @override
  DealsState? fromJson(Map<String, dynamic> json) {
    return DealsState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(DealsState state) {
    return state.toMap();
  }

}
