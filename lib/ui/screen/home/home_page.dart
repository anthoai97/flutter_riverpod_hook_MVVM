import 'package:auto_route/auto_route.dart';
import 'package:dayaway_partner/gen/assets.gen.dart';
import 'package:dayaway_partner/ui/component/image/image_widget.dart';
import 'package:dayaway_partner/ui/hook/use_l10n.dart';
import 'package:dayaway_partner/ui/hook/use_router.dart';
import 'package:dayaway_partner/ui/routes/app_route.dart';
import 'package:dayaway_partner/ui/routes/app_route.gr.dart';
import 'package:dayaway_partner/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final router = useRouter();

    Widget _buildTabItem({
      required Function() onTapItem,
      required String label,
      required String iconsPath,
      bool active = false,
    }) {
      Color color = active ? theme.appColors.accent : theme.appColors.primary70;
      double iconSize = 20;
      return Expanded(
        flex: 2,
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.white,
              onTap: onTapItem,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ImgView.asset(iconsPath,
                        width: iconSize, height: iconSize, color: color),
                    const SizedBox(height: 4),
                    Text(
                      label,
                      style: theme.textTheme.h10.copyWith(color: color),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return AutoTabsScaffold(
      routes: const [
        DashboardRoute(),
        BookingRoute(),
        ExperienceRoute(),
        ProfileRoute()
      ],
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () => router.push(
            BookingDetailRoute(id: 'f8bc3fa1-ee02-4a1e-aafb-576afb6bb2d4')),
        backgroundColor: theme.appColors.accent,
        child: Container(
          alignment: Alignment.center,
          child: ImgView.asset(
            Assets.images.qrCodeScan.path,
            color: Colors.white,
            width: 35,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTabItem(
                iconsPath: Assets.svgs.icDashboard.path,
                active: tabsRouter.current.name == DashboardRoute.name,
                label: l10n.dashboard,
                onTapItem: () {
                  tabsRouter.setActiveIndex(0);
                },
              ),
              _buildTabItem(
                iconsPath: Assets.svgs.icBooking.path,
                active: tabsRouter.current.name == BookingRoute.name,
                label: l10n.booking,
                onTapItem: () {
                  tabsRouter.setActiveIndex(1);
                },
              ),
              const Spacer(),
              _buildTabItem(
                iconsPath: Assets.svgs.icExperience.path,
                active: tabsRouter.current.name == ExperienceRoute.name,
                label: l10n.experience,
                onTapItem: () {
                  tabsRouter.setActiveIndex(2);
                },
              ),
              _buildTabItem(
                iconsPath: Assets.svgs.icSetting.path,
                active: tabsRouter.current.name == ProfileRoute.name,
                label: l10n.setting,
                onTapItem: () {
                  tabsRouter.setActiveIndex(3);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
