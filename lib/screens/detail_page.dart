import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/all_providers.dart';
import 'package:todo_app/utils/app_colors.dart';
import '../models/todo.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage({
    this.todo,
    Key? key,
  }) : super(key: key);

  final Todo? todo;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();

    _displaySavedTask();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _addAndEditTodo(ref);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: _myAppBar(context, ref),
        body: Column(
          children: [
            // text field for input task
            _textField(context),
          ],
        ),
      ),
    );
  }

  AppBar _myAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      elevation: 0,
      title: Text(
        'My Task',
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.ebonyClay,
            ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          _addTodoAndPop(context, ref);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.darkLavender,
          size: 18,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _textEditingController.clear();
            });
          },
          icon: const Icon(
            Icons.delete_outline_rounded,
            color: AppColors.darkLavender,
            size: 20,
          ),
        ),
      ],
    );
  }

  //* Add todo and pop
  void _addTodoAndPop(BuildContext context, WidgetRef ref) {
    Navigator.pop(context);
    _addAndEditTodo(ref);
  }

  //* Add or edit todo
  void _addAndEditTodo(WidgetRef ref) {
    if (_textEditingController.text.trim().isNotEmpty) {
      // if id is null, add new todo
      // else update todo
      if (widget.todo == null) {
        ref.read(todoListProvider.notifier).addTodoItem(
              _textEditingController.text,
            );
      } else {
        ref.read(todoListProvider.notifier).editTodoItem(
              Todo(
                id: widget.todo!.id,
                task: _textEditingController.text,
                isDone: widget.todo!.isDone,
              ),
            );
      }
    }
  }

  //* Text field
  _textField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: _textEditingController,
        minLines: 1,
        maxLines: null,
        onChanged: (value) {
          setState(() {});
        },
        toolbarOptions: const ToolbarOptions(
          copy: true,
          cut: true,
          paste: true,
          selectAll: true,
        ),
        decoration: InputDecoration(
          border: // no border for text field
              OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: 'Type anything you want to do',
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: AppColors.fadedPurple,
              ),
          counterText: '${_textEditingController.text.length} Characters',
        ),
        autofocus: true,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: AppColors.ebonyClay,
            ),
      ),
    );
  }

  //* Display saved task if id is not null
  void _displaySavedTask() {
    if (widget.todo != null) {
      _textEditingController.text = ref
          .read(todoListProvider)
          .firstWhere((element) => element.id == widget.todo!.id)
          .task;
    }
  }
}
