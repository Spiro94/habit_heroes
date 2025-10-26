///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEsCo = Translations; // ignore: unused_element

class Translations implements BaseTranslations<AppLocale, Translations> {
  /// Returns the current translations of the given [context].
  ///
  /// Usage:
  /// final t = Translations.of(context);
  static Translations of(BuildContext context) =>
      InheritedLocaleData.of<AppLocale, Translations>(context).translations;

  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  Translations({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, Translations>? meta,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       $meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.esCo,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <es-CO>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final Translations _root = this; // ignore: unused_field

  Translations $copyWith({
    TranslationMetadata<AppLocale, Translations>? meta,
  }) => Translations(meta: meta ?? this.$meta);

  // Translations
  late final TranslationsEmailVerificationLinkSentEsCo
  emailVerificationLinkSent = TranslationsEmailVerificationLinkSentEsCo._(
    _root,
  );
  late final TranslationsForgotPasswordEsCo forgotPassword =
      TranslationsForgotPasswordEsCo._(_root);
  late final TranslationsHomeEsCo home = TranslationsHomeEsCo._(_root);
  late final TranslationsResetPasswordLinkSentEsCo resetPasswordLinkSent =
      TranslationsResetPasswordLinkSentEsCo._(_root);
  late final TranslationsResetPasswordEsCo resetPassword =
      TranslationsResetPasswordEsCo._(_root);
  late final TranslationsSignInEsCo signIn = TranslationsSignInEsCo._(_root);
  late final TranslationsSignUpEsCo signUp = TranslationsSignUpEsCo._(_root);
  late final TranslationsFamilyEsCo family = TranslationsFamilyEsCo._(_root);
  late final TranslationsNewFamilyMemberEsCo newFamilyMember =
      TranslationsNewFamilyMemberEsCo._(_root);
  late final TranslationsNewFamilyEsCo newFamily = TranslationsNewFamilyEsCo._(
    _root,
  );
  late final TranslationsProfileEsCo profile = TranslationsProfileEsCo._(_root);
  late final TranslationsParentDashboardEsCo parentDashboard =
      TranslationsParentDashboardEsCo._(_root);
  late final TranslationsParentRewardsEsCo parentRewards =
      TranslationsParentRewardsEsCo._(_root);
}

// Path: emailVerificationLinkSent
class TranslationsEmailVerificationLinkSentEsCo {
  TranslationsEmailVerificationLinkSentEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Enlace de verificación de correo electrónico enviado'
  String get title => 'Enlace de verificación de correo electrónico enviado';

  /// es-CO: 'Revisa tu correo electrónico para ver el enlace de verificación.'
  String get subtitle =>
      'Revisa tu correo electrónico para ver el enlace de verificación.';
}

// Path: forgotPassword
class TranslationsForgotPasswordEsCo {
  TranslationsForgotPasswordEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: '¿Olvidaste tu contraseña?'
  String get title => '¿Olvidaste tu contraseña?';

  late final TranslationsForgotPasswordFormEsCo form =
      TranslationsForgotPasswordFormEsCo._(_root);
}

// Path: home
class TranslationsHomeEsCo {
  TranslationsHomeEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Inicio'
  String get title => 'Inicio';
}

// Path: resetPasswordLinkSent
class TranslationsResetPasswordLinkSentEsCo {
  TranslationsResetPasswordLinkSentEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Enlace para restablecer la contraseña'
  String get title => 'Enlace para restablecer la contraseña';

  /// es-CO: 'Revisa tu correo electrónico para ver el enlace para restablecer la contraseña.'
  String get subtitle =>
      'Revisa tu correo electrónico para ver el enlace para restablecer la contraseña.';

  late final TranslationsResetPasswordLinkSentResendEsCo resend =
      TranslationsResetPasswordLinkSentResendEsCo._(_root);
}

// Path: resetPassword
class TranslationsResetPasswordEsCo {
  TranslationsResetPasswordEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Restablecer contraseña'
  String get title => 'Restablecer contraseña';

  late final TranslationsResetPasswordFormEsCo form =
      TranslationsResetPasswordFormEsCo._(_root);
}

// Path: signIn
class TranslationsSignInEsCo {
  TranslationsSignInEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Iniciar sesión'
  String get title => 'Iniciar sesión';

  late final TranslationsSignInSignUpEsCo signUp =
      TranslationsSignInSignUpEsCo._(_root);
  late final TranslationsSignInForgotPasswordEsCo forgotPassword =
      TranslationsSignInForgotPasswordEsCo._(_root);
  late final TranslationsSignInFormEsCo form = TranslationsSignInFormEsCo._(
    _root,
  );
}

// Path: signUp
class TranslationsSignUpEsCo {
  TranslationsSignUpEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Regístrate'
  String get title => 'Regístrate';

  late final TranslationsSignUpFormEsCo form = TranslationsSignUpFormEsCo._(
    _root,
  );
  late final TranslationsSignUpResendEmailVerificationEsCo
  resendEmailVerification = TranslationsSignUpResendEmailVerificationEsCo._(
    _root,
  );
}

// Path: family
class TranslationsFamilyEsCo {
  TranslationsFamilyEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Familia'
  String get title => 'Familia';

  /// es-CO: 'Agregar Miembro'
  String get addMember => 'Agregar Miembro';

  /// es-CO: 'No hay miembros en tu familia.'
  String get noMembers => 'No hay miembros en tu familia.';

  late final TranslationsFamilyInviteEsCo invite =
      TranslationsFamilyInviteEsCo._(_root);
  late final TranslationsFamilyInvitationsEsCo invitations =
      TranslationsFamilyInvitationsEsCo._(_root);
}

// Path: newFamilyMember
class TranslationsNewFamilyMemberEsCo {
  TranslationsNewFamilyMemberEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Nuevo Miembro de la Familia'
  String get title => 'Nuevo Miembro de la Familia';

  late final TranslationsNewFamilyMemberFormEsCo form =
      TranslationsNewFamilyMemberFormEsCo._(_root);
}

// Path: newFamily
class TranslationsNewFamilyEsCo {
  TranslationsNewFamilyEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Nueva Familia'
  String get title => 'Nueva Familia';

  late final TranslationsNewFamilyFormEsCo form =
      TranslationsNewFamilyFormEsCo._(_root);
}

// Path: profile
class TranslationsProfileEsCo {
  TranslationsProfileEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Perfil'
  String get title => 'Perfil';

  /// es-CO: 'Actualizar Perfil'
  String get update => 'Actualizar Perfil';

  /// es-CO: 'Cerrar Sesión'
  String get signOut => 'Cerrar Sesión';

  late final TranslationsProfileFormEsCo form = TranslationsProfileFormEsCo._(
    _root,
  );
}

// Path: parentDashboard
class TranslationsParentDashboardEsCo {
  TranslationsParentDashboardEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Tablero de Padres'
  String get title => 'Tablero de Padres';

  /// es-CO: '¡Bienvenido al Tablero de Padres!'
  String get welcome => '¡Bienvenido al Tablero de Padres!';
}

// Path: parentRewards
class TranslationsParentRewardsEsCo {
  TranslationsParentRewardsEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Recompensas para Padres'
  String get title => 'Recompensas para Padres';

  /// es-CO: 'Lista de recompensas para padres'
  String get body => 'Lista de recompensas para padres';
}

// Path: forgotPassword.form
class TranslationsForgotPasswordFormEsCo {
  TranslationsForgotPasswordFormEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsForgotPasswordFormEmailEsCo email =
      TranslationsForgotPasswordFormEmailEsCo._(_root);
  late final TranslationsForgotPasswordFormSubmitEsCo submit =
      TranslationsForgotPasswordFormSubmitEsCo._(_root);
}

// Path: resetPasswordLinkSent.resend
class TranslationsResetPasswordLinkSentResendEsCo {
  TranslationsResetPasswordLinkSentResendEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: '¿No recibiste un enlace?'
  String get question => '¿No recibiste un enlace?';

  /// es-CO: 'Reenviar'
  String get action => 'Reenviar';

  /// es-CO: 'Se reenvió el enlace para restablecer la contraseña.'
  String get success => 'Se reenvió el enlace para restablecer la contraseña.';
}

// Path: resetPassword.form
class TranslationsResetPasswordFormEsCo {
  TranslationsResetPasswordFormEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsResetPasswordFormPasswordEsCo password =
      TranslationsResetPasswordFormPasswordEsCo._(_root);
  late final TranslationsResetPasswordFormSubmitEsCo submit =
      TranslationsResetPasswordFormSubmitEsCo._(_root);
}

// Path: signIn.signUp
class TranslationsSignInSignUpEsCo {
  TranslationsSignInSignUpEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: '¿Necesitas una cuenta?'
  String get question => '¿Necesitas una cuenta?';

  /// es-CO: 'Regístrate'
  String get action => 'Regístrate';
}

// Path: signIn.forgotPassword
class TranslationsSignInForgotPasswordEsCo {
  TranslationsSignInForgotPasswordEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: '¿Olvidaste tu contraseña?'
  String get question => '¿Olvidaste tu contraseña?';
}

// Path: signIn.form
class TranslationsSignInFormEsCo {
  TranslationsSignInFormEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsSignInFormEmailEsCo email =
      TranslationsSignInFormEmailEsCo._(_root);
  late final TranslationsSignInFormPasswordEsCo password =
      TranslationsSignInFormPasswordEsCo._(_root);
  late final TranslationsSignInFormSubmitEsCo submit =
      TranslationsSignInFormSubmitEsCo._(_root);
}

// Path: signUp.form
class TranslationsSignUpFormEsCo {
  TranslationsSignUpFormEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsSignUpFormEmailEsCo email =
      TranslationsSignUpFormEmailEsCo._(_root);
  late final TranslationsSignUpFormPasswordEsCo password =
      TranslationsSignUpFormPasswordEsCo._(_root);
  late final TranslationsSignUpFormSubmitEsCo submit =
      TranslationsSignUpFormSubmitEsCo._(_root);
}

// Path: signUp.resendEmailVerification
class TranslationsSignUpResendEmailVerificationEsCo {
  TranslationsSignUpResendEmailVerificationEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: '¿Aún necesitas verificar tu correo electrónico?'
  String get question => '¿Aún necesitas verificar tu correo electrónico?';

  /// es-CO: 'Reenviar'
  String get action => 'Reenviar';

  late final TranslationsSignUpResendEmailVerificationDialogEsCo dialog =
      TranslationsSignUpResendEmailVerificationDialogEsCo._(_root);
}

// Path: family.invite
class TranslationsFamilyInviteEsCo {
  TranslationsFamilyInviteEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Invitar a la Familia'
  String get title => 'Invitar a la Familia';

  late final TranslationsFamilyInviteEmailEsCo email =
      TranslationsFamilyInviteEmailEsCo._(_root);

  /// es-CO: 'Enviar Invitación'
  String get submit => 'Enviar Invitación';
}

// Path: family.invitations
class TranslationsFamilyInvitationsEsCo {
  TranslationsFamilyInvitationsEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Invitaciones'
  String get title => 'Invitaciones';

  /// es-CO: 'No tienes invitaciones pendientes.'
  String get noInvitations => 'No tienes invitaciones pendientes.';

  /// es-CO: 'Aceptar'
  String get accept => 'Aceptar';

  /// es-CO: 'Rechazar'
  String get decline => 'Rechazar';
}

// Path: newFamilyMember.form
class TranslationsNewFamilyMemberFormEsCo {
  TranslationsNewFamilyMemberFormEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsNewFamilyMemberFormNameEsCo name =
      TranslationsNewFamilyMemberFormNameEsCo._(_root);
  late final TranslationsNewFamilyMemberFormEmailEsCo email =
      TranslationsNewFamilyMemberFormEmailEsCo._(_root);
  late final TranslationsNewFamilyMemberFormSubmitEsCo submit =
      TranslationsNewFamilyMemberFormSubmitEsCo._(_root);
}

// Path: newFamily.form
class TranslationsNewFamilyFormEsCo {
  TranslationsNewFamilyFormEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsNewFamilyFormNameEsCo name =
      TranslationsNewFamilyFormNameEsCo._(_root);
  late final TranslationsNewFamilyFormSubmitEsCo submit =
      TranslationsNewFamilyFormSubmitEsCo._(_root);
}

// Path: profile.form
class TranslationsProfileFormEsCo {
  TranslationsProfileFormEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsProfileFormNameEsCo name =
      TranslationsProfileFormNameEsCo._(_root);
  late final TranslationsProfileFormAvatarUrlEsCo avatarUrl =
      TranslationsProfileFormAvatarUrlEsCo._(_root);
}

// Path: forgotPassword.form.email
class TranslationsForgotPasswordFormEmailEsCo {
  TranslationsForgotPasswordFormEmailEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Correo electrónico'
  String get label => 'Correo electrónico';

  /// es-CO: 'john.doe@example.com'
  String get hint => 'john.doe@example.com';

  late final TranslationsForgotPasswordFormEmailErrorEsCo error =
      TranslationsForgotPasswordFormEmailErrorEsCo._(_root);
}

// Path: forgotPassword.form.submit
class TranslationsForgotPasswordFormSubmitEsCo {
  TranslationsForgotPasswordFormSubmitEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Restablecer contraseña'
  String get label => 'Restablecer contraseña';
}

// Path: resetPassword.form.password
class TranslationsResetPasswordFormPasswordEsCo {
  TranslationsResetPasswordFormPasswordEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Contraseña'
  String get label => 'Contraseña';

  late final TranslationsResetPasswordFormPasswordErrorEsCo error =
      TranslationsResetPasswordFormPasswordErrorEsCo._(_root);
}

// Path: resetPassword.form.submit
class TranslationsResetPasswordFormSubmitEsCo {
  TranslationsResetPasswordFormSubmitEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Restablecer contraseña'
  String get label => 'Restablecer contraseña';

  /// es-CO: 'Tu contraseña fue restablecida.'
  String get success => 'Tu contraseña fue restablecida.';
}

// Path: signIn.form.email
class TranslationsSignInFormEmailEsCo {
  TranslationsSignInFormEmailEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Correo electrónico'
  String get label => 'Correo electrónico';

  /// es-CO: 'john.doe@example.com'
  String get hint => 'john.doe@example.com';

  late final TranslationsSignInFormEmailErrorEsCo error =
      TranslationsSignInFormEmailErrorEsCo._(_root);
}

// Path: signIn.form.password
class TranslationsSignInFormPasswordEsCo {
  TranslationsSignInFormPasswordEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Contraseña'
  String get label => 'Contraseña';

  late final TranslationsSignInFormPasswordErrorEsCo error =
      TranslationsSignInFormPasswordErrorEsCo._(_root);
}

// Path: signIn.form.submit
class TranslationsSignInFormSubmitEsCo {
  TranslationsSignInFormSubmitEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Iniciar sesión'
  String get label => 'Iniciar sesión';
}

// Path: signUp.form.email
class TranslationsSignUpFormEmailEsCo {
  TranslationsSignUpFormEmailEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Correo electrónico'
  String get label => 'Correo electrónico';

  /// es-CO: 'john.doe@example.com'
  String get hint => 'john.doe@example.com';

  late final TranslationsSignUpFormEmailErrorEsCo error =
      TranslationsSignUpFormEmailErrorEsCo._(_root);
}

// Path: signUp.form.password
class TranslationsSignUpFormPasswordEsCo {
  TranslationsSignUpFormPasswordEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Contraseña'
  String get label => 'Contraseña';

  late final TranslationsSignUpFormPasswordErrorEsCo error =
      TranslationsSignUpFormPasswordErrorEsCo._(_root);
}

// Path: signUp.form.submit
class TranslationsSignUpFormSubmitEsCo {
  TranslationsSignUpFormSubmitEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Regístrate'
  String get label => 'Regístrate';
}

// Path: signUp.resendEmailVerification.dialog
class TranslationsSignUpResendEmailVerificationDialogEsCo {
  TranslationsSignUpResendEmailVerificationDialogEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Enlace de verificación de correo electrónico'
  String get title => 'Enlace de verificación de correo electrónico';

  /// es-CO: 'Cancelar'
  String get cancel => 'Cancelar';

  late final TranslationsSignUpResendEmailVerificationDialogSubmitEsCo submit =
      TranslationsSignUpResendEmailVerificationDialogSubmitEsCo._(_root);
}

// Path: family.invite.email
class TranslationsFamilyInviteEmailEsCo {
  TranslationsFamilyInviteEmailEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Correo electrónico del miembro'
  String get label => 'Correo electrónico del miembro';

  /// es-CO: 'jane.doe@example.com'
  String get hint => 'jane.doe@example.com';

  late final TranslationsFamilyInviteEmailErrorEsCo error =
      TranslationsFamilyInviteEmailErrorEsCo._(_root);
}

// Path: newFamilyMember.form.name
class TranslationsNewFamilyMemberFormNameEsCo {
  TranslationsNewFamilyMemberFormNameEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Nombre'
  String get label => 'Nombre';

  /// es-CO: 'Jane Doe'
  String get hint => 'Jane Doe';

  late final TranslationsNewFamilyMemberFormNameErrorEsCo error =
      TranslationsNewFamilyMemberFormNameErrorEsCo._(_root);
}

// Path: newFamilyMember.form.email
class TranslationsNewFamilyMemberFormEmailEsCo {
  TranslationsNewFamilyMemberFormEmailEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Correo electrónico'
  String get label => 'Correo electrónico';

  /// es-CO: 'jane.doe@example.com'
  String get hint => 'jane.doe@example.com';

  late final TranslationsNewFamilyMemberFormEmailErrorEsCo error =
      TranslationsNewFamilyMemberFormEmailErrorEsCo._(_root);
}

// Path: newFamilyMember.form.submit
class TranslationsNewFamilyMemberFormSubmitEsCo {
  TranslationsNewFamilyMemberFormSubmitEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Agregar Miembro'
  String get label => 'Agregar Miembro';

  /// es-CO: 'Miembro de la familia agregado.'
  String get success => 'Miembro de la familia agregado.';
}

// Path: newFamily.form.name
class TranslationsNewFamilyFormNameEsCo {
  TranslationsNewFamilyFormNameEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Nombre de la Familia'
  String get label => 'Nombre de la Familia';

  /// es-CO: 'Los Doe'
  String get hint => 'Los Doe';

  late final TranslationsNewFamilyFormNameErrorEsCo error =
      TranslationsNewFamilyFormNameErrorEsCo._(_root);
}

// Path: newFamily.form.submit
class TranslationsNewFamilyFormSubmitEsCo {
  TranslationsNewFamilyFormSubmitEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Crear Familia'
  String get label => 'Crear Familia';

  /// es-CO: 'Familia creada.'
  String get success => 'Familia creada.';
}

// Path: profile.form.name
class TranslationsProfileFormNameEsCo {
  TranslationsProfileFormNameEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Nombre'
  String get label => 'Nombre';

  /// es-CO: 'John Doe'
  String get hint => 'John Doe';
}

// Path: profile.form.avatarUrl
class TranslationsProfileFormAvatarUrlEsCo {
  TranslationsProfileFormAvatarUrlEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'URL del Avatar'
  String get label => 'URL del Avatar';

  /// es-CO: 'https://example.com/avatar.png'
  String get hint => 'https://example.com/avatar.png';
}

// Path: forgotPassword.form.email.error
class TranslationsForgotPasswordFormEmailErrorEsCo {
  TranslationsForgotPasswordFormEmailErrorEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Por favor ingresa tu correo electrónico.'
  String get empty => 'Por favor ingresa tu correo electrónico.';

  /// es-CO: 'Por favor ingresa un correo electrónico válido.'
  String get invalid => 'Por favor ingresa un correo electrónico válido.';
}

// Path: resetPassword.form.password.error
class TranslationsResetPasswordFormPasswordErrorEsCo {
  TranslationsResetPasswordFormPasswordErrorEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Por favor ingresa una contraseña.'
  String get empty => 'Por favor ingresa una contraseña.';

  /// es-CO: 'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un caracter especial.'
  String get invalid =>
      'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un caracter especial.';
}

// Path: signIn.form.email.error
class TranslationsSignInFormEmailErrorEsCo {
  TranslationsSignInFormEmailErrorEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Por favor ingresa tu correo electrónico.'
  String get empty => 'Por favor ingresa tu correo electrónico.';

  /// es-CO: 'Por favor ingresa un correo electrónico válido.'
  String get invalid => 'Por favor ingresa un correo electrónico válido.';
}

// Path: signIn.form.password.error
class TranslationsSignInFormPasswordErrorEsCo {
  TranslationsSignInFormPasswordErrorEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Por favor ingresa una contraseña.'
  String get empty => 'Por favor ingresa una contraseña.';
}

// Path: signUp.form.email.error
class TranslationsSignUpFormEmailErrorEsCo {
  TranslationsSignUpFormEmailErrorEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Por favor ingresa tu correo electrónico.'
  String get empty => 'Por favor ingresa tu correo electrónico.';

  /// es-CO: 'Por favor ingresa un correo electrónico válido.'
  String get invalid => 'Por favor ingresa un correo electrónico válido.';
}

// Path: signUp.form.password.error
class TranslationsSignUpFormPasswordErrorEsCo {
  TranslationsSignUpFormPasswordErrorEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Por favor ingresa una contraseña.'
  String get empty => 'Por favor ingresa una contraseña.';

  /// es-CO: 'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un caracter especial.'
  String get invalid =>
      'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un caracter especial.';
}

// Path: signUp.resendEmailVerification.dialog.submit
class TranslationsSignUpResendEmailVerificationDialogSubmitEsCo {
  TranslationsSignUpResendEmailVerificationDialogSubmitEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Reenviar'
  String get label => 'Reenviar';

  /// es-CO: 'Se reenvió el enlace de verificación de correo electrónico.'
  String get success =>
      'Se reenvió el enlace de verificación de correo electrónico.';
}

// Path: family.invite.email.error
class TranslationsFamilyInviteEmailErrorEsCo {
  TranslationsFamilyInviteEmailErrorEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Por favor ingresa un correo electrónico.'
  String get empty => 'Por favor ingresa un correo electrónico.';

  /// es-CO: 'Por favor ingresa un correo electrónico válido.'
  String get invalid => 'Por favor ingresa un correo electrónico válido.';
}

// Path: newFamilyMember.form.name.error
class TranslationsNewFamilyMemberFormNameErrorEsCo {
  TranslationsNewFamilyMemberFormNameErrorEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Por favor ingresa un nombre.'
  String get empty => 'Por favor ingresa un nombre.';
}

// Path: newFamilyMember.form.email.error
class TranslationsNewFamilyMemberFormEmailErrorEsCo {
  TranslationsNewFamilyMemberFormEmailErrorEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Por favor ingresa un correo electrónico.'
  String get empty => 'Por favor ingresa un correo electrónico.';

  /// es-CO: 'Por favor ingresa un correo electrónico válido.'
  String get invalid => 'Por favor ingresa un correo electrónico válido.';
}

// Path: newFamily.form.name.error
class TranslationsNewFamilyFormNameErrorEsCo {
  TranslationsNewFamilyFormNameErrorEsCo._(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// es-CO: 'Por favor ingresa un nombre para la familia.'
  String get empty => 'Por favor ingresa un nombre para la familia.';
}

/// The flat map containing all translations for locale <es-CO>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
  dynamic _flatMapFunction(String path) {
    return _flatMapFunction$0(path);
  }

  dynamic _flatMapFunction$0(String path) {
    switch (path) {
      case 'emailVerificationLinkSent.title':
        return 'Enlace de verificación de correo electrónico enviado';
      case 'emailVerificationLinkSent.subtitle':
        return 'Revisa tu correo electrónico para ver el enlace de verificación.';
      case 'forgotPassword.title':
        return '¿Olvidaste tu contraseña?';
      case 'forgotPassword.form.email.label':
        return 'Correo electrónico';
      case 'forgotPassword.form.email.hint':
        return 'john.doe@example.com';
      case 'forgotPassword.form.email.error.empty':
        return 'Por favor ingresa tu correo electrónico.';
      case 'forgotPassword.form.email.error.invalid':
        return 'Por favor ingresa un correo electrónico válido.';
      case 'forgotPassword.form.submit.label':
        return 'Restablecer contraseña';
      case 'home.title':
        return 'Inicio';
      case 'resetPasswordLinkSent.title':
        return 'Enlace para restablecer la contraseña';
      case 'resetPasswordLinkSent.subtitle':
        return 'Revisa tu correo electrónico para ver el enlace para restablecer la contraseña.';
      case 'resetPasswordLinkSent.resend.question':
        return '¿No recibiste un enlace?';
      case 'resetPasswordLinkSent.resend.action':
        return 'Reenviar';
      case 'resetPasswordLinkSent.resend.success':
        return 'Se reenvió el enlace para restablecer la contraseña.';
      case 'resetPassword.title':
        return 'Restablecer contraseña';
      case 'resetPassword.form.password.label':
        return 'Contraseña';
      case 'resetPassword.form.password.error.empty':
        return 'Por favor ingresa una contraseña.';
      case 'resetPassword.form.password.error.invalid':
        return 'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un caracter especial.';
      case 'resetPassword.form.submit.label':
        return 'Restablecer contraseña';
      case 'resetPassword.form.submit.success':
        return 'Tu contraseña fue restablecida.';
      case 'signIn.title':
        return 'Iniciar sesión';
      case 'signIn.signUp.question':
        return '¿Necesitas una cuenta?';
      case 'signIn.signUp.action':
        return 'Regístrate';
      case 'signIn.forgotPassword.question':
        return '¿Olvidaste tu contraseña?';
      case 'signIn.form.email.label':
        return 'Correo electrónico';
      case 'signIn.form.email.hint':
        return 'john.doe@example.com';
      case 'signIn.form.email.error.empty':
        return 'Por favor ingresa tu correo electrónico.';
      case 'signIn.form.email.error.invalid':
        return 'Por favor ingresa un correo electrónico válido.';
      case 'signIn.form.password.label':
        return 'Contraseña';
      case 'signIn.form.password.error.empty':
        return 'Por favor ingresa una contraseña.';
      case 'signIn.form.submit.label':
        return 'Iniciar sesión';
      case 'signUp.title':
        return 'Regístrate';
      case 'signUp.form.email.label':
        return 'Correo electrónico';
      case 'signUp.form.email.hint':
        return 'john.doe@example.com';
      case 'signUp.form.email.error.empty':
        return 'Por favor ingresa tu correo electrónico.';
      case 'signUp.form.email.error.invalid':
        return 'Por favor ingresa un correo electrónico válido.';
      case 'signUp.form.password.label':
        return 'Contraseña';
      case 'signUp.form.password.error.empty':
        return 'Por favor ingresa una contraseña.';
      case 'signUp.form.password.error.invalid':
        return 'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un caracter especial.';
      case 'signUp.form.submit.label':
        return 'Regístrate';
      case 'signUp.resendEmailVerification.question':
        return '¿Aún necesitas verificar tu correo electrónico?';
      case 'signUp.resendEmailVerification.action':
        return 'Reenviar';
      case 'signUp.resendEmailVerification.dialog.title':
        return 'Enlace de verificación de correo electrónico';
      case 'signUp.resendEmailVerification.dialog.cancel':
        return 'Cancelar';
      case 'signUp.resendEmailVerification.dialog.submit.label':
        return 'Reenviar';
      case 'signUp.resendEmailVerification.dialog.submit.success':
        return 'Se reenvió el enlace de verificación de correo electrónico.';
      case 'family.title':
        return 'Familia';
      case 'family.addMember':
        return 'Agregar Miembro';
      case 'family.noMembers':
        return 'No hay miembros en tu familia.';
      case 'family.invite.title':
        return 'Invitar a la Familia';
      case 'family.invite.email.label':
        return 'Correo electrónico del miembro';
      case 'family.invite.email.hint':
        return 'jane.doe@example.com';
      case 'family.invite.email.error.empty':
        return 'Por favor ingresa un correo electrónico.';
      case 'family.invite.email.error.invalid':
        return 'Por favor ingresa un correo electrónico válido.';
      case 'family.invite.submit':
        return 'Enviar Invitación';
      case 'family.invitations.title':
        return 'Invitaciones';
      case 'family.invitations.noInvitations':
        return 'No tienes invitaciones pendientes.';
      case 'family.invitations.accept':
        return 'Aceptar';
      case 'family.invitations.decline':
        return 'Rechazar';
      case 'newFamilyMember.title':
        return 'Nuevo Miembro de la Familia';
      case 'newFamilyMember.form.name.label':
        return 'Nombre';
      case 'newFamilyMember.form.name.hint':
        return 'Jane Doe';
      case 'newFamilyMember.form.name.error.empty':
        return 'Por favor ingresa un nombre.';
      case 'newFamilyMember.form.email.label':
        return 'Correo electrónico';
      case 'newFamilyMember.form.email.hint':
        return 'jane.doe@example.com';
      case 'newFamilyMember.form.email.error.empty':
        return 'Por favor ingresa un correo electrónico.';
      case 'newFamilyMember.form.email.error.invalid':
        return 'Por favor ingresa un correo electrónico válido.';
      case 'newFamilyMember.form.submit.label':
        return 'Agregar Miembro';
      case 'newFamilyMember.form.submit.success':
        return 'Miembro de la familia agregado.';
      case 'newFamily.title':
        return 'Nueva Familia';
      case 'newFamily.form.name.label':
        return 'Nombre de la Familia';
      case 'newFamily.form.name.hint':
        return 'Los Doe';
      case 'newFamily.form.name.error.empty':
        return 'Por favor ingresa un nombre para la familia.';
      case 'newFamily.form.submit.label':
        return 'Crear Familia';
      case 'newFamily.form.submit.success':
        return 'Familia creada.';
      case 'profile.title':
        return 'Perfil';
      case 'profile.update':
        return 'Actualizar Perfil';
      case 'profile.signOut':
        return 'Cerrar Sesión';
      case 'profile.form.name.label':
        return 'Nombre';
      case 'profile.form.name.hint':
        return 'John Doe';
      case 'profile.form.avatarUrl.label':
        return 'URL del Avatar';
      case 'profile.form.avatarUrl.hint':
        return 'https://example.com/avatar.png';
      case 'parentDashboard.title':
        return 'Tablero de Padres';
      case 'parentDashboard.welcome':
        return '¡Bienvenido al Tablero de Padres!';
      case 'parentRewards.title':
        return 'Recompensas para Padres';
      case 'parentRewards.body':
        return 'Lista de recompensas para padres';
      default:
        return null;
    }
  }
}
