import 'package:injectable/injectable.dart';
import 'package:saca/models/user.model.dart';

@lazySingleton
abstract class IUserStore {
  void setUser(User user);
}
