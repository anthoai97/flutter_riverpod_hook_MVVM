import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

@freezed
class DayAwayResponse with _$DayAwayResponse {
  factory DayAwayResponse({dynamic data}) = _DayAwayResponse;

  factory DayAwayResponse.fromJson(Map<String, dynamic> json) =>
      _$DayAwayResponseFromJson(json);
}
