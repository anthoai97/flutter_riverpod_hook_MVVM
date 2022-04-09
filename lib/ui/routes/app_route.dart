import 'package:auto_route/auto_route.dart';
import 'package:dayaway_partner/ui/routes/route_guard.dart';
import 'package:dayaway_partner/ui/screen/booking/booking_page.dart';
import 'package:dayaway_partner/ui/screen/booking_detail/booking_detail_page.dart';
import 'package:dayaway_partner/ui/screen/dashboard/dashboard_page.dart';
import 'package:dayaway_partner/ui/screen/experience/experience_page.dart';
import 'package:dayaway_partner/ui/screen/home/home_page.dart';
import 'package:dayaway_partner/ui/screen/profile/profile_page.dart';
import 'package:dayaway_partner/ui/screen/qr_page/qr_page.dart';
import 'package:dayaway_partner/ui/screen/sign_in/sign_in_page.dart';
import 'package:dayaway_partner/ui/screen/splash/splash_screen.dart';

export 'app_route.gr.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  transitionsBuilder: TransitionsBuilders.fadeIn,
  durationInMilliseconds: 400,
  routes: <AutoRoute>[
    AutoRoute(
      page: SplashPage,
      path: '/',
      initial: true,
    ),
    AutoRoute(
      page: SignInPage,
      path: 'signIn',
    ),
    AutoRoute(
      page: HomePage,
      path: 'home',
      guards: [AuthGuard],
      children: [
        AutoRoute(
          path: 'dashboard',
          page: DashboardPage,
        ),
        AutoRoute(
          path: 'booking',
          page: BookingPage,
        ),
        AutoRoute(
          path: 'experience',
          page: ExperiencePage,
        ),
        AutoRoute(
          path: 'profile',
          page: ProfilePage,
        ),
      ],
    ),
    AutoRoute(
      path: 'qr',
      page: QRPage,
    ),
    AutoRoute(
      path: 'bookingDetail',
      page: BookingDetailPage,
    ),
  ],
)
class $AppRouter {}
