import 'dart:math';
import '../models/college_models.dart';

class ScholarshipEngine {
  static double calculateNetYearCost({
    required int yearNumber,
    required double tuitionFee,
    double? hostelFee,
    double? examFee,
    double? travelFee,
    double? laptopFee,
    double? miscFee,
    required List<Scholarship> scholarships,
  }) {
    double baseTuition = tuitionFee;
    double baseHostel = hostelFee ?? 0;
    double baseExam = examFee ?? 0;
    double baseTravel = travelFee ?? 0;
    double baseLaptop = laptopFee ?? 0;
    double baseMisc = miscFee ?? 0;
    
    double baseTotal = baseTuition + baseHostel + baseExam + baseTravel + baseLaptop + baseMisc;
    
    // Filter active and confirmed scholarships for this year
    final activeScholarships = scholarships.where((s) => 
      s.applicableYears.contains(yearNumber) && 
      s.status == ScholarshipStatus.confirmed &&
      !s.isDiscontinued
    ).toList();

    double scholarshipReduction = 0;

    for (var s in activeScholarships) {
      double reduction = 0;
      double basisAmount = 0;
      
      // We assume each year has 2 semesters for calculation purposes.
      // Flattened numbering: Year 1 -> Sem 1 & 2, Year 2 -> Sem 3 & 4, etc.
      final s1 = (yearNumber - 1) * 2 + 1;
      final s2 = (yearNumber - 1) * 2 + 2;
      final appliedSemsInYear = s.applicableSemesters.where((sem) => sem == s1 || sem == s2).length;
      if (appliedSemsInYear == 0) continue;

      // Determine basis amount for percentage
      if (s.valueType == ScholarshipValueType.percent) {
        switch (s.basis) {
          case ScholarshipBasis.tuitionOnly:
            basisAmount = baseTuition;
            break;
          case ScholarshipBasis.totalFees:
            basisAmount = baseTotal;
            break;
          case ScholarshipBasis.tuitionAcademic:
            basisAmount = baseTuition; // Simplified for now
            break;
          case ScholarshipBasis.custom:
            // Sum up the components it applies to
            if (s.feeComponents.contains(FeeComponent.tuition)) basisAmount += baseTuition;
            if (s.feeComponents.contains(FeeComponent.hostel)) basisAmount += baseHostel;
            if (s.feeComponents.contains(FeeComponent.exam)) basisAmount += baseExam;
            if (s.feeComponents.contains(FeeComponent.laptop)) basisAmount += baseLaptop;
            if (s.feeComponents.contains(FeeComponent.travel)) basisAmount += baseTravel;
            if (s.feeComponents.contains(FeeComponent.miscellaneous)) basisAmount += baseMisc;
            break;
        }
        
        // If it's a percentage but only applied to one semester, half the basis (approximation)
        // or apply to the whole basis if it's a yearly percentage.
        // Most percent scholarships apply to the component for the whole year if they apply at all.
        // But if sem-specific, we adjust.
        double ratio = appliedSemsInYear / 2.0;
        reduction = (basisAmount * ratio) * (s.value / 100);
      } else {
        // Fixed Amount
        if (s.frequency == ScholarshipFrequency.perSemester) {
          reduction = s.value * appliedSemsInYear;
        } else if (s.frequency == ScholarshipFrequency.perYear) {
          reduction = s.value * (appliedSemsInYear / 2.0); // Prorate if only one sem selected
        } else {
          // One-time - only apply in the first year it's applicable
          bool isFirstYear = s.applicableYears.isNotEmpty && s.applicableYears.first == yearNumber;
          reduction = isFirstYear ? s.value : 0;
        }
      }
      scholarshipReduction += reduction;
    }

    double netCost = baseTotal - scholarshipReduction;
    return netCost < 0 ? 0 : netCost;
  }

