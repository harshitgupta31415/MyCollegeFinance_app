import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/providers/finance_providers.dart';
import '../../domain/models/college_models.dart';
import '../../domain/logic/financial_logic.dart';
import 'dart:math';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCollege = ref.watch(selectedDashboardCollegeProvider);
    final allColleges = ref.watch(allCollegesProvider);
    
    final displayCollege = selectedCollege ?? (allColleges.isNotEmpty ? allColleges.first : null);

    if (displayCollege == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Insights')),
        body: const Center(child: Text('No college data available. Add a college first.')),
      );
    }

    // Calculations
    double totalFees = displayCollege.fees.fold(0.0, (sum, f) => 
       sum + f.tuitionFee + (f.hostelFee ?? 0) + (f.examFee ?? 0) + 
       (f.travelFee ?? 0) + (f.laptopFee ?? 0) + (f.miscFee ?? 0)
    );

    double principalAfterMor = totalFees;
    double emi = 0;
    double totalInterest = 0;

    if (displayCollege.moratoriumConfig != null) {
       final impact = LoanEngine.calculateMoratoriumImpact(
         initialPrincipal: totalFees, 
         config: displayCollege.moratoriumConfig!
       );
       principalAfterMor = impact['finalPrincipal'];
    }

    if (displayCollege.repaymentConfig != null) {
      final config = displayCollege.repaymentConfig!;
      emi = EMIEngine.calculateEMI(
        principal: principalAfterMor, 
        annualRate: config.interestRate, 
        tenureYears: config.tenureYears
      );
      totalInterest = (emi * config.tenureYears * 12) - principalAfterMor;
    }

    double annualEMI = emi * 12;
    double expectedAnnualSalary = (displayCollege.repaymentConfig?.salaryConfig.monthlySalary ?? 0) * 12;
    double roi = ROIEngine.calculateROI(
      annualSalary: expectedAnnualSalary,
      totalEducationCost: totalFees,
      annualEMI: annualEMI,
    );

    final recommendations = ROIEngine.getRecommendations(roi);

    return Scaffold(
      appBar: AppBar(
        title: Text('Insights: ${displayCollege.collegeName}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildROICard(roi),
            const SizedBox(height: 24),
            _buildSectionTitle('Financial Overview'),
            const SizedBox(height: 16),
            _buildInsightCard(
              'Total Investment',
              '₹ ${_formatCurrency(totalFees)}',
              Icons.account_balance_wallet,
              Colors.blue,
            ),
            _buildInsightCard(
              'Expected Annual Salary',
              '₹ ${_formatCurrency(expectedAnnualSalary)}',
              Icons.payments,
              Colors.green,
            ),
            _buildInsightCard(
              'Average Placement',
              displayCollege.averagePackage != null ? '₹ ${_formatCurrency(displayCollege.averagePackage!)}' : 'Not Provided',
              Icons.trending_up,
              Colors.orange,
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('Loan Analysis (Post-Study)'),
            const SizedBox(height: 16),
            _buildDebtSummaryCard(principalAfterMor, emi, totalInterest),
            const SizedBox(height: 32),
            _buildSectionTitle('Recommendations & Tips'),
            const SizedBox(height: 16),
            ...recommendations.map((rec) => _buildRecommendationCard(
              rec['title']!,
              rec['tip']!,
              Icons.lightbulb_outline,
              _getROIColor(roi),
            )).toList(),
            const SizedBox(height: 32),
            _buildSectionTitle('Detailed Cost Breakdown'),
            const SizedBox(height: 16),
            _buildCostBreakdown(displayCollege, totalFees),
            const SizedBox(height: 32),
            _buildSectionTitle('Repayment Schedule'),
            const SizedBox(height: 16),
            _buildRepaymentSchedule(ref),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildRepaymentSchedule(WidgetRef ref) {
    final scheduleData = ref.watch(repaymentScheduleProvider);
    final List<EMIMonth> schedule = scheduleData['schedule'];
    
    // Group by year
    final Map<int, List<EMIMonth>> yearlyData = {};
    for (var m in schedule) {
      int year = (m.monthIndex / 12).floor() + 1;
      yearlyData.putIfAbsent(year, () => []).add(m);
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.withOpacity(0.1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMiniBox('Years to Pay', '${yearlyData.keys.length} Yrs'),
              _buildMiniBox('Total Amount', '₹ ${_formatCurrency(scheduleData['totalAmount'])}'),
              _buildMiniBox('Interest Saved', '₹ ${_formatCurrency(scheduleData['savings'])}'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...yearlyData.entries.take(5).map((entry) {
          final year = entry.key;
          final months = entry.value;
          final yearlyInterest = months.fold(0.0, (sum, m) => sum + m.interestComponent);
          final yearlyPrincipal = months.fold(0.0, (sum, m) => sum + m.principalComponent);
          
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(0.1),
                child: Text('$year', style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              title: Text('Year $year Analysis', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              subtitle: Text('Principal: ₹${_formatCurrency(yearlyPrincipal)} • Interest: ₹${_formatCurrency(yearlyInterest)}', style: const TextStyle(fontSize: 11)),
              children: [
                ...months.map((m) => ListTile(
                  dense: true,
                  title: Text('Month ${m.monthIndex + 1}'),
                  trailing: Text('EMI: ₹${_formatCurrency(m.principalComponent + m.interestComponent)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                )),
              ],
            ),
          );
        }).toList(),
        if (yearlyData.length > 5)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('+ ${yearlyData.length - 5} more years', style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ),
      ],
    );
  }

  Widget _buildMiniBox(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 10)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }

  String _formatCurrency(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(2)} Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(2)} L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)} K';
    }
    return amount.toStringAsFixed(0);
  }

  Color _getROIColor(double roi) {
    if (roi < 0) return Colors.red.shade900;
    if (roi < 15) return Colors.red.shade600;
    if (roi < 35) return Colors.deepOrange;
    if (roi < 60) return Colors.blue;
    return Colors.green;
  }

  String _getROIStatus(double roi) {
    if (roi < 0) return 'Financial Risk (Negative)';
    if (roi < 15) return 'Poor ROI';
    if (roi < 35) return 'Below Average / Risk';
    if (roi < 60) return 'Decent / Average';
    if (roi < 100) return 'Very Good';
    return 'Excellent';
  }

  Widget _buildROICard(double roi) {
    Color roiColor = _getROIColor(roi);
    String status = _getROIStatus(roi);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: roiColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: roiColor.withOpacity(0.3), width: 2),
      ),
      child: Column(
        children: [
          const Text('ANNUAL RETURN ON INVESTMENT (ROI)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          const SizedBox(height: 16),
          Text(
            '${roi.toStringAsFixed(1)}%',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: roiColor),
          ),
          const SizedBox(height: 8),
          Text(status, style: TextStyle(fontSize: 18, color: roiColor, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInsightCard(String label, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                Text(
                  value, 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDebtSummaryCard(double principal, double emi, double interest) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _buildDebtRow('Final Loan Amount', '₹ ${_formatCurrency(principal)}', Colors.white70),
          const Divider(color: Colors.white10, height: 24),
          _buildDebtRow('Monthly EMI', '₹ ${_formatCurrency(emi)}', Colors.orangeAccent),
          const Divider(color: Colors.white10, height: 24),
          _buildDebtRow('Total Interest', '₹ ${_formatCurrency(interest)}', Colors.blueAccent),
        ],
      ),
    );
  }

  Widget _buildDebtRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 13)),
        Text(value, style: TextStyle(color: valueColor, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildCostBreakdown(CollegeEntity college, double total) {
    double tuition = college.fees.fold(0.0, (sum, f) => sum + f.tuitionFee);
    double hostel = college.fees.fold(0.0, (sum, f) => sum + (f.hostelFee ?? 0));
    double other = total - (tuition + hostel);

    return Column(
      children: [
        _buildBreakdownRow('Tuition Fees', tuition, total, Colors.blue),
        const SizedBox(height: 16),
        _buildBreakdownRow('Living Expenses', hostel, total, Colors.orange),
        const SizedBox(height: 16),
        _buildBreakdownRow('Misc Costs', other, total, Colors.grey),
      ],
    );
  }

  Widget _buildBreakdownRow(String label, double amount, double total, Color color) {
    double percentage = total > 0 ? amount / total : 0;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
            Text('₹ ${_formatCurrency(amount)} (${(percentage * 100).toStringAsFixed(0)}%)', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: Colors.grey[200],
          color: color,
          minHeight: 6,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildRecommendationCard(String title, String description, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: color.withOpacity(0.05),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color.darker(0.2))),
                  const SizedBox(height: 4),
                  Text(description, style: TextStyle(color: Colors.grey[800], fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension ColorExtension on Color {
  Color darker(double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final darkerHsl = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return darkerHsl.toColor();
  }
}
