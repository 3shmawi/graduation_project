import 'package:donation/presentation/layout/home/search/view_model.dart';
import 'package:donation/presentation/layout/home/view.dart';
import 'package:donation/presentation/layout/home/view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../app/global_imports.dart';
import '../../../_resources/component/empty_page.dart';
import '../../../_resources/component/loading_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0))
        .then((value) => context.read<SearchVM>().searchInitialize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchBar(),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // suggestion text

            Padding(
              padding: const EdgeInsets.only(
                top: AppPadding.p12,
                left: AppPadding.p14,
                bottom: AppPadding.p6,
                right: AppPadding.p14,
              ),
              child: Text(
                context.watch<SearchVM>().searchStarted == false
                    ? AppStrings.recentSearch
                    : AppStrings.weHaveFound,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.labelMedium,
              ).tr(),
            ),
            context.watch<SearchVM>().searchStarted == false
                ? const SuggestionsUI()
                : const AfterSearchUI()
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
      ),
      child: TextFormField(
        autofocus: true,
        controller: context.watch<SearchVM>().textFieldCtrl,
        style: Theme.of(context).textTheme.displayMedium,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: AppStrings.search.tr(),
          hintStyle: Theme.of(context).textTheme.labelSmall,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p8, vertical: AppPadding.p12),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.close,
              size: AppSize.s25,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              context.read<SearchVM>().searchInitialize();
            },
          ),
        ),
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) {
          if (value == '') {
            // openSnacbar(context, 'Type something!');
          } else {
            context.read<SearchVM>().setSearchText(value);
            context.read<SearchVM>().addToSearchList(value);
          }
        },
      ),
    );
  }
}

class SuggestionsUI extends StatelessWidget {
  const SuggestionsUI({super.key});

  @override
  Widget build(BuildContext context) {
    final sb = context.watch<SearchVM>();
    return Expanded(
      child: sb.recentSearchData.isEmpty
          ? const EmptyPage(
              icon: Feather.search,
              message: AppStrings.search,
              message1: AppStrings.searchDesc,
            )
          : ListView.separated(
              padding: const EdgeInsets.all(15),
              itemCount: sb.recentSearchData.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: AppHeight.h8,
              ),
              itemBuilder: (BuildContext context, int index) {
                int reverseIndex = sb.recentSearchData.length - 1 - index;
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                  ),
                  child: ListTile(
                    title: Text(
                      sb.recentSearchData[reverseIndex],
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    leading: Icon(
                      CupertinoIcons.time_solid,
                      color: Colors.grey[400],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<SearchVM>().removeFromSearchList(
                            sb.recentSearchData[reverseIndex]);
                      },
                    ),
                    onTap: () {
                      context
                          .read<SearchVM>()
                          .setSearchText(sb.recentSearchData[reverseIndex]);
                    },
                  ),
                );
              },
            ),
    );
  }
}

class AfterSearchUI extends StatelessWidget {
  const AfterSearchUI({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCtrl, HomeStates>(
      buildWhen: (_, current) => current is GetPostsLoadedState,
      builder: (context, state) {
        return Expanded(
          child: FutureBuilder(
            future: context
                .watch<SearchVM>()
                .getData(context.read<HomeCtrl>().posts),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return const EmptyPage(
                    icon: Feather.clipboard,
                    message: AppStrings.noResults,
                    message1: AppStrings.tryAgain,
                  );
                } else {
                  return ListView.separated(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    itemCount: snapshot.data.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: AppHeight.h14,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return SocialPostItem(snapshot.data[index]);
                    },
                  );
                }
              }
              return ListView.separated(
                padding: const EdgeInsets.all(15),
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: AppHeight.h14,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return const LoadingCard(height: AppHeight.h110);
                },
              );
            },
          ),
        );
      },
    );
  }
}
