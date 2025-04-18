import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
// import 'package:weather_application/data/my_data.dart';

part 'weather_block_event.dart';
part 'weather_block_state.dart';



class WeatherBlockBloc extends Bloc<WeatherBlockEvent, WeatherBlockState> {
  WeatherBlockBloc() : super(WeatherBlockInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlockLoading());
      try {
        WeatherFactory wf = WeatherFactory('5677a775f5546114b63e0145a098432f', language: Language.ENGLISH);
        
        
        Weather weather = await wf.currentWeatherByLocation(
        event.position.latitude,
        event.position.longitude,  
        );
        if (kDebugMode) {
          print(weather);
        }
        emit(WeatherBlockSuccess(weather));
      } catch (e) {
        emit(WeatherBlockFailure());
      }
    });
  }
}