  static List<Map<String, dynamic>> calculateSemesterTimeline({
    required CollegeEntity college,
    required List<YearFee> fees,
    required List<Scholarship> scholarships,
    required List<MoratoriumPayment> moratoriumPayments,
    required double morRate,
    required InterestType interestType,
  }) {
    List<Map<String, dynamic>> timeline = [];
    double cumulativeBalance = 0;
    
    int totalSems = college.durationYears * 2;
    for (int s = 1; s <= totalSems; s++) {
      int year = ((s - 1) / 2).floor() + 1;
      final yearFee = fees.firstWhere((f) => f.yearNumber == year, orElse: () => YearFee(yearNumber: year, tuitionFee: 0));
      
      // Simple division of yearly fees into semesters
      double tuition = yearFee.tuitionFee / 2;
      double hostel = (yearFee.hostelFee ?? 0) / 2;
      double exam = (yearFee.examFee ?? 0) / 2;
      double travel = (yearFee.travelFee ?? 0) / 2;
      double laptop = s == 1 ? (yearFee.laptopFee ?? 0) : 0; // Hardware usually in sem 1
      double misc = (yearFee.miscFee ?? 0) / 2;
      
      // Scholarship reduction for this specific semester
      double semNetCost = calculateNetSemesterCost(
        semNumber: s,
        yearNumber: year,
        tuition: tuition,
        hostel: hostel,
        exam: exam,
        travel: travel,
        laptop: laptop,
        misc: misc,
        scholarships: scholarships,
      );

      double scholarshipReduction = (tuition + hostel + exam + travel + laptop + misc) - semNetCost;

      // Add interest to cumulative balance before adding new sem cost (approximation)
      // or after? Let's say interest is calculated at end of sem.
      double semInterest = 0;
      if (interestType == InterestType.simple) {
         // Simple interest usually on disbursed amount, but here we model it on balance
         semInterest = cumulativeBalance * (morRate / 100) * 0.5;
      } else {
         semInterest = cumulativeBalance * (pow(1 + (morRate / 100), 0.5) - 1);
      }
      
      cumulativeBalance += semInterest + semNetCost;
      
      // Subtrack moratorium payments made in this semester range
      double semPayments = moratoriumPayments
          .where((p) => p.yearOffset >= (s - 1) * 0.5 && p.yearOffset < s * 0.5)
          .fold(0, (sum, p) => sum + p.amount);
      
      cumulativeBalance -= semPayments;

      timeline.add({
        'sem': s,
        'tuition': tuition,
        'hostel': hostel,
        'laptop': laptop,
        'misc': misc + exam + travel,
        'scholarship': scholarshipReduction,
        'netCost': semNetCost,
        'interest': semInterest,
        'payment': semPayments,
        'balance': cumulativeBalance,
      });
    }
    return timeline;
  }

  static double calculateNetSemesterCost({
    required int semNumber,
    required int yearNumber,
    required double tuition,
    required double hostel,
    required double exam,
    required double travel,
    required double laptop,
    required double misc,
    required List<Scholarship> scholarships,
  }) {
    double baseTotal = tuition + hostel + exam + travel + laptop + misc;
    final activeScholarships = scholarships.where((s) => 
      s.applicableSemesters.contains(semNumber) && 
      s.status == ScholarshipStatus.confirmed &&
      !s.isDiscontinued
    ).toList();

    double reduction = 0;
    for (var s in activeScholarships) {
      if (s.valueType == ScholarshipValueType.percent) {
        double basis = 0;
        switch (s.basis) {
          case ScholarshipBasis.tuitionOnly: basis = tuition; break;
          case ScholarshipBasis.totalFees: basis = baseTotal; break;
          case ScholarshipBasis.tuitionAcademic: basis = tuition; break;
          case ScholarshipBasis.custom:
            if (s.feeComponents.contains(FeeComponent.tuition)) basis += tuition;
            if (s.feeComponents.contains(FeeComponent.hostel)) basis += hostel;
            if (s.feeComponents.contains(FeeComponent.exam)) basis += exam;
            if (s.feeComponents.contains(FeeComponent.laptop)) basis += laptop;
            if (s.feeComponents.contains(FeeComponent.travel)) basis += travel;
            if (s.feeComponents.contains(FeeComponent.miscellaneous)) basis += misc;
            break;
        }
        reduction += basis * (s.value / 100);
      } else {
        if (s.frequency == ScholarshipFrequency.perSemester) {
          reduction += s.value;
        } else if (s.frequency == ScholarshipFrequency.perYear) {
          reduction += s.value / 2;
        } else {
          // One-time
          if (s.applicableSemesters.isNotEmpty && semNumber == (List<int>.from(s.applicableSemesters)..sort()).first) {
            reduction += s.value;
          }
        }
      }
    }
    return (baseTotal - reduction) < 0 ? 0 : (baseTotal - reduction);
  }
}

