import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart';
import 'package:form_app/providers/form_collection_provider.dart';
import 'package:form_app/providers/form_step_provider.dart'; // Import formStepProvider
import 'package:form_app/pages/multi_step_form_screen.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formCollection = ref.watch(formCollectionProvider);
    final selectedFormIdentifier = ref.watch(selectedFormIdentifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspection Forms'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: formCollection.isEmpty
                  ? const Center(
                      child: Text(
                        'No forms available. Add a new form to get started.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: formCollection.length,
                      itemBuilder: (context, index) {
                        final identifier = formCollection.keys.elementAt(index);
                        final formData = formCollection[identifier];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              formData?.namaCustomer.isNotEmpty == true
                                  ? formData!.namaCustomer
                                  : 'Unnamed Form (${formData!.id})', // Use formData.id
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: const Text('Tap to edit this form'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete Form'),
                                    content: Text(
                                        'Are you sure you want to delete the form for "${formData.namaCustomer.isNotEmpty == true ? formData.namaCustomer : formData.id}"?'), // Use formData.id
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          ref
                                              .read(formCollectionProvider.notifier)
                                              .removeForm(formData.id); // Use formData.id
                                          if (selectedFormIdentifier == formData.id) { // Use formData.id
                                            ref
                                                .read(selectedFormIdentifierProvider.notifier)
                                                .state = null;
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            onTap: () {
                              ref.read(selectedFormIdentifierProvider.notifier).state = formData.id; // Use formData.id
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MultiStepFormScreen(),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                final newFormData = FormData(); // Create a new FormData object
                ref.read(formCollectionProvider.notifier).addForm(newFormData); // Pass the FormData object
                ref.read(selectedFormIdentifierProvider.notifier).state = newFormData.id; // Use newFormData.id
                ref.read(formStepProvider.notifier).state = 0; // Reset to the first page for a new form
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MultiStepFormScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add New Form'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
