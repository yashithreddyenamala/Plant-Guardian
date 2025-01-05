import 'package:flutter/material.dart';

class RemainderScreen extends StatelessWidget {
  const RemainderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Weekly Progress"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildWeeklyProgress(),
            const SizedBox(height: 16),
            _buildTaskSection("Today's Tasks", Colors.lightBlue, [
              _buildTaskItem("Water your Succulent", "Due by 10:00 AM"),
              _buildTaskItem("Place your Fern in Sunlight", "Due by 12:00 PM"),
              _buildTaskItem("Place your Orchid in Shade", "Due by 3:00 PM"),
              _buildTaskItem("Fertilize your Pothos", "Due by end of the day"),
            ]),
            const SizedBox(height: 16),
            _buildTaskSection("Overdue Tasks", Colors.red, [
              _buildTaskItem("Water your Snake", "Due two days ago"),
              _buildTaskItem("Water your Pothos", "Due one day ago"),
            ]),
            const SizedBox(height: 16),
            _buildTaskSection("Upcoming Tasks", Colors.grey, [
              _buildTaskItem("Mist your Fern", "Due in 3 days"),
              _buildTaskItem("Place your Orchid in Sunlight", "Due in 4 days"),
              _buildTaskItem("Water your Succulent", "Due in a week"),
              _buildTaskItem("Water your Orchid", "Due in 9 days"),
              _buildTaskItem("Place your Snake in shade", "Due in 10 days"),
              _buildTaskItem("Fertilize your Pothos", "Due in 28 days"),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        return Column(
          children: [
            CircleAvatar(
              backgroundColor: index == 2 ? Colors.green : Colors.grey,
              child: Text(
                ["Su", "M", "Tu", "W", "Th", "F", "Sa"][index],
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTaskSection(String title, Color color, List<Widget> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Column(children: tasks),
      ],
    );
  }

  Widget _buildTaskItem(String taskTitle, String taskDue) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/plant_placeholder.png"), // Replace with your image path
              radius: 30,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    taskDue,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Checkbox(value: false, onChanged: (value) {}),
          ],
        ),
      ),
    );
  }
}
