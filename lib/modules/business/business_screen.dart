import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';


class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var list = NewsCubit.get(context).business;

        return ScreenTypeLayout.builder(
          mobile: (context) {
            NewsCubit.get(context).setDesktop(false);
            return articleBuilder(list, context);
          },
          desktop: (context) {
            NewsCubit.get(context).setDesktop(true);
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: articleBuilder(list, context),
                ),
                if (list.isNotEmpty)
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Text(
                          '${list[NewsCubit.get(context).selectedBusinessItem]['description']}',
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
            breakpoints: ScreenBreakpoints(
                desktop: 850.0,
                tablet: 600.0,
                watch: 100.0,
            ),
        );
      },
    );
  }
}
