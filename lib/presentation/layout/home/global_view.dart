import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/_resources/component/empty_page.dart';
import 'package:donation/presentation/layout/home/view.dart';
import 'package:donation/presentation/layout/home/view_model.dart';

import '../../_resources/component/loading_card.dart';

class GlobalView extends StatelessWidget {
  const GlobalView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeCtrl>().getPosts();
      },
      child: BlocBuilder<HomeCtrl, HomeStates>(
        buildWhen: (_, current) =>
            current is GetPostsLoadingState ||
            current is GetPostsLoadedState ||
            current is GetPostsErrorState,
        builder: (context, state) {
          if (state is GetPostsLoadingState) {
            return ListView.builder(
              padding: const EdgeInsets.only(
                top: AppPadding.p20,
                right: AppPadding.p20,
                left: AppPadding.p20,
              ),
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: AppPadding.p20),
                  child: LoadingCard(height: AppSize.s200),
                );
              },
              itemCount: 5,
            );
          }
          if (state is GetPostsLoadedState) {
            return ListView.builder(
              padding: const EdgeInsets.only(
                top: AppPadding.p20,
                right: AppPadding.p20,
                left: AppPadding.p20,
              ),
              itemBuilder: (context, index) {
                return SocialPostItem(
                  state.posts[index],
                );
              },
              itemCount: state.posts.length,
            );
          }
          return EmptyPage(
            icon: Icons.post_add_outlined,
            message: "No Posts yet",
            message1: "refresh",
            onPressed: () {
              context.read<HomeCtrl>().getPosts();
            },
          );
        },
      ),
    );
  }
}
