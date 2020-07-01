

import 'package:async_redux/async_redux.dart';
import 'models/app_state.dart';


final Store store = new Store<AppState>(
  initialState: AppState.initialState(),
  actionObservers: [Log.printer(formatter: Log.verySimpleFormatter)],
  modelObserver: DefaultModelObserver(),
);
