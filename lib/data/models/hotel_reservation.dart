import 'package:dayaway_partner/data/models/guest.dart';
import 'package:dayaway_partner/data/models/hotel_revervation_package.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotel_reservation.g.dart';
part 'hotel_reservation.freezed.dart';

@freezed
class HotelRevervation with _$HotelRevervation {
  factory HotelRevervation({
    double? balance,
    double? baseAmount,
    String? checkinDate,
    double? discountAmount,
    double? grossAmount,
    String? id,
    double? pricePaymentNow,
    HotelRevervationPackage? hotelReservationPackage,
    Guest? reservationGuest,
    String? reservationNumber,
    String? specialRequest,
    String? status,
  }) = _HotelRevervation;

  factory HotelRevervation.fromJson(Map<String, dynamic> json) =>
      _$HotelRevervationFromJson(json);
}
