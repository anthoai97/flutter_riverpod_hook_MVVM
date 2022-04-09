import 'package:dayaway_partner/data/models/booking.dart';
import 'package:dayaway_partner/data/models/result.dart';
import 'package:dayaway_partner/data/remote/booking/booking_data_source.dart';
import 'package:dayaway_partner/data/remote/booking/booking_query.dart';
import 'package:dayaway_partner/ui/provider/graphql_transform_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BookingRepository {
  Future<Result> hotelBookingInformation(Map<String, dynamic> filter);
}

final bookingRepositoryImplProvider =
    Provider((ref) => BookingRepositoryImpl(ref.read));

class BookingRepositoryImpl
    with GraphQLTransformer
    implements BookingRepository {
  BookingRepositoryImpl(this._reader);
  final Reader _reader;

  late final BookingDataResource _bookingDataResourceProvider =
      _reader(bookingDataResourceProvider);

  @override
  Future<Result<Booking>> hotelBookingInformation(Map<String, dynamic> filter) {
    return Result.guardFuture(() async {
      var resutl = await _bookingDataResourceProvider.hotelBookingInformation(
          query(BookingQuery.hotelBookingInformation, filter: filter));
      return Booking.fromJson(resutl.data?.data[0]);
    });
  }
}
