import 'package:flutter/material.dart';
import '../models/registration_details.dart';
import '../models/shareholder_details.dart';
import 'shareholder_details_screen.dart';

class RegistrationDetailsScreen extends StatelessWidget {
  final RegistrationDetails details;

  const RegistrationDetailsScreen({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Details'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              // TODO: Implement edit functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              // TODO: Implement more actions menu
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildSection(
              'Company Information',
              [
                _buildInfoCard(
                  [
                    _buildInfoRow('Registration Type', _getRegistrationTypeText(details.registrationType)),
                    _buildInfoRow('Business Activities', details.businessActivities.join(', ')),
                    _buildInfoRow('License Expiry Date', '${details.licenseExpiryDate.day}/${details.licenseExpiryDate.month}/${details.licenseExpiryDate.year}'),
                    _buildInfoRow('Company Name Options', details.companyNameOptions.join('\n')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Visas',
              [
                _buildInfoCard(
                  [
                    _buildInfoRow('Number of Visas', details.visaCount.toString()),
                    if (details.visaCount > 0)
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Establishment Card is required',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Shareholders',
              [
                _buildInfoCard(
                  details.shareholders.map((shareholder) => _buildShareholderInfo(context, shareholder)).toList(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Share Capital',
              [
                _buildInfoCard(
                  [
                    _buildInfoRow('Share Capital', '${details.shareCapital.toStringAsFixed(2)} AED'),
                    _buildInfoRow('Total Shares', details.totalShares.toString()),
                    _buildInfoRow('Share Distribution', _buildShareDistribution(details.shareholders)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Appointments',
              [
                _buildInfoCard(
                  [
                    _buildInfoRow('UBO', details.ubo),
                    _buildInfoRow('General Manager', details.generalManager),
                    _buildInfoRow('Director', details.director),
                    _buildInfoRow('Secretary', details.secretary),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Freezone',
              [
                _buildInfoCard(
                  [
                    _buildInfoRow('Selected Freezone', details.freezone),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildSection(
              'Payment',
              [
                _buildInfoCard(
                  [
                    _buildInfoRow('Registration Cost', '${details.registrationCost.toStringAsFixed(2)} AED'),
                    _buildInfoRow('Payment Status', _getPaymentStatusText(details.paymentStatus)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.business,
              color: Colors.blue,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  details.companyNameOptions[0],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1D1B20),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID: ${details.id}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _getPaymentStatusText(details.paymentStatus),
              style: const TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1D1B20),
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1D1B20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareholderInfo(BuildContext context, Shareholder shareholder) {
    return GestureDetector(
      onTap: () {
        // TODO: Replace with actual data
        final details = ShareholderDetails(
          name: shareholder.name,
          phone: '+971 50 123 4567',
          email: 'john.smith@example.com',
          placeOfBirth: 'London, UK',
          nationality: 'British',
          secondNationality: 'Emirati',
          address: 'Dubai Marina, Dubai, UAE',
          location: ShareholderLocation.uae,
          documents: [
            Document(
              type: 'passport',
              url: 'https://example.com/passport.pdf',
              uploadDate: DateTime.now().subtract(const Duration(days: 5)),
            ),
            Document(
              type: 'photo',
              url: 'https://example.com/photo.jpg',
              uploadDate: DateTime.now().subtract(const Duration(days: 5)),
            ),
            Document(
              type: 'emirates id',
              url: 'https://example.com/emirates_id.pdf',
              uploadDate: DateTime.now().subtract(const Duration(days: 3)),
            ),
          ],
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShareholderDetailsScreen(details: details),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                shareholder.isCompany ? Icons.business : Icons.person,
                size: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shareholder.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF1D1B20),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${shareholder.shares} shares (${shareholder.percentage}%)',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  String _buildShareDistribution(List<Shareholder> shareholders) {
    return shareholders
        .map((s) => '${s.name}: ${s.shares} shares (${s.percentage}%)')
        .join('\n');
  }

  String _getRegistrationTypeText(CompanyRegistrationType type) {
    switch (type) {
      case CompanyRegistrationType.newCompany:
        return 'New Company';
      case CompanyRegistrationType.branch:
        return 'Branch';
      case CompanyRegistrationType.redomiciliation:
        return 'Redomiciliation';
    }
  }

  String _getPaymentStatusText(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.partial:
        return 'Partial';
      case PaymentStatus.completed:
        return 'Completed';
    }
  }
} 