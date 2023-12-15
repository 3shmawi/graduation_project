import 'package:donation/app/global_imports.dart';
import 'package:package_info/package_info.dart';

class SettingVM extends Cubit<AppCubitStates> {
  SettingVM() : super(SettingInitState());

  String get appVersion => _appVersion;

  String get packageName => _packageName;

  String _appVersion = '0.0';

  String _packageName = '';

  void initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
    _packageName = packageInfo.packageName;
    emit(PackageInfoState());
  }
}
