import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glint_frontend/features/service/service_screen_cubit.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceScreenCubit>(
      create: (context) => ServiceScreenCubit(),
      child: BlocBuilder<ServiceScreenCubit, ServiceScreenState>(
        builder: (context, state) {
          return Center(
            child: GestureDetector(
              onTap: () {
                context.read<ServiceScreenCubit>().picImages();
              },
              child: Text(
                  'Service Screen, needed to hidden and released in next version'),
            ),
          );
        },
      ),
    );
  }
}
