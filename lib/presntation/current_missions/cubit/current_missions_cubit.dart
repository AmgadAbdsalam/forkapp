import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/presntation/current_missions/cubit/current_missions_state.dart';

class CurrentMissionsCubit extends Cubit<CurrentMissionsState> {
  CurrentMissionsCubit() : super(CurrentMissionsInitial());
}
