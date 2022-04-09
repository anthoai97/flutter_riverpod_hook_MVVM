import 'package:dayaway_partner/data/repository/booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bookingDetailViewModel =
    ChangeNotifierProvider((ref) => BookingDetailViewModel(ref.read));

class BookingDetailViewModel extends ChangeNotifier {
  final Reader _reader;

  BookingDetailViewModel(this._reader);

  late final BookingRepositoryImpl _bookingRepositoryImpl =
      _reader(bookingRepositoryImplProvider);

  Future<void> hotelBookingInformation(String id) async {
    var filter = {
      'id': id,
      'hotelCode': 'PAYOUT',
    };

    _bookingRepositoryImpl.hotelBookingInformation(filter).then((value) {
      value.map(success: (success) {
        print(success.data);
      }, failure: (error) {
        print(error.error.message);
      });
    });
  }
}
