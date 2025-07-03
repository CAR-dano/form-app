import 'dart:async';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A notifier to track the identifiers of tasks currently in the queue.
class QueuedTaskStatusNotifier extends StateNotifier<Set<String>> {
  QueuedTaskStatusNotifier() : super({});

  void addIdentifier(String id) {
    state = {...state, id};
  }

  void removeIdentifier(String id) {
    state = {...state}..remove(id);
  }
}

/// A provider that holds a set of identifiers for tasks currently in the queue.
final queuedTaskStatusProvider =
    StateNotifierProvider<QueuedTaskStatusNotifier, Set<String>>((ref) {
  return QueuedTaskStatusNotifier();
});


/// Abstract base class for any task that can be added to the queue.
abstract class QueueTask<T> {
  final String identifier;
  final Completer<T> completer;

  QueueTask({required this.identifier}) : completer = Completer<T>();

  /// The method to be implemented by concrete tasks, containing the actual work.
  Future<T> execute(Ref ref);
}

/// A generic queue service for processing various types of tasks sequentially.
class TaskQueueService extends StateNotifier<bool> {
  TaskQueueService(this._ref) : super(false) {
    _processQueue(); // Start processing when the service is created
  }

  final Ref _ref;
  final Queue<QueueTask<dynamic>> _queue = Queue();
  bool _isProcessing = false;

  /// Adds a task to the queue.
  void addTask(QueueTask<dynamic> task) {
    _queue.addLast(task);
    // --- MODIFIED ---
    // Add the identifier to the queued status provider
    _ref.read(queuedTaskStatusProvider.notifier).addIdentifier(task.identifier);
    // --- END MODIFIED ---
    if (kDebugMode) {
      print('Task added to queue for [${task.identifier}]. Queue size: ${_queue.length}');
    }
    _processQueue(); // Attempt to process the queue
  }

  /// Processes tasks in the queue sequentially.
  Future<void> _processQueue() async {
    if (_isProcessing || _queue.isEmpty) {
      return;
    }

    _isProcessing = true;
    state = true; // Indicate that the service is busy

    while (_queue.isNotEmpty) {
      final task = _queue.removeFirst();
      // The task is no longer queued, it's about to be processed. Remove it.
      _ref.read(queuedTaskStatusProvider.notifier).removeIdentifier(task.identifier);
      if (kDebugMode) {
        print('Processing task for identifier: ${task.identifier}. Remaining tasks: ${_queue.length}');
      }

      try {
        final result = await task.execute(_ref); // Execute the task and get the result
        task.completer.complete(result);
        if (kDebugMode) {
          print('Successfully processed task for identifier: ${task.identifier}');
        }
      } catch (e, stackTrace) {
        task.completer.completeError(e, stackTrace);
        if (kDebugMode) {
          print("Error processing task for ${task.identifier}: $e");
        }
      }
    }

    _isProcessing = false;
    state = false; // Indicate that the service is idle
    if (kDebugMode) {
      print('Task queue finished processing.');
    }
  }
}

// Riverpod provider for the generic TaskQueueService
final taskQueueServiceProvider = StateNotifierProvider<TaskQueueService, bool>((ref) {
  return TaskQueueService(ref);
});