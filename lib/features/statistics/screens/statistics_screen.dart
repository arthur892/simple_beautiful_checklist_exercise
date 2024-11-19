import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/features/statistics/widgets/task_counter_card.dart';
import 'package:simple_beautiful_checklist_exercise/shared/database_repository.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({
    super.key,
    required this.repository,
  });

  final DatabaseRepository repository;

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int currentTaskCount = 0;

  void loadItemCount() async {
    int taskCount = await widget.repository.itemCount;

    if (taskCount != currentTaskCount) {
      setState(() {
        currentTaskCount = taskCount;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadItemCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task-Statistik"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            TaskCounterCard(taskCount: currentTaskCount),
          ],
        ),
      ),
    );
  }
}
