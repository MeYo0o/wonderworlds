import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_repository/quote_repository.dart';

part 'quote_details_state.dart';

class QuoteDetailsCubit extends Cubit<QuoteDetailsState> {
  QuoteDetailsCubit({
    required this.quoteId,
    required this.quoteRepository,
  }) : super(
          // 2
          QuoteDetailsInProgress(),
        ) {
    _fetchQuoteDetails();
  }
  final int quoteId;
  // 3
  final QuoteRepository quoteRepository;
  void _fetchQuoteDetails() async {
    try {
      final quote = await quoteRepository.getQuoteDetails(quoteId);

      emit(
        QuoteDetailsSuccess(quote: quote),
      );
    } catch (_) {
      emit(
        QuoteDetailsFailure(),
      );
    }
  }

  void refetch() async {
    emit(
      QuoteDetailsInProgress(),
    );

    _fetchQuoteDetails();
  }

  void upvoteQuote() async {
    try {
      final updatedQuote = await quoteRepository.upvoteQuote(quoteId);

      emit(
        QuoteDetailsSuccess(
          quote: updatedQuote,
        ),
      );
    } catch (e) {
      final lastState = state;

      if (lastState is QuoteDetailsSuccess) {
        emit(
          QuoteDetailsSuccess(
            quote: lastState.quote,
            quoteUpdateError: e,
          ),
        );
      }
    }
  }

  void downvoteQuote() async {
    // TODO: Challenge.
  }
  void unvoteQuote() async {
    // TODO: Challenge.
  }
  void favoriteQuote() async {
    // TODO: Challenge.
  }
  void unfavoriteQuote() async {
    // TODO: Challenge.
  }
}
