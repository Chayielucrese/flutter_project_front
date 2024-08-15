import 'package:flutter/material.dart';

class FilterRequestPage extends StatelessWidget {
  const FilterRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Requests',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Example: Date Range Filter
          const Text('Date Range', style: TextStyle(fontSize: 16)),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Start Date',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () {
                    // Add date picker logic here
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'End Date',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () {
                    // Add date picker logic here
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Example: Request Status Filter
          const Text('Request Status', style: TextStyle(fontSize: 16)),
          DropdownButtonFormField<String>(
            items: const [
              DropdownMenuItem(value: 'Pending', child: Text('Pending')),
              DropdownMenuItem(value: 'Accepted', child: Text('Accepted')),
              DropdownMenuItem(value: 'Rejected', child: Text('Rejected')),
            ],
            onChanged: (value) {
              // Handle status change
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          // Example: Apply Filters Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Apply filter logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink, // Use the app's color theme
              ),
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }
}
