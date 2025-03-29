import 'package:flutter/material.dart';
import '../models/registration_details.dart';
import '../models/shareholder_details.dart';
import 'shareholder_details_screen.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Row, Column, Border;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class RegistrationDetailsScreen extends StatelessWidget {
  final RegistrationDetails details;

  const RegistrationDetailsScreen({
    super.key,
    required this.details,
  });

  Future<void> _downloadApplicationForm(BuildContext context) async {
    try {
      // Создаем новую рабочую книгу
      final Workbook workbook = Workbook();
      final Worksheet sheet = workbook.worksheets[0];

      // Устанавливаем стили
      final Style headerStyle = workbook.styles.add('headerStyle');
      headerStyle.fontSize = 16;
      headerStyle.bold = true;
      headerStyle.fontColor = '#000000';

      final Style subHeaderStyle = workbook.styles.add('subHeaderStyle');
      subHeaderStyle.fontSize = 14;
      subHeaderStyle.bold = true;
      subHeaderStyle.fontColor = '#000000';

      final Style contentStyle = workbook.styles.add('contentStyle');
      contentStyle.fontSize = 12;
      contentStyle.fontColor = '#000000';

      // Заголовок
      sheet.getRangeByIndex(1, 1, 1, 2).merge();
      sheet.getRangeByIndex(1, 1).setText('Company Registration Application');
      sheet.getRangeByIndex(1, 1).cellStyle = headerStyle;

      // Информация о компании
      sheet.getRangeByIndex(3, 1, 3, 2).merge();
      sheet.getRangeByIndex(3, 1).setText('Company Information');
      sheet.getRangeByIndex(3, 1).cellStyle = subHeaderStyle;

      sheet.getRangeByIndex(4, 1).setText('Company Name:');
      sheet.getRangeByIndex(4, 2).setText(details.companyNameOptions[0]);
      sheet.getRangeByIndex(4, 1).cellStyle = contentStyle;
      sheet.getRangeByIndex(4, 2).cellStyle = contentStyle;

      sheet.getRangeByIndex(5, 1).setText('Registration Type:');
      sheet.getRangeByIndex(5, 2).setText(_getRegistrationTypeText(details.registrationType));
      sheet.getRangeByIndex(5, 1).cellStyle = contentStyle;
      sheet.getRangeByIndex(5, 2).cellStyle = contentStyle;

      sheet.getRangeByIndex(6, 1).setText('Business Activities:');
      sheet.getRangeByIndex(6, 2).setText(details.businessActivities.join(', '));
      sheet.getRangeByIndex(6, 1).cellStyle = contentStyle;
      sheet.getRangeByIndex(6, 2).cellStyle = contentStyle;

      sheet.getRangeByIndex(7, 1).setText('License Expiry Date:');
      sheet.getRangeByIndex(7, 2).setText('${details.licenseExpiryDate.day}/${details.licenseExpiryDate.month}/${details.licenseExpiryDate.year}');
      sheet.getRangeByIndex(7, 1).cellStyle = contentStyle;
      sheet.getRangeByIndex(7, 2).cellStyle = contentStyle;

      // Информация о визах
      sheet.getRangeByIndex(9, 1, 9, 2).merge();
      sheet.getRangeByIndex(9, 1).setText('Visa Information');
      sheet.getRangeByIndex(9, 1).cellStyle = subHeaderStyle;

      sheet.getRangeByIndex(10, 1).setText('Number of Visas:');
      sheet.getRangeByIndex(10, 2).setText(details.visaCount.toString());
      sheet.getRangeByIndex(10, 1).cellStyle = contentStyle;
      sheet.getRangeByIndex(10, 2).cellStyle = contentStyle;

      // Информация о владельцах
      sheet.getRangeByIndex(12, 1, 12, 2).merge();
      sheet.getRangeByIndex(12, 1).setText('Shareholders');
      sheet.getRangeByIndex(12, 1).cellStyle = subHeaderStyle;

      int row = 13;
      for (var shareholder in details.shareholders) {
        sheet.getRangeByIndex(row, 1).setText('Name:');
        sheet.getRangeByIndex(row, 2).setText(shareholder.name);
        sheet.getRangeByIndex(row, 1).cellStyle = contentStyle;
        sheet.getRangeByIndex(row, 2).cellStyle = contentStyle;

        row++;
        sheet.getRangeByIndex(row, 1).setText('Shares:');
        sheet.getRangeByIndex(row, 2).setText('${shareholder.shares} (${shareholder.percentage}%)');
        sheet.getRangeByIndex(row, 1).cellStyle = contentStyle;
        sheet.getRangeByIndex(row, 2).cellStyle = contentStyle;
        row++;
      }

      // Информация о капитале
      sheet.getRangeByIndex(row + 1, 1, row + 1, 2).merge();
      sheet.getRangeByIndex(row + 1, 1).setText('Share Capital');
      sheet.getRangeByIndex(row + 1, 1).cellStyle = subHeaderStyle;

      row += 2;
      sheet.getRangeByIndex(row, 1).setText('Total Share Capital:');
      sheet.getRangeByIndex(row, 2).setText('${details.shareCapital.toStringAsFixed(2)} AED');
      sheet.getRangeByIndex(row, 1).cellStyle = contentStyle;
      sheet.getRangeByIndex(row, 2).cellStyle = contentStyle;

      row++;
      sheet.getRangeByIndex(row, 1).setText('Total Shares:');
      sheet.getRangeByIndex(row, 2).setText(details.totalShares.toString());
      sheet.getRangeByIndex(row, 1).cellStyle = contentStyle;
      sheet.getRangeByIndex(row, 2).cellStyle = contentStyle;

      // Информация о назначениях
      row += 2;
      sheet.getRangeByIndex(row, 1, row, 2).merge();
      sheet.getRangeByIndex(row, 1).setText('Appointments');
      sheet.getRangeByIndex(row, 1).cellStyle = subHeaderStyle;

      row++;
      sheet.getRangeByIndex(row, 1).setText('UBO:');
      sheet.getRangeByIndex(row, 2).setText(details.ubo);
      sheet.getRangeByIndex(row, 1).cellStyle = contentStyle;
      sheet.getRangeByIndex(row, 2).cellStyle = contentStyle;

      row++;
      sheet.getRangeByIndex(row, 1).setText('General Manager:');
      sheet.getRangeByIndex(row, 2).setText(details.generalManager);
      sheet.getRangeByIndex(row, 1).cellStyle = contentStyle;
      sheet.getRangeByIndex(row, 2).cellStyle = contentStyle;

      row++;
      sheet.getRangeByIndex(row, 1).setText('Director:');
      sheet.getRangeByIndex(row, 2).setText(details.director);
      sheet.getRangeByIndex(row, 1).cellStyle = contentStyle;
      sheet.getRangeByIndex(row, 2).cellStyle = contentStyle;

      row++;
      sheet.getRangeByIndex(row, 1).setText('Secretary:');
      sheet.getRangeByIndex(row, 2).setText(details.secretary);
      sheet.getRangeByIndex(row, 1).cellStyle = contentStyle;
      sheet.getRangeByIndex(row, 2).cellStyle = contentStyle;

      // Информация о фризоне
      row += 2;
      sheet.getRangeByIndex(row, 1, row, 2).merge();
      sheet.getRangeByIndex(row, 1).setText('Freezone Information');
      sheet.getRangeByIndex(row, 1).cellStyle = subHeaderStyle;

      row++;
      sheet.getRangeByIndex(row, 1).setText('Selected Freezone:');
      sheet.getRangeByIndex(row, 2).setText(details.freezone);
      sheet.getRangeByIndex(row, 1).cellStyle = contentStyle;
      sheet.getRangeByIndex(row, 2).cellStyle = contentStyle;

      // Информация об оплате
      row += 2;
      sheet.getRangeByIndex(row, 1, row, 2).merge();
      sheet.getRangeByIndex(row, 1).setText('Payment Information');
      sheet.getRangeByIndex(row, 1).cellStyle = subHeaderStyle;

      row++;
      sheet.getRangeByIndex(row, 1).setText('Registration Cost:');
      sheet.getRangeByIndex(row, 2).setText('${details.registrationCost.toStringAsFixed(2)} AED');
      sheet.getRangeByIndex(row, 1).cellStyle = contentStyle;
      sheet.getRangeByIndex(row, 2).cellStyle = contentStyle;

      row++;
      sheet.getRangeByIndex(row, 1).setText('Payment Status:');
      sheet.getRangeByIndex(row, 2).setText(_getPaymentStatusText(details.paymentStatus));
      sheet.getRangeByIndex(row, 1).cellStyle = contentStyle;
      sheet.getRangeByIndex(row, 2).cellStyle = contentStyle;

      // Автоматическая ширина колонок
      sheet.autoFitColumn(1);
      sheet.autoFitColumn(2);

      // Сохраняем файл
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/registration_application_${details.id}.xlsx');
      final List<int> bytes = workbook.saveAsStream();
      await file.writeAsBytes(bytes);

      // Открываем файл
      await OpenFile.open(file.path);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Application form downloaded successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading application form: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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
            icon: const Icon(Icons.download),
            tooltip: 'Download Application Form',
            onPressed: () => _downloadApplicationForm(context),
          ),
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
            _buildActionButtons(context),
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

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              context: context,
              icon: Icons.file_copy_outlined,
              label: 'Request\nDocuments',
              onPressed: () {
                // TODO: Implement document request
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionButton(
              context: context,
              icon: Icons.help_outline,
              label: 'Request\nInformation',
              onPressed: () {
                // TODO: Implement information clarification request
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionButton(
              context: context,
              icon: Icons.verified_user_outlined,
              label: 'Request\nKYC',
              onPressed: () {
                // TODO: Implement KYC request
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionButton(
              context: context,
              icon: Icons.draw_outlined,
              label: 'Request\nSigning',
              onPressed: () {
                // TODO: Implement document signing request
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionButton(
              context: context,
              icon: Icons.more_horiz,
              label: 'Other\nRequest',
              onPressed: () {
                // TODO: Implement other request
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[800],
                  height: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
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