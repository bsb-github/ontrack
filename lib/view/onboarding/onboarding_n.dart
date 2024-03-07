import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ontrack/utils/color_resources.dart';
import 'package:ontrack/view/onboarding/tabs/connected_app.dart';
import 'package:ontrack/view/Home/home_page_collapse.dart';
import 'package:ontrack/view/onboarding/tabs/select_first_goal.dart';
import 'package:ontrack/view/onboarding/tabs/setup_plain.dart';
import 'package:ontrack/view_model/page/page_provider.dart';

var pageProvider = StateNotifierProvider<PageProvider, int>((ref) {
  return PageProvider();
});
var pagesListProvider =
    StateNotifierProvider<PagesListProvider, List<Widget>>((ref) {
  return PagesListProvider();
});

class Onboarding extends ConsumerWidget {
  static const String routeName = 'onboarding';
  // static const String connectRoute = '/connected_app';

  const Onboarding({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: const [
                ColorResources.gradientColor,
                Colors.black,
                Colors.black,
                Colors.black,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            // ref.read(pageProvider.notifier).decrement();
                            if (ref.read(pageProvider) > 0) {
                              ref.read(pageProvider.notifier).decrement();
                            } else {
                              if (context.canPop()) {
                                context.pop();
                              }
                            }
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: PageView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: ref.read(pagesListProvider).length,
                        itemBuilder: (context, index) => ref
                            .read(pagesListProvider)[ref.watch(pageProvider)],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
