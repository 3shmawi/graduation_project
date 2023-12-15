abstract class AppCubitStates {}

//logic
class AppLogicInitState extends AppCubitStates {}

//dark theme
class ChangeDarkThemeState extends AppCubitStates {}
//language
class ChangeLanguageState extends AppCubitStates {}

//onboarding
class OnBoardInitState extends AppCubitStates {}

class ChangeOnBoardPageIndexState extends AppCubitStates {}

//layout
class LayoutInitState extends AppCubitStates {}

class ChangeLayoutPageIndexState extends AppCubitStates {}

//profile | setting
class SettingInitState extends AppCubitStates {}

class PackageInfoState extends AppCubitStates {}

//search
class SearchInitState extends AppCubitStates {}

class SetSearchTxtState extends AppCubitStates {}

class AddToSearchListState extends AppCubitStates {}

class RemoveFromSearchListState extends AppCubitStates {}

class GetRecentSearchListState extends AppCubitStates {}
