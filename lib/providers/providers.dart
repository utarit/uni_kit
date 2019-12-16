import 'package:provider/provider.dart';
import 'package:uni_kit/providers/deadline_provider.dart';
import 'package:uni_kit/providers/food_provider.dart';
import 'package:uni_kit/providers/medico_provider.dart';
import 'package:uni_kit/providers/pool_provider.dart';
import 'package:uni_kit/providers/ring_provider.dart';


List<SingleChildCloneableWidget> providers = [
  //FutureProvider(create: (_) => MedicoProvider().getMedicoData(),),
  StreamProvider(create: (_) => MedicoProvider().medicoStream(),),
  FutureProvider(create: (_) => FoodProvider().getFoodData(),),
  StreamProvider(create: (_) => RingProvider().ringStream(),),
  StreamProvider(create: (_) => PoolProvider().poolStream(),),
  //FutureProvider(create: (_) => DeadlineProvider().sortedDeadlines(),)
];