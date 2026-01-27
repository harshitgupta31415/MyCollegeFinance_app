import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../domain/providers/finance_providers.dart';
import '../../domain/models/college_models.dart';
import '../../domain/logic/financial_logic.dart';

class CollectionDetailsScreen extends ConsumerWidget {
  final String collectionId;

  const CollectionDetailsScreen({super.key, required this.collectionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);
    
    final collections = ref.watch(collectionsProvider);
    final collection = collections.firstWhere(
      (c) => c.collectionId == collectionId,
      orElse: () => CollectionEntity(
        collectionId: 'unknown',
        name: 'Unknown Collection',
        orderIndex: 0,
        createdAt: DateTime.now(),
      ),
    );

    final allColleges = ref.watch(allCollegesProvider);
    final colleges = allColleges.where((c) => c.collectionId == collectionId).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: Text(collection.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: colleges.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school_outlined, size: 64, color: Colors.white.withOpacity(0.2)),
                  const SizedBox(height: 16),
                  Text(
                    'No colleges in this collection',
                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: colleges.length,
              itemBuilder: (context, index) {
                final college = colleges[index];
                return _buildCollegeCard(context, college, currencyFormat, ref);
              },
            ),
    );
  }

  Widget _buildCollegeCard(BuildContext context, CollegeEntity college, NumberFormat format, WidgetRef ref) {
    // Calculate basic stats for display
    // Note: This is a rough calculation for display. 
    // Accurate calc requires full LoanEngine logic which needs Provider context if not stored.
    // Fortunately we stored fees and configs.
    
    double totalPrincipal = 0;
    if (college.repaymentConfig != null && college.moratoriumConfig != null) {
       // We can try to approximate or retrieve if stored. 
       // For now, let's just sum up the fees to show "Total Fees"
       totalPrincipal = college.fees.fold(0.0, (sum, f) => 
         sum + f.tuitionFee + (f.hostelFee ?? 0) + (f.examFee ?? 0) + 
         (f.travelFee ?? 0) + (f.laptopFee ?? 0) + (f.miscFee ?? 0)
       );
    }

    return Card(
      color: Colors.white.withOpacity(0.05),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.account_balance, color: Colors.greenAccent),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        college.collegeName,
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${college.courseName} • ${college.location}',
                        style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                  onPressed: () => _confirmDelete(context, ref, college),
                ),
              ],
            ),
            const Divider(color: Colors.white24, height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMiniStat('Duration', '${college.durationYears} Years'),
                if (totalPrincipal > 0)
                  _buildMiniStat('Gross Fees', format.format(totalPrincipal)),
                // Could add more stats here
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
  
  void _confirmDelete(BuildContext context, WidgetRef ref, CollegeEntity college) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete College?'),
        content: Text('Are you sure you want to delete ${college.collegeName}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              ref.read(allCollegesProvider.notifier).removeCollege(college.collegeId);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
