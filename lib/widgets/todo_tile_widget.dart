import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/all_providers.dart';
import 'package:todo_app/providers/todo_list_manager.dart';
import 'package:todo_app/screens/detail_page.dart';
import 'package:todo_app/utils/app_colors.dart';

class TodoTileWidget extends ConsumerStatefulWidget {
  const TodoTileWidget({
    Key? key,
    required this.isDone,
    required this.task,
    required this.onTap,
    required this.id,
  }) : super(key: key);

  final bool isDone;
  final String task;
  final VoidCallback onTap;
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoTileWidgetState();
}

class _TodoTileWidgetState extends ConsumerState<TodoTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Colors.grey[200],
      shadowColor: AppColors.blueHaze,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        title: Flex(
          direction: Axis.vertical,
          children: 
            [Expanded(
              child: Text(
                widget.task,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.ebonyClay
                      ,
                    ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,

              ),
            ),
          ],
        ),
        trailing: GestureDetector(
          onTap: () {
            // 
            _toggleCheckbox(widget.id);
          },
          child: AnimatedCrossFade(
            
            firstChild: _uncheckedBox(),
            secondChild: _checkedBox(),
            crossFadeState:
                widget.isDone ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 400),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                id: widget.id,
              ),
            ),
          );
        


        },
      ),
    );
  }

  Container _uncheckedBox() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200],
        // colored border
        border: Border.all(
          color: Colors.orange,
          width: 2,
        ),
      ),
    );
  }

  Container _checkedBox() {
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.deepPurple,
      ),
      child: const Icon(
        Icons.check,
        color: Colors.white,
        size: 16,
      ),
    );
  }

  void _toggleCheckbox(String id) {
    
    ref.read(todoListProvider.notifier).toggleTodoItem(id);
  }
}
