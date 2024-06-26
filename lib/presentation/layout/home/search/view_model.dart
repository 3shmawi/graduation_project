import 'package:donation/app/global_imports.dart';
import 'package:donation/domain/model/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchVM extends Cubit<AppCubitStates> {
  SearchVM() : super(SearchInitState());

  List<String> _recentSearchData = [];

  List<String> get recentSearchData => _recentSearchData;

  String _searchText = '';

  String get searchText => _searchText;

  bool _searchStarted = false;

  bool get searchStarted => _searchStarted;

  final TextEditingController _textFieldCtrl = TextEditingController();

  TextEditingController get textFieldCtrl => _textFieldCtrl;

  Future getRecentSearchList() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchData = sp.getStringList('recent_search_data') ?? [];
    emit(GetRecentSearchListState());
  }

  Future addToSearchList(String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchData.add(value);
    await sp.setStringList('recent_search_data', _recentSearchData);
    emit(AddToSearchListState());
  }

  Future removeFromSearchList(String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchData.remove(value);
    await sp.setStringList('recent_search_data', _recentSearchData);
    emit(RemoveFromSearchListState());
  }

  Future<List> getData(List<Document> posts) async {
    return posts
        .where((post) =>
            post.content!.toLowerCase().contains(_searchText.toLowerCase()) ||
            post.userID!.userName!
                .toLowerCase()
                .contains(_searchText.toLowerCase()))
        .toList();
  }

  setSearchText(value) {
    _textFieldCtrl.text = value;
    _searchText = value;
    _searchStarted = true;
    emit(SetSearchTxtState());
  }

  searchInitialize() {
    _textFieldCtrl.clear();
    _searchStarted = false;
    emit(SettingInitState());
  }
}
