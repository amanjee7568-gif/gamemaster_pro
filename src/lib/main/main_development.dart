import 'package:my_app/main/bootstrap.dart';
import 'package:my_app/models/enums/flavor.dart';
import 'package:my_app/app/app.dart';

void main() {
  bootstrap(
    builder: () => const App(),
    flavor: Flavor.development,
  );
}
