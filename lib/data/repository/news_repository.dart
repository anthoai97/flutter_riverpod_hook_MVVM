import 'dart:math';

import 'package:dayaway_partner/data/foundation/constants.dart';
import 'package:dayaway_partner/data/foundation/extentions/date_time.dart';
import 'package:dayaway_partner/data/models/news.dart';
import 'package:dayaway_partner/data/models/result.dart';
import 'package:dayaway_partner/data/remote/news_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class NewsRepository {
  Future<Result<News>> getNews();
}

final newsRepositoryProvider = Provider((ref) => NewsRepositoryImpl(ref.read));

class NewsRepositoryImpl implements NewsRepository {
  NewsRepositoryImpl(this._reader);

  final Reader _reader;

  late final NewsDataSource _dataSource = _reader(newsDataSourceProvider);

  @override
  Future<Result<News>> getNews() {
    return Result.guardFuture(
      () => _dataSource.getNews(
        query: ['anim', 'manga'][Random().nextInt(2)],
        // For checking reload.
        from: DateTime.now()
            .subtract(const Duration(days: 28))
            .toLocal()
            .formatYYYYMMdd(),
        apiKey: Constants.instance.apiKey,
      ),
    );
  }
}
