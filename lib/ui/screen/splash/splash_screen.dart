import 'package:dayaway_partner/gen/assets.gen.dart';
import 'package:dayaway_partner/ui/hook/use_async_effect.dart';
import 'package:dayaway_partner/ui/hook/use_router.dart';
import 'package:dayaway_partner/ui/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = useRouter();

    useAsyncEffect(() async {
      await Future.delayed(const Duration(seconds: 2));
      router.replace(const HomeRoute());
    }, () {
      print('Pop screen success');
    }, []);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Assets.images.dayawaySplash.image(
          width: 140,
          height: 140,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
