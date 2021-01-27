import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saca/services/tts.service.dart';
import 'package:saca/view-models/category.viewmodel.dart';

import 'repositories/category.repository.dart';
import 'repositories/image.repository.dart';
import 'repositories/user.repository.dart';
import 'notifiers/category.notifier.dart';
import 'notifiers/session.notifier.dart';
import 'notifiers/user.notifier.dart';

final userStateNotifier = StateNotifierProvider((ref) => UserStateNotifier());

final sessionNotifier = StateNotifierProvider(
    (ref) => SessionStore(ref.read(userStateNotifier), UserRepository()));

final categoryNotifier = StateNotifierProvider(
  (ref) => CategoryStateNotifier(
    ref.read(userStateNotifier),
    CategoryRepository(),
    ImageRepository(),
    List<CategoryViewModel>.empty(),
  ),
);

final ttsProvider = Provider((ref) => TtsService());
