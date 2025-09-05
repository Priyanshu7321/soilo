import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      body: _buildHistoryList(context),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    final historyItems = List.generate(
      10,
          (index) => HistoryItem(
        id: index.toString(),
        title: 'History Item ${index + 1}',
        description: 'Description for history item ${index + 1}',
        date: DateTime.now().subtract(Duration(days: index)),
        status: HistoryStatus.values[index % HistoryStatus.values.length],
      ),
    );

    if (historyItems.isEmpty) {
      return const Center(child: Text('No history available'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: historyItems.length,
      itemBuilder: (context, index) {
        return _buildHistoryCard(context, historyItems[index]);
      },
    );
  }

  Widget _buildHistoryCard(BuildContext context, HistoryItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(item.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item.status.name.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(item.status),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(item.description, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDate(item.date), style: Theme.of(context).textTheme.labelSmall),
                TextButton(
                  onPressed: () => _showHistoryDetails(context, item),
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(HistoryStatus status) {
    switch (status) {
      case HistoryStatus.completed:
        return Colors.green;
      case HistoryStatus.pending:
        return Colors.orange;
      case HistoryStatus.failed:
        return Colors.red;
      case HistoryStatus.inProgress:
        return Colors.blue;
    }
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Filter History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...HistoryStatus.values.map((status) {
                return CheckboxListTile(
                  title: Text(status.name[0].toUpperCase() + status.name.substring(1)),
                  value: true, // TODO: Connect to filter state
                  onChanged: (value) {
                    // TODO: Update filter state
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }).toList(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Apply filters
                },
                child: const Text('Apply Filters'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showHistoryDetails(BuildContext context, HistoryItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status: ${item.status.name.toUpperCase()}',
              style: TextStyle(
                color: _getStatusColor(item.status),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Date: ${_formatDate(item.date)}'),
            const SizedBox(height: 16),
            const Text('Details:'),
            const SizedBox(height: 8),
            Text(item.description),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class HistoryItem {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final HistoryStatus status;

  HistoryItem({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });
}

enum HistoryStatus { completed, pending, failed, inProgress }
