import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reco_restaurant/core/functions/app_snackbar.dart';
import 'package:reco_restaurant/core/helper/app_regex.dart';
import 'package:reco_restaurant/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:reco_restaurant/features/home/presentation/bloc/home_bloc/home_state.dart';
import 'package:reco_restaurant/features/home/presentation/bloc/home_bloc/home_event.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:reco_restaurant/core/shared/widgets/item_card_widget/item_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Items'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.error != null) {
            AppSnackBar.showError(
              context,
              AppRegex.cleanFirebaseError(state.error!),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const SpinKitFadingCircle(
              color: Color(0xFFFF7A00),
              size: 55,
            );
          }

          final items = state.items;

          if (items.isEmpty) {
            return const Center(child: Text("No items found."));
          }
          return SmartRefresher(
            controller: _refreshController,
            onRefresh: () async {
              context.read<HomeBloc>().add(RefreshItemsEvent());
              _refreshController.refreshCompleted();
            },
            header: CustomHeader(
              builder: (context, mode) {
                return const Center(
                  child: SpinKitFadingCircle(
                    color: Color(0xFFFF7A00),
                    size: 40,
                  ),
                );
              },
            ),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ItemCard(item: item);
              },
            ),
          );
        },
      ),
    );
  }
}
