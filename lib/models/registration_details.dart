enum CompanyRegistrationType {
  newCompany,
  branch,
  redomiciliation,
}

enum PaymentStatus {
  pending,
  partial,
  completed,
}

class Shareholder {
  final String name;
  final bool isCompany;
  final int shares;
  final double percentage;

  Shareholder({
    required this.name,
    required this.isCompany,
    required this.shares,
    required this.percentage,
  });
}

class RegistrationDetails {
  final String id;
  final CompanyRegistrationType registrationType;
  final List<String> businessActivities;
  final DateTime licenseExpiryDate;
  final List<String> companyNameOptions;
  final int visaCount;
  final List<Shareholder> shareholders;
  final double shareCapital;
  final int totalShares;
  final String ubo;
  final String generalManager;
  final String director;
  final String secretary;
  final String freezone;
  final double registrationCost;
  final PaymentStatus paymentStatus;

  RegistrationDetails({
    required this.id,
    required this.registrationType,
    required this.businessActivities,
    required this.licenseExpiryDate,
    required this.companyNameOptions,
    required this.visaCount,
    required this.shareholders,
    required this.shareCapital,
    required this.totalShares,
    required this.ubo,
    required this.generalManager,
    required this.director,
    required this.secretary,
    required this.freezone,
    required this.registrationCost,
    required this.paymentStatus,
  });
} 