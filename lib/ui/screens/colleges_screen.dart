import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/providers/finance_providers.dart';
import '../../domain/models/college_models.dart';

class CollegesScreen extends ConsumerWidget {
  const CollegesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Colleges'),
      ),
      body: CustomScrollView(
        slivers: [
          _buildFoldersSection(context, ref),
          _buildUncategorizedSection(context, ref),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.invalidate(activeCollegeProvider);
          ref.invalidate(collegeFeesProvider);
          ref.invalidate(collegeScholarshipsProvider);
          ref.invalidate(collegeExpensesProvider);
          ref.invalidate(repaymentConfigProvider);
          ref.invalidate(moratoriumConfigProvider);
          context.push('/add-college');
        },
        label: const Text('Add College'),
        icon: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/colleges');
              break;
            case 2:
              context.go('/settings');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), activeIcon: Icon(Icons.school), label: 'Colleges'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildFoldersSection(BuildContext context, WidgetRef ref) {
    final collections = ref.watch(collectionsProvider);
    final allColleges = ref.watch(allCollegesProvider);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Collections',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: () => _showAddCollectionDialog(context, ref),
                icon: const Icon(Icons.add, size: 20),
                label: const Text('Add'),
              ),
            ],
          ),
          ...collections.map((collection) {
            final collegesInFolder = allColleges.where((c) => c.collectionId == collection.collectionId).toList();
            
            return DragTarget<CollegeEntity>(
              onAccept: (college) {
                final updatedCollege = college.copyWith(collectionId: collection.collectionId);
                ref.read(allCollegesProvider.notifier).updateCollege(updatedCollege);
              },
              builder: (context, candidateData, rejectedData) {
                return Card(
                  elevation: candidateData.isNotEmpty ? 4 : 1,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: candidateData.isNotEmpty ? Colors.green : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: ExpansionTile(
                    leading: Icon(_getCollectionIcon(collection.name), color: _getCollectionColor(collection.name)),
                    title: Text(collection.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${collegesInFolder.length} Colleges'),
                    children: collegesInFolder.map((college) => _buildCollegeItem(context, ref, college)).toList(),
                  ),
                );
              },
            );
          }).toList(),
        ]),
      ),
    );
  }

  Widget _buildUncategorizedSection(BuildContext context, WidgetRef ref) {
    final allColleges = ref.watch(allCollegesProvider);
    final collections = ref.watch(collectionsProvider);
    final collectionIds = collections.map((c) => c.collectionId).toSet();
    
    final uncategorized = allColleges.where((c) => !collectionIds.contains(c.collectionId) || c.collectionId == '').toList();
    
    if (uncategorized.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          const Text('Others / Inbox', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...uncategorized.map((college) => _buildCollegeItem(context, ref, college)).toList(),
        ]),
      ),
    );
  }

  Widget _buildCollegeItem(BuildContext context, WidgetRef ref, CollegeEntity college) {
    return LongPressDraggable<CollegeEntity>(
      data: college,
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(college.collegeName, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildCollegeListTile(context, ref, college),
      ),
      child: _buildCollegeListTile(context, ref, college),
    );
  }

  Widget _buildCollegeListTile(BuildContext context, WidgetRef ref, CollegeEntity college) {
    final isSelected = ref.watch(selectedDashboardCollegeProvider)?.collegeId == college.collegeId;
    
    return ListTile(
      selected: isSelected,
      leading: const Icon(Icons.school_outlined),
      title: Text(college.collegeName, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(college.courseName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.green),
            onPressed: () {
               ref.read(activeCollegeProvider.notifier).state = college;
               ref.read(collegeFeesProvider.notifier).state = college.fees;
               ref.read(collegeScholarshipsProvider.notifier).state = college.scholarships;
               ref.read(collegeExpensesProvider.notifier).state = college.expenses;
               if (college.repaymentConfig != null) {
                 ref.read(repaymentConfigProvider.notifier).setState(college.repaymentConfig!);
               }
               if (college.moratoriumConfig != null) {
                 ref.read(moratoriumConfigProvider.notifier).setState(college.moratoriumConfig!);
               }
               context.push('/add-college');
            },
          ),
          IconButton(
            icon: const Icon(Icons.insights, color: Colors.blue),
            onPressed: () {
               ref.read(selectedDashboardCollegeProvider.notifier).state = college;
               context.push('/insights');
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _deleteCollege(context, ref, college),
          ),
        ],
      ),
      onTap: () {
        ref.read(selectedDashboardCollegeProvider.notifier).state = college;
        // Optionally go to Home to see the summary card update
        context.go('/');
      },
    );
  }

  void _deleteCollege(BuildContext context, WidgetRef ref, CollegeEntity college) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove College'),
        content: Text('Are you sure you want to remove ${college.collegeName}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              ref.read(allCollegesProvider.notifier).removeCollege(college.collegeId);
              if (ref.read(selectedDashboardCollegeProvider)?.collegeId == college.collegeId) {
                ref.read(selectedDashboardCollegeProvider.notifier).state = null;
              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _showAddCollectionDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New collection'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Collection Name',
            hintText: 'e.g., Priority, Backup, Shortlist',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                final collections = ref.read(collectionsProvider);
                final newCollection = CollectionEntity(
                  collectionId: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: nameController.text.trim(),
                  orderIndex: collections.length,
                  createdAt: DateTime.now(),
                );
                ref.read(collectionsProvider.notifier).addCollection(newCollection);
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  IconData _getCollectionIcon(String name) {
    final n = name.toLowerCase();
    if (n.contains('priority') || n.contains('dream')) return Icons.star;
    if (n.contains('backup') || n.contains('safe')) return Icons.shield;
    if (n.contains('archive')) return Icons.archive;
    return Icons.folder;
  }

  Color _getCollectionColor(String name) {
    final n = name.toLowerCase();
    if (n.contains('priority') || n.contains('dream')) return Colors.orange;
    if (n.contains('backup') || n.contains('safe')) return Colors.green;
    return Colors.blue;
  }
}
