import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:uni_kit/features/dashboard/domain/providers/food_provider.dart';
import 'package:uni_kit/features/dashboard/domain/providers/medico_provider.dart';
import 'package:uni_kit/features/dashboard/domain/providers/pool_provider.dart';
import 'package:uni_kit/features/dashboard/domain/providers/ring_provider.dart';



List<SingleChildWidget> providers = [
  //FutureProvider(create: (_) => MedicoProvider().getMedicoData(),),
  StreamProvider(create: (_) => MedicoProvider().medicoStream(),),
  FutureProvider(create: (_) => FoodProvider().getFoodData(),),
  StreamProvider(create: (_) => RingProvider().ringStream(),),
  StreamProvider(create: (_) => PoolProvider().poolStream(),),
  //FutureProvider(create: (_) => DeadlineProvider().sortedDeadlines(),)
];