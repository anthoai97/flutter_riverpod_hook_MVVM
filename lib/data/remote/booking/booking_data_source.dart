import 'package:dayaway_partner/data/remote/dio_provider.dart';
import 'package:dayaway_partner/data/remote/responses/dayaway_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'booking_data_source.g.dart';

final bookingDataResourceProvider =
    Provider((ref) => BookingDataResource(ref.read));

@RestApi()
abstract class BookingDataResource {
  factory BookingDataResource(Reader reader) =>
      _BookingDataResource(reader(dioProvider));

  @POST('')
  Future<DayAwayResponse> hotelBookingInformation(
      @Body() Map<String, dynamic> body);
}
