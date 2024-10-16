import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/constants/dimensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String getGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 6 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 16) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Widget weatherCodeImages(int code) {
    switch (code) {
      case > 200 && <= 300:
        return Image.asset("assets/thunderstrom.png");
      case > 300 && <= 400:
        return Image.asset("assets/lightrain.png");
      case > 500 && <= 500:
        return Image.asset("assets/heavyrain.png");
      case > 600 && <= 700:
        return Image.asset("assets/snowfall.png");
      case > 800 && <= 900:
        return Image.asset("assets/cloudy.png");

      default:
        return Image.asset("assets/cloud.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 40 * Dimensions.widthP(context),
          vertical: 10 * Dimensions.widthP(context),
        ),
        child: SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(10, -0.3),
                child: Container(
                  height: 300 * Dimensions.heightF(context),
                  width: 300 * Dimensions.widthP(context),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 0, 255, 68),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-10, -0.3),
                child: Container(
                  height: 300 * Dimensions.heightF(context),
                  width: 300 * Dimensions.widthP(context),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 0, 255, 68),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300 * Dimensions.heightF(context),
                  width: 600 * Dimensions.widthP(context),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 223, 241, 17),
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoaded) {
                    return SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                              const Gap(10),
                              Text(
                                "${state.weather.areaName}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const Gap(10),
                          Text(
                            getGreeting(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 25),
                          ),
                          Center(
                            child: weatherCodeImages(
                                state.weather.weatherConditionCode!),
                          ),
                          Center(
                            child: Text(
                              "${state.weather.temperature!.celsius!.round()}°C",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Center(
                            child: Text(
                              state.weather.weatherMain!.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat('EEEE - dd/MM/yyyy -')
                                  .add_jm()
                                  .format(state.weather.date!),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          const Gap(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/sunIcon.png",
                                    height: 35,
                                    width: 35,
                                  ),
                                  const Gap(5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Sunrise",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        DateFormat('')
                                            .add_jm()
                                            .format(state.weather.sunrise!),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/moon.png",
                                    height: 35,
                                    width: 35,
                                    color: Colors.white,
                                  ),
                                  const Gap(5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Sunset" "     ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        DateFormat('')
                                            .add_jm()
                                            .format(state.weather.sunset!),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Gap(10),
                          const Divider(
                            color: Colors.grey,
                          ),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/maxTemp.png",
                                    height: 35,
                                    width: 35,
                                  ),
                                  const Gap(5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Max temp",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        "${state.weather.tempMax!.celsius!.round()}°C",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/minTemp.png",
                                    height: 35,
                                    width: 35,
                                  ),
                                  const Gap(5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Min temp",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        "${state.weather.tempMin!.celsius!.round()}°C",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("Fetch to load weather data"),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
