# Privacy Policy for Habit Heroes

**Last Updated:** November 3, 2025 **Effective Date:** November 3, 2025

## 1. Introduction

Habit Heroes Development Team ("we," "us," or "our") is committed to protecting
your privacy and ensuring the security of your personal information. This
Privacy Policy explains how we collect, use, store, and protect your data when
you use the Habit Heroes mobile application (the "App").

By using Habit Heroes, you agree to the collection and use of information in
accordance with this policy. If you do not agree with our policies and
practices, please do not use the App.

## 2. Information We Collect

### 2.1 Authentication Information

- **Email address**: Required for account creation and login
- **Password**: Stored securely in hashed format (never stored in plain text)
- **User ID**: Automatically generated unique identifier
- **Email verification status**: To confirm account ownership

### 2.2 Profile Information

**Parent Profile:**

- Name (required)
- Avatar image (optional)
- Account creation and update timestamps

**Children's Profiles:**

- Names or nicknames (parent-provided - can be any identifier the parent
  chooses)
- Color preferences for UI customization
- Display order preferences

**Important Note on Children's Data:** Children do not directly provide any
information to the App. All children's data is entered, controlled, and managed
entirely by parents or guardians. Parents may use nicknames, initials, or any
identifier they prefer - real names are not required.

### 2.3 Task and Habit Data

- Task templates (titles, descriptions, point values)
- Task schedules (days, times, specific dates)
- Task completion status and timestamps
- Task assignments to children

### 2.4 Points and Rewards System

- Points accumulated per child
- Points history and transaction logs
- Parent-created rewards (names, descriptions, point costs)
- Reward redemption history

### 2.5 Parent Access Control

- Parent PIN: A 4-digit PIN is stored locally on your device only (never
  transmitted to our servers)
- The PIN is stored as a cryptographic hash (SHA-256) for security

### 2.6 Technical Information

- Device operating system and version
- App version and performance metrics
- Error logs (only if error reporting is enabled)

## 3. How We Use Your Information

We use the collected information for the following purposes:

- **App Functionality**: To provide core features including task management,
  habit tracking, and points/rewards systems
- **Authentication**: To verify your identity and secure your account
- **Data Synchronization**: To sync your data across multiple devices
- **Account Management**: To manage your account, family profiles, and
  preferences
- **App Improvement**: To understand how the App is used and improve performance
  (only if analytics are enabled)
- **Error Resolution**: To identify and fix technical issues (only if error
  reporting is enabled)
- **Communication**: To send account-related emails (verification, password
  reset)

We do NOT use your information for:

- Advertising or marketing purposes
- Selling or sharing data with third parties for their marketing
- Tracking your location
- Cross-app tracking or profiling

## 4. Data Storage and Security

### 4.1 Cloud Storage

Your data is stored securely using Supabase, a backend-as-a-service platform:

- **Encryption**: All data is encrypted in transit (HTTPS/TLS) and at rest
- **Access Control**: Row Level Security (RLS) policies ensure you can only
  access your own family's data
- **Data Isolation**: Each parent account has complete isolation from other
  users' data
- **Server Location**: Data is stored on Supabase's cloud infrastructure

For more information about Supabase's security practices, please visit:
https://supabase.com/privacy

### 4.2 Local Device Storage

- **Parent PIN**: Stored locally on your device as a cryptographic hash, never
  transmitted to servers
- **Session Tokens**: Managed securely by the Supabase authentication SDK
- **App Preferences**: Minimal local storage for app settings

### 4.3 Security Measures

We implement industry-standard security measures including:

- Password hashing and secure authentication
- Encrypted data transmission
- Regular security updates
- Database-level access controls
- JWT tokens with automatic expiry and refresh

### 4.4 Data Breach Response

In the unlikely event of a data breach that affects your personal information,
we will notify affected users promptly and take immediate steps to secure the
data and prevent further unauthorized access.

## 5. Third-Party Services

### 5.1 Currently Active Services

**Supabase** (Backend Infrastructure)

- **Purpose**: Database, authentication, and real-time data synchronization
- **Data Shared**: All user data, profiles, tasks, points, and rewards
- **Privacy Policy**: https://supabase.com/privacy

### 5.2 Services That May Be Enabled in the Future

We may enable the following services to improve the App experience. If we do, we
will update this Privacy Policy and notify users:

**Sentry** (Error Reporting) - Currently Disabled

- **Purpose**: To track application errors and crashes for debugging
- **Data That Would Be Collected**: Error logs, stack traces, device
  information, user ID
- **Privacy Policy**: https://sentry.io/privacy/

**Mixpanel** (Analytics) - Currently Disabled

- **Purpose**: To understand how users interact with the App and improve user
  experience
- **Data That Would Be Collected**: Page views, navigation patterns, anonymized
  usage statistics
- **Privacy Policy**: https://mixpanel.com/legal/privacy-policy/

**Important**: Analytics and error reporting are currently disabled. We do not
currently collect usage analytics or detailed error reports. If we enable these
services in the future, you will be notified and may have the option to opt out.

## 6. Children's Privacy

