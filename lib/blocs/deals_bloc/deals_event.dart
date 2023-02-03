part of 'deals_bloc.dart';


abstract class DealsEvent extends Equatable {

  const DealsEvent();

  @override
  List<Object> get props => [];
}

// ------ AddDeal event --------

class AddDeal extends DealsEvent {
  final Deal deal;

  const AddDeal({
    required this.deal});

  @override
  List<Object> get props =>
      [
        deal
      ];
}

// ------ UpdateDeal event --------

class UpdateDeal extends DealsEvent {
  final Deal deal;

  const UpdateDeal({required this.deal});

  @override
  List<Object> get props => [deal];
}

// ------ FetchDeals event --------

class FetchDeals extends DealsEvent {
  const FetchDeals();

  @override
  List<Object> get props => [];
}

// ------ FetchDealsWithDate event --------

class FetchDealsWithDate extends DealsEvent {
  final int startDate;
  final int endDate;
  const FetchDealsWithDate({required this.startDate, required this.endDate});

  @override
  List<Object> get props => [startDate, endDate];
}

// ------ FetchPositiveDeals event --------

class FetchPositiveDeals extends DealsEvent {
  final int startDate;
  final int endDate;
  const FetchPositiveDeals({required this.startDate, required this.endDate});

  @override
  List<Object> get props => [startDate, endDate];
}

// ------ FetchNegativeDeals event --------

class FetchNegativeDeals extends DealsEvent {
  final int startDate;
  final int endDate;
  const FetchNegativeDeals({required this.startDate, required this.endDate});

  @override
  List<Object> get props => [startDate, endDate];
}

// ------ FetchDealsByPosition event --------

class FetchDealsByPosition extends DealsEvent {
  final int startDate;
  final int endDate;
  final String position;
  const FetchDealsByPosition({required this.startDate, required this.endDate, required this.position});

  @override
  List<Object> get props => [startDate, endDate, position];
}

// ------ DeleteDeal event --------

class DeleteDeal extends DealsEvent {
  final int id;

  const DeleteDeal({required this.id});

  @override
  List<Object> get props => [id];
}

// ------ DeleteDeal by Hashtag event --------

class UpdateDealDeletedHashtag extends DealsEvent {
  final String hashtag;

  const UpdateDealDeletedHashtag({required this.hashtag});

  @override
  List<Object> get props => [hashtag];
}

// ------ AddHashtag event ----------

class AddHashtag extends DealsEvent {

  final String hashtag;

  const AddHashtag({
    required this.hashtag
});

  @override
  List<Object> get props => [ hashtag ];
}

// ------ ChangeHashtags event ----------

class ChangeHashtags extends DealsEvent {

  final List<String> hashtags;

  const ChangeHashtags({
    required this.hashtags
  });

  @override
  List<Object> get props => [ hashtags ];
}

// ------ DeleteHashtag event ----------

class DeleteHashtag extends DealsEvent {

  final String hashtag;

  const DeleteHashtag({
    required this.hashtag
  });

  @override
  List<Object> get props => [ hashtag ];
}

// ------ AddDealImage event ----------

class AddDealImage extends DealsEvent {

  final DealImage imagePath;

  const AddDealImage({
    required this.imagePath
  });

  @override
  List<Object> get props => [ imagePath ];
}

// ------ DeleteDealImage event --------

class DeleteDealImage extends DealsEvent {
  final int id;

  const DeleteDealImage({required this.id});

  @override
  List<Object> get props => [id];
}

