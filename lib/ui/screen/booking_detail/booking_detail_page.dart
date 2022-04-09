import 'package:dayaway_partner/ui/component/appbar/default_appbar.dart';
import 'package:dayaway_partner/ui/screen/booking_detail/booking_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookingDetailPage extends HookConsumerWidget {
  const BookingDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(bookingDetailViewModel);

    useEffect(() {
      viewModel.hotelBookingInformation(id);
      return null;
    }, []);

    return Scaffold(
      appBar: DayAwayAppBar.defaultAppBar(ref, title: "Booking information"),
    );
  }
}
