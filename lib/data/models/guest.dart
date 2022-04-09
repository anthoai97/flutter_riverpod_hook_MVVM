import 'package:freezed_annotation/freezed_annotation.dart';

part 'guest.freezed.dart';
part 'guest.g.dart';

@freezed
class Guest with _$Guest {
  factory Guest({
    String? emailAddress,
    String? firstName,
    bool? isReturningGuest,
    String? lastName,
    String? phoneNumber,
  }) = _Guest;

  factory Guest.fromJson(Map<String, dynamic> json) => _$GuestFromJson(json);
}