Habit Heroes is designed for parents to track their children's habits and tasks.
We take children's privacy seriously:

- **No Direct Data Collection**: Children do not create accounts, provide
  personal information, or interact directly with our servers
- **Parental Control**: All children's information is entered and controlled
  exclusively by parents or guardians
- **Flexible Naming**: Parents can use nicknames, initials, or any identifier
  they choose - real names are not required
- **No Communication with Children**: The App does not communicate directly with
  children
- **Parental Consent**: By creating child profiles, parents consent to the
  storage of the information they provide

**COPPA Compliance (United States)**: If you are in the United States, this App
complies with the Children's Online Privacy Protection Act (COPPA) as all
children's data is parent-provided and parent-controlled.

## 7. Data Retention and Deletion

### 7.1 Automatic Data Retention

- **Completed Tasks**: Automatically deleted 30 days after completion to
  minimize data storage
- **Active Data**: Retained as long as your account is active
- **Account Data**: Retained until you request account deletion

### 7.2 Account Deletion

You can delete your account at any time through the App settings. When you
delete your account:

- Your parent profile is permanently deleted
- All associated children's profiles are deleted
- All tasks, schedules, and points data are deleted
- All rewards and redemption history are deleted
- Deletion is irreversible and cannot be undone

### 7.3 Data Portability

While we do not currently offer an automated data export feature, you can
request a copy of your data by contacting us at scarkov.dev@gmail.com.

## 8. Your Rights and Choices

You have the following rights regarding your personal data:

### 8.1 Access

You can access all your data through the App interface at any time.

### 8.2 Modification

You can update or modify your profile information, children's profiles, tasks,
and rewards through the App.

### 8.3 Deletion

You can delete individual children's profiles, tasks, rewards, or your entire
account through the App settings.

### 8.4 Data Correction

If you believe any information we hold about you is incorrect or incomplete, you
can update it directly in the App or contact us for assistance.

### 8.5 Withdrawal of Consent

You can withdraw your consent to data processing by deleting your account. Note
that this will result in the loss of all data and you will no longer be able to
use the App.

## 9. Data Sharing and Disclosure

### 9.1 We Do Not Sell Your Data

We do not sell, rent, or trade your personal information to third parties for
marketing purposes.

### 9.2 Service Providers

We share data only with essential service providers necessary for the App to
function:

- **Supabase**: For backend infrastructure, database, and authentication
  services

### 9.3 Legal Requirements

We may disclose your information if required to do so by law or in response to
valid legal requests, such as:

- Court orders or subpoenas
- Legal processes or government investigations
- Protection of our rights, property, or safety, or that of our users

### 9.4 Business Transfers

In the event of a merger, acquisition, or sale of assets, your data may be
transferred to the acquiring entity. We will notify you of any such change and
provide options regarding your data.

## 10. International Data Transfers

Your data may be transferred to and processed in countries other than your own.
We ensure that appropriate safeguards are in place to protect your data in
accordance with this Privacy Policy, regardless of where it is processed.

## 11. App Permissions

Habit Heroes requests minimal permissions:

### 11.1 Required Permissions

- **Internet Access**: Required for authentication, data synchronization, and
  communication with backend services

### 11.2 Permissions We Do NOT Request

- Camera or photo access
- Location tracking
- Contacts access
- Microphone access
- Storage access (beyond app-specific data)
- Phone state or identity
- SMS or call logs

## 12. Updates to Privacy Policy

We may update this Privacy Policy from time to time to reflect changes in our
practices, technology, legal requirements, or other factors. When we make
changes:

- We will update the "Last Updated" date at the top of this policy
- For material changes, we will notify users through the App or via email
- Continued use of the App after changes constitutes acceptance of the updated
  policy

We encourage you to review this Privacy Policy periodically to stay informed
about how we protect your data.

## 13. Contact Us

If you have any questions, concerns, or requests regarding this Privacy Policy
or our data practices, please contact us:

**Email**: scarkov.dev@gmail.com **Response Time**: We aim to respond to all
inquiries within 10 business days

For specific requests regarding your data (access, correction, deletion), please
include:

- Your registered email address
- A clear description of your request
- Any relevant details to help us locate your data

## 14. Governing Law

This Privacy Policy is governed by and construed in accordance with applicable
data protection laws. Any disputes arising from this policy will be resolved in
accordance with the laws of the jurisdiction where Habit Heroes Development Team
operates.

## 15. Additional Information

### 15.1 Do Not Track

Some browsers have a "Do Not Track" feature. Because there is no common
understanding of how to interpret Do Not Track signals, we do not currently
respond to Do Not Track signals.

### 15.2 California Privacy Rights

If you are a California resident, you may have additional rights under the
California Consumer Privacy Act (CCPA). Please contact us for more information
about exercising these rights.

### 15.3 European Users (GDPR)

If you are in the European Economic Area, you may have additional rights under
the General Data Protection Regulation (GDPR), including the right to lodge a
complaint with a supervisory authority.

---

**Thank you for trusting Habit Heroes with your family's habit tracking journey.
We are committed to protecting your privacy and providing a safe, secure
experience.**
