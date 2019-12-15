import 'package:provider/provider.dart';
import 'package:uni_kit/providers/food_provider.dart';
import 'package:uni_kit/providers/medico_provider.dart';


List<SingleChildCloneableWidget> providers = [
  FutureProvider(create: (_) => MedicoProvider().getMedicoData(),),
  FutureProvider(create: (_) => FoodProvider().getFoodData(),),
];