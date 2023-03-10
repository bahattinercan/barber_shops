import 'package:barbers/enums/user.dart';
import 'package:barbers/utils/app_manager.dart';

class Authorization {
  static bool authority = false;

  static bool get isAdmin {
    return AppManager.user.getType == EUser.admin;
  }

  static bool get isWorker {
    return AppManager.user.getType == EUser.worker;
  }

  static bool get isBoss {
    return AppManager.user.getType == EUser.boss;
  }

  static bool get isNormal {
    return AppManager.user.getType == EUser.normal;
  }
}
