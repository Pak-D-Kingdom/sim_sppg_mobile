// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SIM SPPG Mobile';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get indonesian => 'Indonesian';

  @override
  String get english => 'English';

  @override
  String get profile => 'Profile';

  @override
  String get profileSubtitle => 'Employment info & account settings';

  @override
  String get accountSettings => 'Account Settings';

  @override
  String get accountDetail => 'Account Details';

  @override
  String get accountDetailSubtitle => 'Employment, placement & payroll data';

  @override
  String get employmentAndPayrollData => 'Employment & Payroll Data';

  @override
  String get personalIdentityAndContact => 'PERSONAL IDENTITY & CONTACT';

  @override
  String get nikKtp => 'National ID (NIK)';

  @override
  String get birthPlaceDate => 'Place, Date of Birth';

  @override
  String get officialEmail => 'Official Email';

  @override
  String get whatsappNumber => 'WhatsApp Number';

  @override
  String get domicile => 'Domicile';

  @override
  String get placementAndShift => 'PLACEMENT & SHIFT SCHEDULE';

  @override
  String get kitchenUnit => 'SPPG Kitchen Unit';

  @override
  String get operationalDivision => 'Operational Division';

  @override
  String get joinDate => 'Join Date';

  @override
  String get mainShiftSchedule => 'Main Shift Schedule';

  @override
  String get payrollAccountAndInsurance => 'PAYROLL ACCOUNT & INSURANCE';

  @override
  String get verified => 'Verified';

  @override
  String get disbursementBank => 'Disbursement Bank';

  @override
  String get accountNumber => 'Account Number';

  @override
  String get accountHolderName => 'Account Holder';

  @override
  String get bpjsHealthAndEmployment => 'BPJS Health & Employment';

  @override
  String get dataChangeNotice =>
      'Changes to NIK, payroll bank account, or main shift schedule can only be processed through the SPPG Unit Admin / Central HR.';

  @override
  String get personnelIdLabel => 'PERSONNEL ID';

  @override
  String get workTenureLabel => 'TENURE';

  @override
  String get changePassword => 'Change Password';

  @override
  String get changePasswordSubtitle => 'Update account access security';

  @override
  String get changePasswordHint =>
      'Use at least 8 characters with a combination of letters and numbers to keep your personnel account secure.';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get saveNewPassword => 'Save New Password';

  @override
  String enterField(String label) {
    return 'Enter $label';
  }

  @override
  String get passwordFieldsRequired => 'Please complete all password fields.';

  @override
  String get passwordMinLength8 =>
      'New password must be at least 8 characters.';

  @override
  String get passwordConfirmationMismatch =>
      'New password confirmation does not match.';

  @override
  String get passwordUpdatedSuccess => 'Password updated successfully.';

  @override
  String get helpCenter => 'Help Center & SOP';

  @override
  String get helpCenterSubtitle => 'Operational guide & admin contacts';

  @override
  String get faqBiometricTitle => 'Biometric Attendance & GPS Radius SOP';

  @override
  String get faqBiometricBody =>
      'Make sure GPS is enabled and you are within 50 meters of the SPPG kitchen location when performing Clock-In or Clock-Out.';

  @override
  String get faqSickNoteTitle => 'Doctor\'s Note Upload Procedure';

  @override
  String get faqSickNoteBody =>
      'For Sick Leave requests, upload a doctor\'s note within 48 hours from the absence date through the Leave & Permit menu.';

  @override
  String get faqCorrectionTitle => 'Attendance Correction Request';

  @override
  String get faqCorrectionBody =>
      'If a technical issue occurs during attendance, submit a correction on the Attendance History page for KSPPG verification.';

  @override
  String get faqContactTitle => 'SPPG Operational Admin Contact';

  @override
  String get faqContactBody =>
      'WhatsApp Helpdesk: 0811-9000-2401 (Mon–Sat, 05:00 - 17:00 WIB) or email support@sppg.go.id.';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get changeLanguageSubtitle => 'Select application display language';

  @override
  String get logout => 'Log Out';

  @override
  String get logoutConfirmationTitle => 'Log out of account?';

  @override
  String get logoutConfirmationMessage =>
      'You will need to sign in again using SPPG personnel credentials to access the app.';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get login => 'Sign In';

  @override
  String get loginToAccount => 'Sign In to Account';

  @override
  String get loginSubtitle =>
      'Use your registered Personnel ID or official email';

  @override
  String get appFullSubtitle =>
      'Nutrition Fulfillment Service Unit\nManagement Information System';

  @override
  String get personnelIdOrEmail => 'Personnel ID / Email';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get rememberMe => 'Remember my session';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get loginButtonArrow => 'Sign In  →';

  @override
  String get accountManagedNotice =>
      'Personnel accounts are issued & managed by the SPPG Unit Admin. Contact KSPPG if you do not have access yet.';

  @override
  String get personnelAccessRecovery => 'Personnel Access Recovery';

  @override
  String get forgotPasswordDescription =>
      'Enter your Personnel ID or official SPPG email. A reset link or admin verification will be sent to your registered contact.';

  @override
  String get identifierExampleHint =>
      'Example: SPPG-RMG-014 or name@sppg.go.id';

  @override
  String get sendResetRequest => 'Send Reset Request';

  @override
  String get enterIdentifierError =>
      'Please enter your Personnel ID or official email.';

  @override
  String get resetRequestSent =>
      'Password reset request sent to SPPG Unit Admin & registered email.';

  @override
  String get home => 'Home';

  @override
  String get schedule => 'Schedule';

  @override
  String get attendance => 'Attendance';

  @override
  String get payroll => 'Payroll';

  @override
  String get account => 'Account';

  @override
  String get leaveBalance => 'Leave Balance';

  @override
  String get available => 'Available';

  @override
  String get attendanceLabel => 'Attendance';

  @override
  String get target90 => '90% Target';

  @override
  String get latePenalty => 'Late Penalty';

  @override
  String get primeDiscipline => 'Top Discipline';

  @override
  String get clockIn => 'CLOCK-IN';

  @override
  String get clockOut => 'CLOCK-OUT';

  @override
  String get onTime => 'On Time';

  @override
  String get completed => 'Completed';

  @override
  String get waiting => 'Waiting';

  @override
  String get attendanceCompleted => 'Attendance Completed';

  @override
  String get clockOutNow => 'Clock-Out Now (Leave)';

  @override
  String get failedToLoadData => 'Failed to Load Data';

  @override
  String get personnelSelfService => 'Personnel Self-Service';

  @override
  String mainModulesCount(int count) {
    return '$count Main Modules';
  }

  @override
  String openingModule(String title) {
    return 'Opening module: $title';
  }

  @override
  String get monthlySummary => 'This Month\'s Summary';

  @override
  String get scheduleAndHolidays => 'Schedule & Holidays';

  @override
  String get daySun => 'Sun';

  @override
  String get dayMon => 'Mon';

  @override
  String get dayTue => 'Tue';

  @override
  String get dayWed => 'Wed';

  @override
  String get dayThu => 'Thu';

  @override
  String get dayFri => 'Fri';

  @override
  String get daySat => 'Sat';

  @override
  String get workDay => 'Work Day';

  @override
  String get dayOff => 'Day Off';

  @override
  String get sppgHoliday => 'SPPG Holiday';

  @override
  String get leave => 'Leave';

  @override
  String get kitchenDivision => 'Kitchen Division';

  @override
  String get shiftHours => 'Shift Hours';

  @override
  String get lateTolerance => 'Late Tolerance';

  @override
  String get scheduleStatus => 'Schedule Status';

  @override
  String get workDayUpper => 'WORK DAY';

  @override
  String get dayOffUpper => 'DAY OFF';

  @override
  String get sppgHolidayUpper => 'SPPG HOLIDAY';

  @override
  String get annualLeaveUpper => 'ANNUAL LEAVE';

  @override
  String get dayOffSlashUpper => 'DAY OFF';

  @override
  String get leaveQuotaUpper => 'LEAVE QUOTA';

  @override
  String daysCount(int count) {
    return '$count Days';
  }

  @override
  String get attendanceCheckInTitle => 'Clock-In Attendance';

  @override
  String get attendanceCheckOutTitle => 'Clock-Out Attendance';

  @override
  String get confirmClockIn => 'Confirm Clock-In';

  @override
  String get confirmClockOut => 'Confirm Clock-Out';

  @override
  String get singleCameraNotice =>
      'Only 1 camera is available or running in simulation mode.';

  @override
  String get faceFrameInstruction =>
      'Ensure your face is clearly visible inside the frame without a mask';

  @override
  String get turnOnCamera => 'Turn On Camera';

  @override
  String get capturePhoto => 'Capture';

  @override
  String get retakePhoto => 'Retake Photo';

  @override
  String get cameraOffInstruction =>
      'Tap Turn On Camera to take an attendance photo';

  @override
  String get photoCapturedInstruction =>
      'Photo captured. Please confirm your attendance.';

  @override
  String get cameraPermissionDenied =>
      'Camera permission denied. Enable camera permission to take an attendance photo.';

  @override
  String get cameraUnavailable => 'Camera is unavailable on this device.';

  @override
  String get clockInEntryUpper => 'CLOCK-IN TIME';

  @override
  String get totalWorkDurationUpper => 'TOTAL WORK DURATION';

  @override
  String get kitchenLocationVerified => 'Kitchen Location Verified';

  @override
  String get withinRadius => 'Within Radius';

  @override
  String get outsideRadius => 'Outside Radius';

  @override
  String get attendanceHistory => 'Attendance History';

  @override
  String get noDataForFilter => 'No records for this filter';

  @override
  String get showLess => 'Show Less  ↑';

  @override
  String showAllThisMonth(int count) {
    return 'Show All This Month ($count)  ↓';
  }

  @override
  String get filterAll => 'All';

  @override
  String get filterPresent => 'Present';

  @override
  String get filterLate => 'Late';

  @override
  String get filterLeave => 'Leave';

  @override
  String get presentUpper => 'PRESENT';

  @override
  String get lateUpper => 'LATE';

  @override
  String get leaveUpper => 'LEAVE';

  @override
  String get waitingUpper => 'WAITING';

  @override
  String get correctionSubmitted => 'Correction Submitted';

  @override
  String durationPrefix(String duration) {
    return 'Duration: $duration';
  }

  @override
  String get requestCorrection => 'Request Correction';

  @override
  String get requestAttendanceCorrection => 'Request Attendance Correction';

  @override
  String get correctionReasonHint =>
      'Write correction reason (e.g., GPS issue or supply distribution task)...';

  @override
  String get attendanceTimeCorrection => 'Attendance time correction';

  @override
  String get submitCorrectionRequest => 'Submit Correction Request';

  @override
  String get payrollTitle => 'Payroll';

  @override
  String get payrollHeaderSubtitle => 'SPPG Rawamangun 01 • Closing 25th';

  @override
  String get payslipList => 'Payslip List';

  @override
  String yearLabel(int year) {
    return 'Year $year';
  }

  @override
  String get latestBadge => 'Latest';

  @override
  String get attendanceUpper => 'ATTENDANCE';

  @override
  String get leaveSlashUpper => 'LEAVE / PERMIT';

  @override
  String get latePenaltyUpper => 'LATE PENALTY';

  @override
  String get viewSlipDetails => 'View Slip Details';

  @override
  String get penaltiesAndAllowances => 'Penalties & Allowances';

  @override
  String get payslipDetailTitle => 'Payslip Details';

  @override
  String get paidStatus => 'Paid';

  @override
  String get kitchenUnitUpper => 'KITCHEN UNIT';

  @override
  String get approved => 'Approved';

  @override
  String get earningsUpper => 'EARNINGS (+)';

  @override
  String get basePositionSalary => 'Base Position Salary';

  @override
  String get attendanceAndPositionAllowance => 'Attendance & Role Allowance';

  @override
  String get totalGrossEarnings => 'Total Gross Earnings';

  @override
  String get deductionsUpper => 'DEDUCTIONS (-)';

  @override
  String get totalNetReceived => 'Total Net Received';

  @override
  String get afterPenaltiesAndTax => 'After penalties & tax deductions';

  @override
  String get destinationAccount => 'Destination Account';

  @override
  String get disbursementDate => 'Disbursement Date';

  @override
  String get officialPayslipFooter =>
      'Official document verified by SIM-SPPG payroll system';

  @override
  String get payslipDownloaded => 'Payslip (PDF) downloaded to your device.';

  @override
  String get downloadPayslipPdf => 'Download Payslip (PDF)';

  @override
  String get totalAllowanceUpper => 'TOTAL ALLOWANCE';

  @override
  String get attendanceAndRole => 'Attendance & Role';

  @override
  String get totalLatePenaltyUpper => 'TOTAL LATE PENALTY';

  @override
  String get lateLogThisPeriod => 'Late Log This Period';

  @override
  String get viewInHistory => 'View in History';

  @override
  String get activeAllowanceBreakdown => 'Active Allowance Breakdown';

  @override
  String get attendanceAllowance => 'Attendance Allowance';

  @override
  String get positionAllowance => 'Position Allowance (Nutritionist)';

  @override
  String get totalAllowanceThisPeriod => 'Total Allowance This Period';

  @override
  String get payrollPolicyTitle => 'SPPG Payroll Policy';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get allNotificationsMarkedRead => 'All notifications marked as read';

  @override
  String get markAsRead => 'Mark as read';

  @override
  String get todayUpper => 'TODAY';

  @override
  String messagesCount(int count) {
    return '$count Messages';
  }

  @override
  String get noNotifications => 'No notifications';

  @override
  String filterAllUnread(int count) {
    return 'All ($count)';
  }

  @override
  String get filterOperational => 'Operational';

  @override
  String get filterApproval => 'Approval';

  @override
  String get unread => 'Unread';

  @override
  String get read => 'Read';

  @override
  String get leaveRequestTitle => 'Leave & Permit Request';

  @override
  String get annualLeave => 'Annual Leave';

  @override
  String get sickLeave => 'Sick Leave';

  @override
  String get emergencyLeave => 'Emergency Leave';

  @override
  String get annualLeaveQuotaTitle => '2026 Annual Leave Quota';

  @override
  String get annualLeavePolicyDesc =>
      'Annual leave must be requested at least 2 days ahead. Sick/emergency leave can be submitted on the same day without deducting quota.';

  @override
  String get selectSubmissionDate => 'Select Request Dates';

  @override
  String get startDate => 'Start Date';

  @override
  String get endDate => 'End Date';

  @override
  String durationWorkDays(int days) {
    return '• Duration: $days Work Days';
  }

  @override
  String get remainingBalancePrefix => 'Remaining Balance: ';

  @override
  String get fixedBalancePrefix => 'Unchanged Balance: ';

  @override
  String get reasonOrNotes => 'Reason / Notes';

  @override
  String get reasonHint => 'Write a brief reason for your leave request...';

  @override
  String get attachEvidence => 'Attach Evidence';

  @override
  String get savedFileMeta => 'Saved • 1.2 MB';

  @override
  String get evidenceOptionalHint =>
      'Optional for leave • Mandatory within 48 hours for Sick Leave (JPG, PNG, PDF • Max 2MB)';

  @override
  String get forwardedToCoordinator =>
      'Will be forwarded to SPPG Rawamangun 01 Unit Coordinator.';

  @override
  String get submitRequest => 'Submit Request';

  @override
  String fileAttachedSuccess(String fileName) {
    return 'File \"$fileName\" attached successfully.';
  }

  @override
  String get quotaFree => 'Quota-Free';

  @override
  String get noQuotaDeduction => 'No Quota Deduction';

  @override
  String get sickLeaveTerms => 'Sick Leave Policy';

  @override
  String get selectSickDate => 'Select Sick Dates';

  @override
  String get sickReasonLabel => 'Reason / Symptoms';

  @override
  String get sickReasonHint => 'Describe your symptoms or condition...';

  @override
  String get sendReportToKsppg => 'Send Report to KSPPG';

  @override
  String get waitingSickEvidence => 'Awaiting Sick Evidence';

  @override
  String get uploadDeadline2x24 => 'Upload Deadline (48 Hours)';

  @override
  String get sickReportReceivedNotice =>
      'Initial report has been received by KSPPG. You must upload a doctor\'s note/evidence before the deadline.';

  @override
  String get submittedReportSummary => 'Submitted Report Summary';

  @override
  String get receivedByKsppg => '✓ Received by KSPPG';

  @override
  String get sickDate => 'Sick Date';

  @override
  String get symptoms => 'Symptoms';

  @override
  String get attachSickEvidence => 'Attach Sick Evidence';

  @override
  String get uploadRequired => 'Required';

  @override
  String get fileSelectedReady => 'File selected • Ready to submit';

  @override
  String get takePhotoOrPickDoc => 'Take Photo or Choose Document';

  @override
  String get sickDocHint =>
      'Doctor\'s note, prescription, or clinic proof (JPG, PNG, PDF • Max 2MB)';

  @override
  String get submitSickEvidence => 'Submit Sick Evidence';

  @override
  String get emergencyLeaveTerms => 'Emergency Leave Policy';

  @override
  String get emergencyLeavePolicyDesc =>
      'For urgent same-day situations (family emergency, travel issue, or disaster) without deducting annual leave quota.';

  @override
  String get emergencyTypeAndTime => 'Emergency Type & Time';

  @override
  String get absentFullDay => 'Full Day Absence';

  @override
  String get latePermission => 'Late Arrival Permit';

  @override
  String get shiftDate => 'Shift Date';

  @override
  String get estimatedArrivalTime => 'Estimated Arrival Time';

  @override
  String get emergencyCategory => 'Emergency Category';

  @override
  String get selectEmergencyCategory => 'Select Emergency Category';

  @override
  String get emergencyCategoryExample =>
      'Example: Family ER admission, vehicle breakdown, flood/disaster, etc.';

  @override
  String get shortDescription => 'Short Description';

  @override
  String get emergencyReasonHint =>
      'Briefly explain the emergency situation...';

  @override
  String get emergencyEvidenceHint =>
      'Upload on-site photo, ER letter, or\nscreenshot (JPG, PNG, PDF • Max 2MB)';

  @override
  String get forwardedAsPriority =>
      'Will be forwarded as priority to SPPG\nRawamangun 01 Unit Coordinator.';

  @override
  String get submitLatePermission => 'Submit Late Permit';

  @override
  String get submitEmergencyLeave => 'Submit Emergency Leave';
}
