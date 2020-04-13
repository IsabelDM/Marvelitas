import 'package:bloc/bloc.dart';
import 'package:gsimarvelitas/ui/busqueda_page.dart';
import 'package:gsimarvelitas/ui/configuracion.dart';
import 'package:gsimarvelitas/ui/login_page.dart';
import 'package:gsimarvelitas/ui/profile_page_design.dart';
import 'package:gsimarvelitas/ui/resultados.dart';
import 'package:gsimarvelitas/ui/lecturaPage.dart';

enum NavigationEvents {
  BusquedaPageClickedEvent,
  ConfiguracionClickedEvent,
  ProfilePageClickedEvent,
  ResultadosClickedEvent,
  LecturaPageCllickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => LoginPage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.BusquedaPageClickedEvent:
        yield BusquedaPage();
        break;
      case NavigationEvents.ConfiguracionClickedEvent:
        yield RutaConfiguracion();
        break;
      case NavigationEvents.ProfilePageClickedEvent:
        yield ProfilePageDesign();
        break;
      case NavigationEvents.ResultadosClickedEvent:
        yield Resultados();
        break;
          case NavigationEvents.LecturaPageCllickedEvent:
        yield EpubWidget();
        break;
    }
  }
}
