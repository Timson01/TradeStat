import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_stat/blocs/bloc_exports.dart';
import 'package:trade_stat/models/image_path.dart';
import 'package:trade_stat/repository/deals_repository.dart';

import '../../generated/locale_keys.g.dart';
import '../../models/deal.dart';

part 'deals_event.dart';
part 'deals_state.dart';

class DealsBloc extends HydratedBloc<DealsEvent, DealsState> {
  final DealsRepository dealsRepository;

  DealsBloc({required this.dealsRepository}) : super(DealsState(
      hashtags: <String>[LocaleKeys.add_hashtag.tr()],
  )) {
    on<AddDeal>(_onAddDeal);
    on<UpdateDeal>(_onUpdateDeal);
    on<FetchDeals>(_onFetchDeals);
    on<FetchDealsWithDate>(_onFetchDealsWithDate);
    on<DeleteDeal>(_onDeleteDeal);
    on<UpdateDealDeletedHashtag>(_updateDealDeletedHashtag);
    on<AddHashtag>(_onAddHashtag);
    on<ChangeHashtag>(_onChangeHashtag);
    on<DeleteHashtag>(_onDeleteHashtag);
    on<AddDealImage>(_onAddDealImage);
    on<DeleteDealImage>(_onDeleteDealImage);
    on<FetchPositiveDeals>(_onFetchPositiveDeals);
    on<FetchNegativeDeals>(_onFetchNegativeDeals);
    on<FetchDealsByPosition>(_onFetchDealsByPosition);
  }

  FutureOr<void> _onAddDeal(AddDeal event, Emitter<DealsState> emit) async {
    var deal = await dealsRepository.addDeal(event.deal);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("lastId", deal.id!);
    emit(DealsState(
        hashtags: List.from(state.hashtags),
      deals: state.deals,
    ));
    add(FetchDeals());
  }

  FutureOr<void> _onUpdateDeal(
      UpdateDeal event, Emitter<DealsState> emit) async {
    await dealsRepository.updateDeal(event.deal);
    add(FetchDeals());
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

  FutureOr<void> _onFetchDealsByPosition(
      FetchDealsByPosition event, Emitter<DealsState> emit) async {
    List<Deal> deals = await dealsRepository.getDealsByPosition(event.startDate, event.endDate, event.position);
    emit(DealsState(
        hashtags: List.from(state.hashtags),
        deals: deals
    ));
  }

  FutureOr<void> _onDeleteDeal(DeleteDeal event, Emitter<DealsState> emit) async {
    await dealsRepository.deleteDeal(id: event.id);
    add(FetchDeals());
  }

  FutureOr<void> _updateDealDeletedHashtag(UpdateDealDeletedHashtag event, Emitter<DealsState> emit) async {
    await dealsRepository.updateDealDeletedHashtag(hashtag: event.hashtag);
    add(FetchDeals());
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

  void _onChangeHashtag(ChangeHashtag event, Emitter<DealsState> emit) {
    List<String> hashtags = List.from(state.hashtags);
    hashtags[0] = event.hashtag;
    emit(DealsState(hashtags: hashtags));
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
