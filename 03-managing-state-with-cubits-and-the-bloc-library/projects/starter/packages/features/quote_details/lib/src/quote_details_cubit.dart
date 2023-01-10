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
    _quoteDetailsAPIhelper(QuoteDetailsAPIHelper.upvote);
  }

  void downvoteQuote() async {
    _quoteDetailsAPIhelper(QuoteDetailsAPIHelper.downvote);
  }

  void unvoteQuote() async {
    _quoteDetailsAPIhelper(QuoteDetailsAPIHelper.unvote);
  }

  void favoriteQuote() async {
    _quoteDetailsAPIhelper(QuoteDetailsAPIHelper.favorite);
  }

  void unfavoriteQuote() async {
    _quoteDetailsAPIhelper(QuoteDetailsAPIHelper.unfavorite);
  }

  void _quoteDetailsAPIhelper(QuoteDetailsAPIHelper quoteDetailsAPIType) async {
    try {
      Quote updatedQuote;
      switch (quoteDetailsAPIType) {
        case QuoteDetailsAPIHelper.upvote:
          updatedQuote = await quoteRepository.upvoteQuote(quoteId);
          break;
        case QuoteDetailsAPIHelper.downvote:
          updatedQuote = await quoteRepository.downvoteQuote(quoteId);
          break;
        case QuoteDetailsAPIHelper.unvote:
          updatedQuote = await quoteRepository.unvoteQuote(quoteId);
          break;
        case QuoteDetailsAPIHelper.favorite:
          updatedQuote = await quoteRepository.favoriteQuote(quoteId);
          break;
        case QuoteDetailsAPIHelper.unfavorite:
          updatedQuote = await quoteRepository.unfavoriteQuote(quoteId);
          break;
      }

      emit(
        QuoteDetailsSuccess(quote: updatedQuote),
      );
    } catch (e) {
      final lastState = state;
      if (lastState is QuoteDetailsSuccess) {
        emit(QuoteDetailsSuccess(
          quote: lastState.quote,
          quoteUpdateError: e,
        ));
      }
    }
  }
}

enum QuoteDetailsAPIHelper {
  upvote,
  downvote,
  unvote,
  favorite,
  unfavorite,
}
