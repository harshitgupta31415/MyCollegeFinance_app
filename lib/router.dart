import 'package:go_router/go_router.dart';
import 'ui/screens/dashboard_screen.dart';
import 'ui/screens/insights_screen.dart';
import 'ui/screens/settings_screen.dart';
import 'ui/screens/add_college_screen.dart';
import 'ui/screens/fee_input_screen.dart';
import 'ui/screens/scholarship_screen.dart';
import 'ui/screens/moratorium_screen.dart';
import 'ui/screens/loan_analysis_screen.dart';
import 'ui/screens/collection_details_screen.dart';
import 'ui/screens/colleges_screen.dart';
// import 'ui/screens/auth_screen.dart';

final routerProvider = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/colleges',
      builder: (context, state) => const CollegesScreen(),
    ),
    GoRoute(
      path: '/insights',
      builder: (context, state) => const InsightsScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/add-college',
      builder: (context, state) => const AddCollegeScreen(),
    ),
    GoRoute(
      path: '/fee-input',
      builder: (context, state) => const FeeInputScreen(),
    ),
    GoRoute(
      path: '/scholarships',
      builder: (context, state) => const ScholarshipScreen(),
    ),
    GoRoute(
      path: '/moratorium-period',
      builder: (context, state) => const MoratoriumScreen(),
    ),
    GoRoute(
      path: '/loan-analysis',
      builder: (context, state) => const LoanAnalysisScreen(),
    ),
    GoRoute(
      path: '/collection/:id',
      builder: (context, state) => CollectionDetailsScreen(collectionId: state.pathParameters['id']!),
    ),
    // GoRoute(
    //   path: '/college-details/:id',
    //   builder: (context, state) => CollegeDetailsScreen(id: state.pathParameters['id']!),
    // ),
  ],
);
