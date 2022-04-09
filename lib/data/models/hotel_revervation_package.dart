import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotel_revervation_package.g.dart';
part 'hotel_revervation_package.freezed.dart';

@freezed
class HotelRevervationPackage with _$HotelRevervationPackage {
  factory HotelRevervationPackage({
    String? id,
    double? packageBasePrice,
    String? packageCode,
    String? packageDetails,
    String? packageHotelCxlPolicyCode,
    String? packageImgId,
    String? packageName,
    String? packageRoomTypeId,
    String? packageTermAndCondition,
    int? packageTimeslotEndHour,
    String? packageTimeslotName,
    int? packageTimeslotStartHour,
    String? reservationId,
  }) = _HotelRevervationPackage;

  factory HotelRevervationPackage.fromJson(Map<String, dynamic> json) =>
      _$HotelRevervationPackageFromJson(json);
}
