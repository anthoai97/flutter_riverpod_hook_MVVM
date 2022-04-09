import 'package:dayaway_partner/data/models/guest.dart';
import 'package:dayaway_partner/data/models/hotel_reservation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking.freezed.dart';
part 'booking.g.dart';

@freezed
class Booking with _$Booking {
  factory Booking({
    String? arrivalTime,
    double? balance,
    String? bookingNumber,
    String? checkinDate,
    String? createdDate,
    Guest? guest,
    List<HotelRevervation>? hotelReservationList,
    String? id,
    String? note,
    double? pricePaymentNow,
    String? promoCode,
    String? specialRequest,
    String? status,
    double? totalBaseAmount,
    double? totalDiscountAmount,
    double? totalGrossAmount,
    double? totalRefundAmount,
    double? totalServiceFeeAmount,
    double? totalTaxAmount,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
}