class LoanEngine {
  /// Calculate total principal based on net year costs and other expenses
  static double calculatePrincipal({
    required List<double> netYearCosts,
    required List<Expense> otherExpenses,
    required int durationYears,
  }) {
    double totalNetFees = netYearCosts.fold(0.0, (sum, cost) => sum + cost);
    
    double totalOneTimeExpenses = otherExpenses
        .where((e) => e.type == ExpenseType.oneTime)
        .fold(0.0, (sum, e) => sum + e.amount);
        
    double totalYearlyExpenses = otherExpenses
        .where((e) => e.type == ExpenseType.yearly)
        .fold(0.0, (sum, e) => sum + e.amount) * durationYears.toDouble();

    return totalNetFees + totalOneTimeExpenses + totalYearlyExpenses;
  }

  /// Detailed moratorium calculation including payments and interest type
  static Map<String, dynamic> calculateMoratoriumImpact({
    required double initialPrincipal,
    required MoratoriumConfig config,
  }) {
    double currentBasis = initialPrincipal;
    double totalInterestAccrued = 0;
    List<Map<String, double>> yearWiseBreakdown = [];
    
    // Sort payments by yearOffset
    final sortedPayments = List<MoratoriumPayment>.from(config.payments)..sort((a, b) => a.yearOffset.compareTo(b.yearOffset));

    if (config.interestType == InterestType.simple) {
      // For simple interest, we calculate year-by-year because payments reduce the basis
      double totalYears = config.durationYears;
      double lastOffset = 0;
      
      for (int i = 1; i <= totalYears.ceil(); i++) {
        double yearStart = (i - 1).toDouble();
        double yearEnd = i <= totalYears ? i.toDouble() : totalYears;
        double yearDuration = yearEnd - yearStart;
        double yearInterest = 0;

        // Process segments within this year if payments exist
        final yearPayments = sortedPayments.where((p) => p.yearOffset >= yearStart && p.yearOffset < yearEnd).toList();
        
        double segmentStart = yearStart;
        for (var p in yearPayments) {
          // Interest on current basis until payment
          double segmentDuration = p.yearOffset - segmentStart;
          yearInterest += currentBasis * (config.interestRate / 100) * segmentDuration;
          currentBasis -= p.amount; // Payment reduces basis
          segmentStart = p.yearOffset;
        }
        
        // Interest on remaining basis until year end
        yearInterest += currentBasis * (config.interestRate / 100) * (yearEnd - segmentStart);
        
        totalInterestAccrued += yearInterest;
        yearWiseBreakdown.add({
          'year': i.toDouble(),
          'interest': yearInterest,
        });
      }
    } else {
      // Compound interest (yearly)
      double totalYears = config.durationYears;
      for (int i = 1; i <= totalYears.ceil(); i++) {
        double yearStart = (i - 1).toDouble();
        double yearEnd = i <= totalYears ? i.toDouble() : totalYears;
        
        double yearInterest = 0;
        final yearPayments = sortedPayments.where((p) => p.yearOffset >= yearStart && p.yearOffset < yearEnd).toList();

        double segmentStart = yearStart;
        for (var p in yearPayments) {
          double segmentDuration = p.yearOffset - segmentStart;
          double segmentInterest = currentBasis * (pow(1 + (config.interestRate / 100), segmentDuration) - 1);
          yearInterest += segmentInterest;
          currentBasis = (currentBasis + segmentInterest) - p.amount;
          segmentStart = p.yearOffset;
        }

        double finalSegmentDuration = yearEnd - segmentStart;
        double finalSegmentInterest = currentBasis * (pow(1 + (config.interestRate / 100), finalSegmentDuration) - 1);
        yearInterest += finalSegmentInterest;
        currentBasis += finalSegmentInterest;
        
        totalInterestAccrued += yearInterest;
        yearWiseBreakdown.add({
          'year': i.toDouble(),
          'interest': yearInterest,
        });
      }
    }

    double totalPayments = config.payments.fold(0, (sum, p) => sum + p.amount);
    // Principal after moratorium = (Principal Before + Interest) - Payments
    // But since we reduced currentBasis during calculation, let's be careful.
    // The user formula: This = Principal before moratorium + Interest during moratorium − Any payments made during moratorium
    double finalPrincipal = initialPrincipal + totalInterestAccrued - totalPayments;

    return {
      'totalInterest': totalInterestAccrued,
      'finalPrincipal': finalPrincipal < 0 ? 0.0 : finalPrincipal,
      'yearWise': yearWiseBreakdown,
      'totalPayments': totalPayments,
    };
  }
}

