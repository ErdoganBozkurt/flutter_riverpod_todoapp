import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/all_providers.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/widgets/todo_tile_widget.dart';
import 'package:lottie/lottie.dart';
import 'detail_page.dart';

class MainPage extends ConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List todoList = ref.watch(todoListProvider);
    String dayTimeName = ref.watch(dayTimeNameProvider);
    
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: addTaskButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Hey, Good \n$dayTimeName !',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.ebonyClay,
                    ),
                textAlign: TextAlign.start,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: remainTasksInfo(context, ref),
              ),
              if (todoList.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.network(
                          'https://assets3.lottiefiles.com/packages/lf20_8ptubsmp.json',
                          width: 200,
                          height: 200,
                        ),
                        Text(
                          'Any task to do today?',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.ebonyClay,
                                  ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 32,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(todoList[index].id),
                        onDismissed: (direction) {
                          ref
                              .read(todoListProvider.notifier)
                              .deleteTodoItem(todoList[index].id);
                        },
                        child: TodoTileWidget(
                          todo: todoList[index],
                          index: index,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
      
    );
  }

  ElevatedButton addTaskButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailPage(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 8,
        primary: Colors.deepPurple,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        padding: const EdgeInsets.all(20),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text('Add new task'),
      ),
    );
  }

  RichText remainTasksInfo(BuildContext context, WidgetRef ref) {
    // uncompleted tasks
    var uncompletedTasks = ref
        .watch(todoListProvider)
        .where((element) => !element.isDone)
        .toList();
    String remainTasks = uncompletedTasks.length.toString();
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'You have ',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.amethystSmoke,
              ),
        ),
        TextSpan(
          text: '$remainTasks tasks',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.cobaltBlue,
              ),
        ),
        TextSpan(
          text: ' to complete',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.amethystSmoke,
              ),
        ),
      ]),
    );
  }
}
