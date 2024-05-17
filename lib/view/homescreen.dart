import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mvvm/viewmodel/userviewmodel.dart';

import '../data/response/status.dart';
import '../viewmodel/homeviewmodel.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  final userController = UserViewModel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(moviesListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () async {
              userController
                  .removeUser()
                  .then((value) => context.go('/loginScreen'));
            },
            child: const Center(child: Text("Logout")),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: data.when(data: (data) {

        print(data.movies);
        return ListView.builder(
            itemCount: data.movies!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(
                  data.movies![index].posterPath
                      .toString(),
                  errorBuilder: (context, error, stack) {
                    return const Icon(
                      Icons.error,
                      color: Colors.red,
                    );
                  },
                  height: 60,
                  width: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(data.movies![index].originalTitle!),
                subtitle: Text(
                  data.movies![index].overview!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            });
      }, error: ((error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      }), loading: (() {
        return Center(
          child: CircularProgressIndicator(),
        );
      })),
    );
  }
}