class EMIEngine {
  /// Standard EMI Formula: EMI = P * r * (1+r)^n / ((1+r)^n - 1)
  static double calculateEMI({
    required double principal,
    required double annualRate,
    required int tenureYears,
  }) {
    if (tenureYears <= 0) return 0;
    double r = (annualRate / 100) / 12;
    int n = tenureYears * 12;
    if (r == 0) return principal / n;
    
    double emi = (principal * r * pow(1 + r, n)) / (pow(1 + r, n) - 1);
    return emi;
  }

  /// Generates the full amortization schedule with salary simulation and shortfall logic
  static Map<String, dynamic> generateAdvancedSchedule({
    required double principal,
    required double annualRate,
    required int tenureYears,
    required SalaryConfig salaryConfig,
    List<Prepayment> prepayments = const [],
  }) {
    List<EMIMonth> schedule = [];
    double remainingPrincipal = principal;
    double monthlyRate = (annualRate / 100) / 12;
    int totalMonths = tenureYears * 12;
    
    double baseEMI = calculateEMI(
      principal: principal,
      annualRate: annualRate,
      tenureYears: tenureYears,
    );

    double totalInterestPaid = 0;
    double totalPrincipalPaid = 0;
    
    // SAVINGS CALCULATION VARIABLES
    double totalShortfallInterest = 0;
    double totalPrepayments = 0;

    // Baseline calculation (for savings comparison)
    double baselineTotalInterest = calculateEMI(
      principal: principal,
      annualRate: annualRate,
      tenureYears: tenureYears,
    ) * totalMonths - principal;
    
    double currentMonthlySalary = 0;
    double currentGrowthRate = 0;

    for (int m = 1; m <= 600 && remainingPrincipal > 0.01; m++) {
      int currentYear = ((m - 1) ~/ 12) + 1;
      bool isStartOfYear = (m - 1) % 12 == 0;

      if (isStartOfYear) {
        // Check for specific salary change for this year
        final changeNode = salaryConfig.changes.where((c) => c.startYear == currentYear);
        if (changeNode.isNotEmpty) {
          final change = changeNode.first;
          currentMonthlySalary = change.monthlySalary;
          currentGrowthRate = change.annualGrowthPercent;
        } else {
          // No specific change for this year
          if (m == 1) {
            // Initialize
            currentMonthlySalary = salaryConfig.monthlySalary;
            currentGrowthRate = salaryConfig.annualGrowthPercent;
          } else {
             // Apply growth
             currentMonthlySalary *= (1 + (currentGrowthRate / 100));
          }
        }
      }

      double interestComponent = remainingPrincipal * monthlyRate;
      double emiToPay = baseEMI;
      
      // Salary Mismatch Logic
      bool isShortfall = false;
      if (currentMonthlySalary > 0 && currentMonthlySalary < emiToPay) {
        isShortfall = true;
        // double shortfall = emiToPay - currentMonthlySalary; // Unused
        emiToPay = currentMonthlySalary; 
        // Logic: pay as much as possible. If < interest, principal increases.
      }

      double principalComponent = emiToPay - interestComponent;
      if (principalComponent < 0) {
        // EMI doesn't even cover interest
        totalShortfallInterest += -principalComponent;
        principalComponent = 0; 
        // Principal effectively increases by the unpaid interest
        remainingPrincipal += interestComponent - emiToPay;
      } else {
        if (principalComponent > remainingPrincipal) {
          principalComponent = remainingPrincipal;
        }
        remainingPrincipal -= principalComponent;
      }

      double openingBalance = remainingPrincipal + principalComponent;
      
      // Prepayments for this month
      double prepaymentAmount = prepayments
          .where((p) {
            if (p.monthIndex != null) {
              return p.monthIndex == m;
            }
            return p.date.year == (DateTime.now().year + (m/12).floor()) && p.date.month == (DateTime.now().month + (m%12)).floor();
          })
          .fold(0.0, (sum, p) => sum + p.amount);
      
      if (prepaymentAmount > remainingPrincipal) {
        prepaymentAmount = remainingPrincipal;
      }
      remainingPrincipal -= prepaymentAmount;
      totalPrepayments += prepaymentAmount;

      totalInterestPaid += interestComponent;
      totalPrincipalPaid += principalComponent;

      schedule.add(EMIMonth(
        monthIndex: m,
        openingBalance: openingBalance,
        principalComponent: principalComponent,
        interestComponent: interestComponent,
        closingBalance: remainingPrincipal,
        prepayment: prepaymentAmount,
        monthlySalary: currentMonthlySalary,
      ));

      if (remainingPrincipal <= 0) break;
    }

    return {
      'schedule': schedule,
      'totalInterest': totalInterestPaid,
      'totalPrincipal': totalPrincipalPaid,
      'totalAmount': totalInterestPaid + totalPrincipalPaid + totalPrepayments,
      'savings': baselineTotalInterest - totalInterestPaid,
      'monthsSaved': totalMonths - schedule.length,
      'shortfallOccurred': totalShortfallInterest > 0,
    };
  }
}

