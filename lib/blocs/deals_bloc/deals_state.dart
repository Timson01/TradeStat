part of 'deals_bloc.dart';

class DealsState extends Equatable {
  List<String> hashtags;
  final List<Deal> deals;

  DealsState({
    this.deals = const <Deal>[],
    required this.hashtags,
  });

  @override
  List<Object?> get props => [hashtags, deals];

  Map<String, dynamic> toMap() {
    return {
      'hashtags': hashtags,
      'deals': deals.map((e) => e.toMap()).toList(),
    };
  }

  factory DealsState.fromMap(Map<String, dynamic> map) {
    return DealsState(
      hashtags:
      List<String>.from(map['hashtags']),
      deals:
      List<Deal>.from(map['deals']?.map((x) => Deal.fromMap(x))),
    );
  }

}
