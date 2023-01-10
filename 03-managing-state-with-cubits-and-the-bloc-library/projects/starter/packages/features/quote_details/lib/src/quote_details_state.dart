part of 'quote_details_cubit.dart';

abstract class QuoteDetailsState extends Equatable {}

class QuoteDetailsInProgress extends QuoteDetailsState {
  @override
  List<Object?> get props => [];
}

class QuoteDetailsSuccess extends QuoteDetailsState {
  QuoteDetailsSuccess({
    required this.quote,
    this.quoteUpdateError,
  });

  final Quote quote;
  final dynamic quoteUpdateError;

  @override
  List<Object?> get props => [
        quote,
        quoteUpdateError,
      ];
}

class QuoteDetailsFailure extends QuoteDetailsState {
  @override
  List<Object?> get props => [];
}