class ROIEngine {
  static double calculateROI({
    required double annualSalary,
    required double totalEducationCost,
    required double annualEMI,
  }) {
    if (totalEducationCost <= 0) return 0;
    // Net Annual Gain = Salary - EMI
    // ROI = (Net Annual Gain / Total Cost) * 100
    // This represents the annual return on the total educational investment.
    return ((annualSalary - annualEMI) / totalEducationCost) * 100;
  }

  static List<Map<String, String>> getRecommendations(double roi) {
    if (roi < 0) {
      return [
        {'title': 'ROI is Critical (Negative)', 'tip': 'Your EMIs exceed your starting salary. This college choice is financially unsustainable without significant subsidies or a much higher salary.'},
        {'title': 'Downsize', 'tip': 'Consider a more affordable state university or apply for a fellowship that covers 100% tuition.'},
      ];
    } else if (roi < 15) {
      return [
        {'title': 'ROI is Low', 'tip': 'The return on this education is slow. It will take a long time to break even. Ensure the career growth in this field justifies the slow start.'},
        {'title': 'Aggressive Savings', 'tip': 'You must plan to live very frugally for the first 5 years to manage this debt.'},
      ];
    } else if (roi < 35) {
      return [
        {'title': 'ROI is Below Average', 'tip': 'While positive, this ROI is standard. Most graduates in this bracket feel the pressure of EMIs for a decade.'},
        {'title': 'Prepayment Strategy', 'tip': 'Use even small salary hikes to prepay the principal. A 10% extra payment early on can save years of EMI.'},
      ];
    } else if (roi < 60) {
      return [
        {'title': 'Good ROI', 'tip': 'This is a solid middle-ground. Your salary comfortably covers the EMI with room for a decent lifestyle.'},
        {'title': 'Balanced Growth', 'tip': 'You can afford to invest in other areas (like SIPs) while paying off the loan.'},
      ];
    } else if (roi < 100) {
      return [
        {'title': 'Very Good ROI', 'tip': 'This is high-value education. You are likely to pay off the debt quickly relative to your income.'},
        {'title': 'Early Retirement', 'tip': 'If you maintain your lifestyle while your income grows, you could be debt-free in record time.'},
      ];
    } else {
      return [
        {'title': 'Excellent ROI', 'tip': 'This is a rare high-yield opportunity. Your first-year net gain covers the entire cost of education.'},
        {'title': 'Wealth Creation', 'tip': 'Start building an investment portfolio immediately. The surplus cash flow is significant.'},
      ];
    }
  }
}
