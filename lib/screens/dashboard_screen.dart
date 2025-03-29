import 'package:flutter/material.dart';
import '../models/company_registration.dart';
import '../models/registration_details.dart';
import 'registration_form_screen.dart';
import 'registration_details_screen.dart';
import 'support_chat_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  RegistrationStatus? _selectedStatus;
  String? _selectedFreezone;
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
  bool _isNavigationRailExtended = false;

  // Моковые данные
  final List<CompanyRegistration> _mockRegistrations = [
    CompanyRegistration(
      id: 'REG001',
      companyName: 'Tech Solutions Ltd',
      clientName: 'John Smith',
      email: 'john.smith@techsolutions.com',
      phone: '+971 50 123 4567',
      freezone: 'DMCC',
      submissionDate: DateTime.now().subtract(const Duration(days: 2)),
      status: RegistrationStatus.new_,
      notes: 'Premium client, urgent processing required',
    ),
    CompanyRegistration(
      id: 'REG002',
      companyName: 'Global Trading FZE',
      clientName: 'Sarah Johnson',
      email: 'sarah.j@globaltrading.com',
      phone: '+971 50 234 5678',
      freezone: 'JAFZA',
      submissionDate: DateTime.now().subtract(const Duration(days: 5)),
      status: RegistrationStatus.inProgress,
      notes: 'Documents pending verification',
    ),
    CompanyRegistration(
      id: 'REG003',
      companyName: 'Dubai Investments LLC',
      clientName: 'Ahmed Al-Rahman',
      email: 'ahmed@dubaiinvestments.com',
      phone: '+971 50 345 6789',
      freezone: 'SHAMS',
      submissionDate: DateTime.now().subtract(const Duration(days: 10)),
      status: RegistrationStatus.completed,
      notes: 'All documents verified and approved',
    ),
    CompanyRegistration(
      id: 'REG004',
      companyName: 'Innovation Hub FZCO',
      clientName: 'Maria Garcia',
      email: 'maria@innovationhub.com',
      phone: '+971 50 456 7890',
      freezone: 'DMCC',
      submissionDate: DateTime.now().subtract(const Duration(days: 1)),
      status: RegistrationStatus.new_,
      notes: 'Startup company, priority processing',
    ),
    CompanyRegistration(
      id: 'REG005',
      companyName: 'Middle East Trading Co',
      clientName: 'Mohammed Ali',
      email: 'mohammed@metrading.com',
      phone: '+971 50 567 8901',
      freezone: 'JAFZA',
      submissionDate: DateTime.now().subtract(const Duration(days: 7)),
      status: RegistrationStatus.rejected,
      notes: 'Incomplete documentation',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Navigation Rail
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: _isNavigationRailExtended ? 280 : 72,
            child: NavigationRail(
              extended: _isNavigationRailExtended,
              backgroundColor: Colors.white,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              leading: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _isNavigationRailExtended
                            ? Icons.menu_open
                            : Icons.menu,
                        color: const Color(0xFF1D1B20),
                      ),
                      onPressed: () {
                        setState(() {
                          _isNavigationRailExtended = !_isNavigationRailExtended;
                        });
                      },
                    ),
                    if (_isNavigationRailExtended) ...[
                      const SizedBox(width: 8),
                      const Text(
                        'FlexIncorp',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1D1B20),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.business_outlined),
                  selectedIcon: Icon(Icons.business),
                  label: Text('Applications'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.chat_outlined),
                  selectedIcon: Icon(Icons.chat),
                  label: Text('Support'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.analytics_outlined),
                  selectedIcon: Icon(Icons.analytics),
                  label: Text('Analytics'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: Text('Settings'),
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: _selectedIndex == 0
                  ? Column(
                      children: [
                        // Top Bar with Search and Actions
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: TextField(
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      hintText: 'Search applications...',
                                      prefixIcon: const Icon(Icons.search, size: 18),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      // TODO: Implement search
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: _buildFilterButton(
                                  'Status',
                                  _selectedStatus == null
                                      ? null
                                      : _getStatusText(_selectedStatus!),
                                  () {
                                    // Show status filter dialog
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: _buildFilterButton(
                                  'Freezone',
                                  _selectedFreezone,
                                  () {
                                    // Show freezone filter dialog
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegistrationFormScreen(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.add, size: 18),
                                  label: const Text('New Application'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Applications Table
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                            child: Card(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth: MediaQuery.of(context).size.width - (_isNavigationRailExtended ? 280 : 72) - 32,
                                    ),
                                    child: _buildRegistrationsTable(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : _selectedIndex == 1
                      ? const Center(child: Text('Applications Screen'))
                      : _selectedIndex == 2
                          ? const SupportChatScreen()
                          : _selectedIndex == 3
                              ? const Center(child: Text('Analytics Screen'))
                              : const Center(child: Text('Settings Screen')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, String? value, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Text(
            value ?? label,
            style: TextStyle(
              color: value == null ? Colors.grey[600] : Colors.black87,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.arrow_drop_down,
            size: 18,
            color: value == null ? Colors.grey[600] : Colors.black87,
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationsTable() {
    return DataTable(
      columnSpacing: 16,
      horizontalMargin: 16,
      dataRowHeight: 56,
      headingRowHeight: 56,
      columns: const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Company')),
        DataColumn(label: Text('Client')),
        DataColumn(label: Text('Email')),
        DataColumn(label: Text('Phone')),
        DataColumn(label: Text('Freezone')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Actions')),
      ],
      rows: _mockRegistrations.map((registration) {
        return DataRow(
          cells: [
            DataCell(
              GestureDetector(
                onTap: () => _navigateToDetails(registration),
                child: Text(registration.id),
              ),
            ),
            DataCell(
              GestureDetector(
                onTap: () => _navigateToDetails(registration),
                child: Text(registration.companyName),
              ),
            ),
            DataCell(
              GestureDetector(
                onTap: () => _navigateToDetails(registration),
                child: Text(registration.clientName),
              ),
            ),
            DataCell(
              GestureDetector(
                onTap: () => _navigateToDetails(registration),
                child: Text(registration.email),
              ),
            ),
            DataCell(
              GestureDetector(
                onTap: () => _navigateToDetails(registration),
                child: Text(registration.phone),
              ),
            ),
            DataCell(
              GestureDetector(
                onTap: () => _navigateToDetails(registration),
                child: Text(registration.freezone),
              ),
            ),
            DataCell(
              GestureDetector(
                onTap: () => _navigateToDetails(registration),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(registration.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _getStatusText(registration.status),
                    style: TextStyle(
                      color: _getStatusColor(registration.status),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            DataCell(
              GestureDetector(
                onTap: () => _navigateToDetails(registration),
                child: Text(
                  '${registration.submissionDate.day}/${registration.submissionDate.month}/${registration.submissionDate.year}',
                ),
              ),
            ),
            DataCell(
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.more_horiz, size: 18),
                    onPressed: () {
                      // TODO: Implement actions menu
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  void _navigateToDetails(CompanyRegistration registration) {
    final details = RegistrationDetails(
      id: registration.id,
      registrationType: CompanyRegistrationType.newCompany,
      businessActivities: ['Trading', 'Consulting', 'Technology'],
      licenseExpiryDate: DateTime.now().add(const Duration(days: 365)),
      companyNameOptions: [
        registration.companyName,
        '${registration.companyName} FZE',
        '${registration.companyName} Group',
      ],
      visaCount: 2,
      shareholders: [
        Shareholder(
          name: registration.clientName,
          isCompany: false,
          shares: 1000,
          percentage: 100,
        ),
      ],
      shareCapital: 100000,
      totalShares: 1000,
      ubo: registration.clientName,
      generalManager: registration.clientName,
      director: registration.clientName,
      secretary: 'Jane Doe',
      freezone: registration.freezone,
      registrationCost: 15000,
      paymentStatus: PaymentStatus.pending,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationDetailsScreen(details: details),
      ),
    );
  }

  Color _getStatusColor(RegistrationStatus status) {
    switch (status) {
      case RegistrationStatus.new_:
        return const Color(0xFF0A84FF);
      case RegistrationStatus.inProgress:
        return const Color(0xFFFF9500);
      case RegistrationStatus.completed:
        return const Color(0xFF34C759);
      case RegistrationStatus.rejected:
        return const Color(0xFFFF3B30);
    }
  }

  String _getStatusText(RegistrationStatus status) {
    switch (status) {
      case RegistrationStatus.new_:
        return 'New';
      case RegistrationStatus.inProgress:
        return 'In Progress';
      case RegistrationStatus.completed:
        return 'Completed';
      case RegistrationStatus.rejected:
        return 'Rejected';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 