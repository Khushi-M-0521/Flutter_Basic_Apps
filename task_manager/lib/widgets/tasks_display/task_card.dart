import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key});

  @override
  State<TaskCard> createState() {
    return _TaskCard();
  }
}

class _TaskCard extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(1),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(value: false, onChanged: (ischeck) {}),
                const Spacer(),
                const Text('Title'),
                const Spacer(),
                const CircleAvatar(
                  child: Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(
              width: double.infinity,
              child: Expanded(
                child: Text(
                  'Description...........................................................................................................................',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  textWidthBasis: TextWidthBasis.parent,
                ),
              ),
            ),
            
            const SizedBox(height: 4),
            const Row(
              children: [
                Text('Assigned on: .........'),
                Spacer(),
                Text('Due on: ..........'),
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Text('Category: .....'),
                Spacer(),
                Text('Time left: .........'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
