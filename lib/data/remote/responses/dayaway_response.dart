import 'package:freezed_annotation/freezed_annotation.dart';

part 'dayaway_response.g.dart';
part 'dayaway_response.freezed.dart';

@freezed
class DayAwayResponse with _$DayAwayResponse {
  factory DayAwayResponse({
    @DayAwayResponseConverter() @JsonKey(name: 'response') ResponseData? data,
  }) = _DayAwayResponse;

  factory DayAwayResponse.fromJson(Map<String, dynamic> json) =>
      _$DayAwayResponseFromJson(json['data'] ?? json);
}

@freezed
class ResponseData with _$ResponseData {
  factory ResponseData({
    int? count,
    int? totalPage,
    dynamic data,
  }) = _ResponseData;

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);
}

class DayAwayResponseConverter
    implements JsonConverter<ResponseData, Map<String, dynamic>> {
  const DayAwayResponseConverter();

  @override
  ResponseData fromJson(Map<String, dynamic> json) {
    return ResponseData.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ResponseData data) => data.toJson();
}
