
import 'package:bloc/bloc.dart';
import 'package:gsimarvelitas/ui/busqueda_page.dart';
import 'package:gsimarvelitas/bloc/navigation_bloc.dart';
import 'package:gsimarvelitas/ui/profile_page_design.dart';
import 'package:gsimarvelitas/ui/resultados.dart';
import 'package:gsimarvelitas/ui/principal.dart';

enum NavigationEvents {
  DashboardClickedEvent,
  MessagesClickedEvent,
  UtilityClickedEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  final Function onMenuTap;

  NavigationBloc({this.onMenuTap});

  @override
  NavigationStates get initialState => PrincipalPage(
    onMenuTap: onMenuTap,
  );

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashboardClickedEvent:
        yield BusquedaPage(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.MessagesClickedEvent:
        yield Resultados(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.UtilityClickedEvent:
        yield ProfilePageDesign(
          onMenuTap: onMenuTap,
        );
        break;
    }
  }
}