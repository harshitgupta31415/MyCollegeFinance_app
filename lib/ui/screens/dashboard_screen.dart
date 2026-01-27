import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/providers/finance_providers.dart';
import '../../domain/models/college_models.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My College Finance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              // TODO: Auth / Profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSummaryCard(context, ref),
            _buildHowToUse(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.invalidate(activeCollegeProvider);
          ref.invalidate(collegeFeesProvider);
          ref.invalidate(collegeScholarshipsProvider);
          ref.invalidate(collegeExpensesProvider); // Added this line
          ref.invalidate(repaymentConfigProvider);
          ref.invalidate(moratoriumConfigProvider);
          context.push('/add-college');
        },
        label: const Text('Add College'),
        icon: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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

  Widget _buildSummaryCard(BuildContext context, WidgetRef ref) {
    final selectedCollege = ref.watch(selectedDashboardCollegeProvider);
    final allColleges = ref.watch(allCollegesProvider);
    
    if (selectedCollege == null && allColleges.isEmpty) {
      return _buildEmptySummary();
    }

    final displayCollege = selectedCollege ?? allColleges.first;
    
    // Calculate stats for displayCollege
    double totalFees = displayCollege.fees.fold(0.0, (sum, f) => 
       sum + f.tuitionFee + (f.hostelFee ?? 0) + (f.examFee ?? 0) + 
       (f.travelFee ?? 0) + (f.laptopFee ?? 0) + (f.miscFee ?? 0)
    );

    double emi = 0;
    if (displayCollege.repaymentConfig != null) {
      // Simplified EMI calc for header
      final principal = totalFees; // Rough estimate
      final r = (displayCollege.repaymentConfig!.interestRate / 100) / 12;
      final n = displayCollege.repaymentConfig!.tenureYears * 12;
      if (n > 0) {
        emi = (principal * r * pow(1 + r, n)) / (pow(1 + r, n) - 1);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade800,
              Colors.green.shade400,
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayCollege.collegeName,
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        displayCollege.courseName,
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (displayCollege.notes != null && displayCollege.notes!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            "Note: ${displayCollege.notes}",
                            style: const TextStyle(color: Colors.white60, fontSize: 11, fontStyle: FontStyle.italic),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                      onPressed: () {
                        ref.read(activeCollegeProvider.notifier).state = displayCollege;
                         // Load existing data into providers
                        ref.read(collegeFeesProvider.notifier).state = displayCollege.fees;
                        ref.read(collegeScholarshipsProvider.notifier).state = displayCollege.scholarships;
                        ref.read(collegeExpensesProvider.notifier).state = displayCollege.expenses;
                        if (displayCollege.repaymentConfig != null) {
                          ref.read(repaymentConfigProvider.notifier).setState(displayCollege.repaymentConfig!);
                        }
                        if (displayCollege.moratoriumConfig != null) {
                          ref.read(moratoriumConfigProvider.notifier).setState(displayCollege.moratoriumConfig!);
                        }
                        context.push('/add-college');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.insights, color: Colors.white, size: 20),
                      onPressed: () {
                        ref.read(selectedDashboardCollegeProvider.notifier).state = displayCollege;
                        context.push('/insights');
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMiniStat('Monthly EMI', '₹ ${_formatCurrency(emi)}'),
                _buildMiniStat('Total Cost', '₹ ${_formatCurrency(totalFees)}'),
                _buildMiniStat('Duration', '${displayCollege.durationYears} Yrs'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySummary() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(24),
        child: const Column(
          children: [
            Text('No College Selected', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Add a college to see analysis here'),
          ],
        ),
      ),
    );
  }
  
  String _formatCurrency(double amount) {
    if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(2)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}k';
    }
    return amount.toStringAsFixed(0);
  }

  Widget _buildMiniStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ],
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
      title: Text(college.collegeName),
      subtitle: Text(college.courseName),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, color: Colors.red),
        onPressed: () => _deleteCollege(context, ref, college),
      ),
      onTap: () {
        ref.read(selectedDashboardCollegeProvider.notifier).state = college;
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
  
  IconData _getCollectionIcon(String name) {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('priority') || lowerName.contains('favorite')) {
      return Icons.star;
    } else if (lowerName.contains('backup')) {
      return Icons.shield;
    } else if (lowerName.contains('shortlist')) {
      return Icons.bookmark;
    }
    return Icons.folder;
  }
  
  Color _getCollectionColor(String name) {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('priority') || lowerName.contains('favorite')) {
      return Colors.amber;
    } else if (lowerName.contains('backup')) {
      return Colors.blue;
    } else if (lowerName.contains('shortlist')) {
      return Colors.purple;
    }
    return Colors.grey;
  }
  
  void _showAddCollectionDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Collection'),
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
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
  
  void _deleteCollection(WidgetRef ref, CollectionEntity collection) {
    ref.read(collectionsProvider.notifier).removeCollection(collection.collectionId);
  }

  Widget _buildCollectionTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color, {
    VoidCallback? onDelete,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text('Delete Collection'),
                      content: Text('Are you sure you want to delete "$title"?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            onDelete();
                            Navigator.pop(dialogContext);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            const Icon(Icons.chevron_right),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildHowToUse(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Guide',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildStepCard(
            '1', 'Add Colleges', 
            'Click the + button below to add colleges you are considering.',
            Icons.add_circle_outline, Colors.blue
          ),
          _buildStepCard(
            '2', 'Input Finances', 
            'Enter tuition, hostel fees, and any scholarships you expect.',
            Icons.receipt_long_outlined, Colors.orange
          ),
          _buildStepCard(
            '3', 'Analyze ROI', 
            'Check the Colleges tab to see detailed ROI and EMI schedules.',
            Icons.analytics_outlined, Colors.green
          ),
          _buildStepCard(
            '4', 'Organize', 
            'Drag and drop colleges into collection folders for better comparison.',
            Icons.folder_open_outlined, Colors.purple
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(String num, String title, String desc, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Center(child: Text(num, style: TextStyle(color: color, fontWeight: FontWeight.bold))),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(desc, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
            ),
            Icon(icon, color: color.withOpacity(0.3)),
          ],
        ),
      ),
    );
  }
}
