import 'package:logging/logging.dart';

abstract class Repository_Base {
  final log = Logger('Repository');

  Future<void> init();
}
