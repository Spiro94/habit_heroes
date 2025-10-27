///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsEn implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEn _root = this; // ignore: unused_field

	@override 
	TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

	// Translations
	@override late final TranslationsEmailVerificationLinkSentEn emailVerificationLinkSent = TranslationsEmailVerificationLinkSentEn._(_root);
	@override late final TranslationsForgotPasswordEn forgotPassword = TranslationsForgotPasswordEn._(_root);
	@override late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
	@override late final TranslationsResetPasswordLinkSentEn resetPasswordLinkSent = TranslationsResetPasswordLinkSentEn._(_root);
	@override late final TranslationsResetPasswordEn resetPassword = TranslationsResetPasswordEn._(_root);
	@override late final TranslationsSignInEn signIn = TranslationsSignInEn._(_root);
	@override late final TranslationsSignUpEn signUp = TranslationsSignUpEn._(_root);
	@override late final TranslationsFamilyEn family = TranslationsFamilyEn._(_root);
	@override late final TranslationsNewFamilyMemberEn newFamilyMember = TranslationsNewFamilyMemberEn._(_root);
	@override late final TranslationsNewFamilyEn newFamily = TranslationsNewFamilyEn._(_root);
	@override late final TranslationsProfileEn profile = TranslationsProfileEn._(_root);
	@override late final TranslationsParentDashboardEn parentDashboard = TranslationsParentDashboardEn._(_root);
	@override late final TranslationsParentRewardsEn parentRewards = TranslationsParentRewardsEn._(_root);
	@override late final TranslationsKidsEn kids = TranslationsKidsEn._(_root);
	@override late final TranslationsTasksEn tasks = TranslationsTasksEn._(_root);
	@override late final TranslationsDaysOfWeekEn daysOfWeek = TranslationsDaysOfWeekEn._(_root);
	@override late final TranslationsPartOfDayEn partOfDay = TranslationsPartOfDayEn._(_root);
}

// Path: emailVerificationLinkSent
class TranslationsEmailVerificationLinkSentEn implements TranslationsEmailVerificationLinkSentEsCo {
	TranslationsEmailVerificationLinkSentEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Email Verification Link Sent';
	@override String get subtitle => 'Check your email for you email verification link.';
}

// Path: forgotPassword
class TranslationsForgotPasswordEn implements TranslationsForgotPasswordEsCo {
	TranslationsForgotPasswordEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Forgot Password?';
	@override late final TranslationsForgotPasswordFormEn form = TranslationsForgotPasswordFormEn._(_root);
}

// Path: home
class TranslationsHomeEn implements TranslationsHomeEsCo {
	TranslationsHomeEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Home';
}

// Path: resetPasswordLinkSent
class TranslationsResetPasswordLinkSentEn implements TranslationsResetPasswordLinkSentEsCo {
	TranslationsResetPasswordLinkSentEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Reset Password Link';
	@override String get subtitle => 'Check your email for your reset password link.';
	@override late final TranslationsResetPasswordLinkSentResendEn resend = TranslationsResetPasswordLinkSentResendEn._(_root);
}

// Path: resetPassword
class TranslationsResetPasswordEn implements TranslationsResetPasswordEsCo {
	TranslationsResetPasswordEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Reset Password';
	@override late final TranslationsResetPasswordFormEn form = TranslationsResetPasswordFormEn._(_root);
}

// Path: signIn
class TranslationsSignInEn implements TranslationsSignInEsCo {
	TranslationsSignInEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sign In';
	@override late final TranslationsSignInSignUpEn signUp = TranslationsSignInSignUpEn._(_root);
	@override late final TranslationsSignInForgotPasswordEn forgotPassword = TranslationsSignInForgotPasswordEn._(_root);
	@override late final TranslationsSignInFormEn form = TranslationsSignInFormEn._(_root);
}

// Path: signUp
class TranslationsSignUpEn implements TranslationsSignUpEsCo {
	TranslationsSignUpEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sign Up';
	@override late final TranslationsSignUpFormEn form = TranslationsSignUpFormEn._(_root);
	@override late final TranslationsSignUpResendEmailVerificationEn resendEmailVerification = TranslationsSignUpResendEmailVerificationEn._(_root);
}

// Path: family
class TranslationsFamilyEn implements TranslationsFamilyEsCo {
	TranslationsFamilyEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Familia';
	@override String get addMember => 'Agregar Miembro';
	@override String get noMembers => 'No hay miembros en tu familia.';
	@override late final TranslationsFamilyInviteEn invite = TranslationsFamilyInviteEn._(_root);
	@override late final TranslationsFamilyInvitationsEn invitations = TranslationsFamilyInvitationsEn._(_root);
}

// Path: newFamilyMember
class TranslationsNewFamilyMemberEn implements TranslationsNewFamilyMemberEsCo {
	TranslationsNewFamilyMemberEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nuevo Miembro de la Familia';
	@override late final TranslationsNewFamilyMemberFormEn form = TranslationsNewFamilyMemberFormEn._(_root);
}

// Path: newFamily
class TranslationsNewFamilyEn implements TranslationsNewFamilyEsCo {
	TranslationsNewFamilyEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nueva Familia';
	@override late final TranslationsNewFamilyFormEn form = TranslationsNewFamilyFormEn._(_root);
}

// Path: profile
class TranslationsProfileEn implements TranslationsProfileEsCo {
	TranslationsProfileEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Perfil';
	@override String get update => 'Actualizar Perfil';
	@override String get signOut => 'Cerrar Sesión';
	@override late final TranslationsProfileFormEn form = TranslationsProfileFormEn._(_root);
}

// Path: parentDashboard
class TranslationsParentDashboardEn implements TranslationsParentDashboardEsCo {
	TranslationsParentDashboardEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tablero de Padres';
	@override String get welcome => '¡Bienvenido al Tablero de Padres!';
}

// Path: parentRewards
class TranslationsParentRewardsEn implements TranslationsParentRewardsEsCo {
	TranslationsParentRewardsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Recompensas para Padres';
	@override String get body => 'Lista de recompensas para padres';
}

// Path: kids
class TranslationsKidsEn implements TranslationsKidsEsCo {
	TranslationsKidsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kids';
	@override String get addKid => 'Add Kid';
	@override String get addFirstKid => 'Add First Kid';
	@override String get noKidsYet => 'No kids added yet.';
	@override String get tryAgain => 'Try Again';
	@override String get name => 'Name';
	@override String get nameHint => 'Enter kid\'s name';
	@override String get color => 'Color';
	@override String get tapToSelectColor => 'Tap to select a color';
	@override String get selectColorDescription => 'Select a color for this kid';
	@override String get pickColor => 'Pick a color';
	@override String get save => 'Save';
	@override String get cancel => 'Cancel';
	@override String get select => 'Select';
	@override String get deleteKid => 'Delete Kid';
	@override String deleteKidConfirm({required Object name}) => 'Are you sure you want to delete ${name}?';
	@override String get pleaseEnterName => 'Please enter a name';
	@override String get addKidTitle => 'Add Kid';
	@override String get editKidTitle => 'Edit Kid';
	@override String get somethingWentWrong => 'Something went wrong';
}

// Path: tasks
class TranslationsTasksEn implements TranslationsTasksEsCo {
	TranslationsTasksEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Listado de tareas';
	@override String get createTask => 'Crear tarea';
	@override String get createTaskTitle => 'Crear tarea';
	@override String get updateTaskTitle => 'Actualizar tarea';
	@override String get titleLabel => 'Título';
	@override String get titleHint => 'Ingresa el título de la tarea';
	@override String get titleRequired => 'El título es requerido';
	@override String get assignedTo => 'A quién se le asigna?';
	@override String get assignedToHint => 'Selecciona un niño';
	@override String get selectAKid => 'Selecciona un niño';
	@override String get assignedToLabel => 'Asignado a:';
	@override String get points => 'Puntos (Opcional)';
	@override String get pointsDescription => 'Cantidad de puntos que vale la tarea';
	@override String get pointsLabel => 'Puntos:';
	@override String get pointsHint => '0';
	@override String get specificDateTask => 'Tarea para fecha específica';
	@override String get specificDateDescription => 'Marcar si es para un día específico';
	@override String get specificDate => 'Fecha específica';
	@override String get specificDateHint => 'Seleccionar fecha';
	@override String get selectDateDescription => 'Selecciona la fecha para esta tarea';
	@override String get selectDateError => 'Debes seleccionar una fecha';
	@override String get weeklySchedule => 'Programación semanal';
	@override String get weeklyScheduleDescription => 'Selecciona los días y partes del día para la tarea';
	@override String get scheduleError => 'Selecciona al menos un día y parte del día';
	@override String get createButton => 'Crear Tarea';
	@override String get updateButton => 'Actualizar';
	@override String get noTasksAvailable => 'No hay tareas disponibles.';
	@override String get createFirstTask => 'Crea tu primer tarea';
	@override String get noSchedule => 'Sin programación';
	@override String get dateLabel => 'Fecha:';
	@override String get errorLoadingTask => 'Error al cargar la tarea';
	@override String get errorCreatingTask => 'Error al crear la tarea';
	@override String get errorUpdatingTask => 'Error al actualizar la tarea';
	@override String get deleteTask => 'Eliminar tarea';
	@override String get deleteTaskConfirm => '¿Estás seguro que deseas eliminar esta tarea?';
	@override String get delete => 'Eliminar';
	@override String get tryAgainButton => 'Intentar de nuevo';
}

// Path: daysOfWeek
class TranslationsDaysOfWeekEn implements TranslationsDaysOfWeekEsCo {
	TranslationsDaysOfWeekEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final TranslationsDaysOfWeekMondayEn monday = TranslationsDaysOfWeekMondayEn._(_root);
	@override late final TranslationsDaysOfWeekTuesdayEn tuesday = TranslationsDaysOfWeekTuesdayEn._(_root);
	@override late final TranslationsDaysOfWeekWednesdayEn wednesday = TranslationsDaysOfWeekWednesdayEn._(_root);
	@override late final TranslationsDaysOfWeekThursdayEn thursday = TranslationsDaysOfWeekThursdayEn._(_root);
	@override late final TranslationsDaysOfWeekFridayEn friday = TranslationsDaysOfWeekFridayEn._(_root);
	@override late final TranslationsDaysOfWeekSaturdayEn saturday = TranslationsDaysOfWeekSaturdayEn._(_root);
	@override late final TranslationsDaysOfWeekSundayEn sunday = TranslationsDaysOfWeekSundayEn._(_root);
}

// Path: partOfDay
class TranslationsPartOfDayEn implements TranslationsPartOfDayEsCo {
	TranslationsPartOfDayEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get morning => 'Morning';
	@override String get afternoon => 'Afternoon';
	@override String get night => 'Night';
}

// Path: forgotPassword.form
class TranslationsForgotPasswordFormEn implements TranslationsForgotPasswordFormEsCo {
	TranslationsForgotPasswordFormEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final TranslationsForgotPasswordFormEmailEn email = TranslationsForgotPasswordFormEmailEn._(_root);
	@override late final TranslationsForgotPasswordFormSubmitEn submit = TranslationsForgotPasswordFormSubmitEn._(_root);
}

// Path: resetPasswordLinkSent.resend
class TranslationsResetPasswordLinkSentResendEn implements TranslationsResetPasswordLinkSentResendEsCo {
	TranslationsResetPasswordLinkSentResendEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get question => 'Didn\'t receive a link?';
	@override String get action => 'Resend';
	@override String get success => 'Your reset password link was resent.';
}

// Path: resetPassword.form
class TranslationsResetPasswordFormEn implements TranslationsResetPasswordFormEsCo {
	TranslationsResetPasswordFormEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final TranslationsResetPasswordFormPasswordEn password = TranslationsResetPasswordFormPasswordEn._(_root);
	@override late final TranslationsResetPasswordFormSubmitEn submit = TranslationsResetPasswordFormSubmitEn._(_root);
}

// Path: signIn.signUp
class TranslationsSignInSignUpEn implements TranslationsSignInSignUpEsCo {
	TranslationsSignInSignUpEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get question => 'Need an account?';
	@override String get action => 'Sign Up';
}

// Path: signIn.forgotPassword
class TranslationsSignInForgotPasswordEn implements TranslationsSignInForgotPasswordEsCo {
	TranslationsSignInForgotPasswordEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get question => 'Forgot password?';
}

// Path: signIn.form
class TranslationsSignInFormEn implements TranslationsSignInFormEsCo {
	TranslationsSignInFormEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final TranslationsSignInFormEmailEn email = TranslationsSignInFormEmailEn._(_root);
	@override late final TranslationsSignInFormPasswordEn password = TranslationsSignInFormPasswordEn._(_root);
	@override late final TranslationsSignInFormSubmitEn submit = TranslationsSignInFormSubmitEn._(_root);
}

// Path: signUp.form
class TranslationsSignUpFormEn implements TranslationsSignUpFormEsCo {
	TranslationsSignUpFormEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final TranslationsSignUpFormEmailEn email = TranslationsSignUpFormEmailEn._(_root);
	@override late final TranslationsSignUpFormPasswordEn password = TranslationsSignUpFormPasswordEn._(_root);
	@override late final TranslationsSignUpFormRepeatPasswordEn repeatPassword = TranslationsSignUpFormRepeatPasswordEn._(_root);
	@override late final TranslationsSignUpFormSubmitEn submit = TranslationsSignUpFormSubmitEn._(_root);
}

// Path: signUp.resendEmailVerification
class TranslationsSignUpResendEmailVerificationEn implements TranslationsSignUpResendEmailVerificationEsCo {
	TranslationsSignUpResendEmailVerificationEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get question => 'Still need to verify you email?';
	@override String get action => 'Resend';
	@override late final TranslationsSignUpResendEmailVerificationDialogEn dialog = TranslationsSignUpResendEmailVerificationDialogEn._(_root);
}

// Path: family.invite
class TranslationsFamilyInviteEn implements TranslationsFamilyInviteEsCo {
	TranslationsFamilyInviteEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Invitar a la Familia';
	@override late final TranslationsFamilyInviteEmailEn email = TranslationsFamilyInviteEmailEn._(_root);
	@override String get submit => 'Enviar Invitación';
}

// Path: family.invitations
class TranslationsFamilyInvitationsEn implements TranslationsFamilyInvitationsEsCo {
	TranslationsFamilyInvitationsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Invitaciones';
	@override String get noInvitations => 'No tienes invitaciones pendientes.';
	@override String get accept => 'Aceptar';
	@override String get decline => 'Rechazar';
}

// Path: newFamilyMember.form
class TranslationsNewFamilyMemberFormEn implements TranslationsNewFamilyMemberFormEsCo {
	TranslationsNewFamilyMemberFormEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final TranslationsNewFamilyMemberFormNameEn name = TranslationsNewFamilyMemberFormNameEn._(_root);
	@override late final TranslationsNewFamilyMemberFormEmailEn email = TranslationsNewFamilyMemberFormEmailEn._(_root);
	@override late final TranslationsNewFamilyMemberFormSubmitEn submit = TranslationsNewFamilyMemberFormSubmitEn._(_root);
}

// Path: newFamily.form
class TranslationsNewFamilyFormEn implements TranslationsNewFamilyFormEsCo {
	TranslationsNewFamilyFormEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final TranslationsNewFamilyFormNameEn name = TranslationsNewFamilyFormNameEn._(_root);
	@override late final TranslationsNewFamilyFormSubmitEn submit = TranslationsNewFamilyFormSubmitEn._(_root);
}

// Path: profile.form
class TranslationsProfileFormEn implements TranslationsProfileFormEsCo {
	TranslationsProfileFormEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final TranslationsProfileFormNameEn name = TranslationsProfileFormNameEn._(_root);
	@override late final TranslationsProfileFormAvatarUrlEn avatarUrl = TranslationsProfileFormAvatarUrlEn._(_root);
}

// Path: daysOfWeek.monday
class TranslationsDaysOfWeekMondayEn implements TranslationsDaysOfWeekMondayEsCo {
	TranslationsDaysOfWeekMondayEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get short => 'Mon';
	@override String get full => 'Monday';
}

// Path: daysOfWeek.tuesday
class TranslationsDaysOfWeekTuesdayEn implements TranslationsDaysOfWeekTuesdayEsCo {
	TranslationsDaysOfWeekTuesdayEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get short => 'Tue';
	@override String get full => 'Tuesday';
}

// Path: daysOfWeek.wednesday
class TranslationsDaysOfWeekWednesdayEn implements TranslationsDaysOfWeekWednesdayEsCo {
	TranslationsDaysOfWeekWednesdayEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get short => 'Wed';
	@override String get full => 'Wednesday';
}

// Path: daysOfWeek.thursday
class TranslationsDaysOfWeekThursdayEn implements TranslationsDaysOfWeekThursdayEsCo {
	TranslationsDaysOfWeekThursdayEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get short => 'Thu';
	@override String get full => 'Thursday';
}

// Path: daysOfWeek.friday
class TranslationsDaysOfWeekFridayEn implements TranslationsDaysOfWeekFridayEsCo {
	TranslationsDaysOfWeekFridayEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get short => 'Fri';
	@override String get full => 'Friday';
}

// Path: daysOfWeek.saturday
class TranslationsDaysOfWeekSaturdayEn implements TranslationsDaysOfWeekSaturdayEsCo {
	TranslationsDaysOfWeekSaturdayEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get short => 'Sat';
	@override String get full => 'Saturday';
}

// Path: daysOfWeek.sunday
class TranslationsDaysOfWeekSundayEn implements TranslationsDaysOfWeekSundayEsCo {
	TranslationsDaysOfWeekSundayEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get short => 'Sun';
	@override String get full => 'Sunday';
}

// Path: forgotPassword.form.email
class TranslationsForgotPasswordFormEmailEn implements TranslationsForgotPasswordFormEmailEsCo {
	TranslationsForgotPasswordFormEmailEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Email';
	@override String get hint => 'john.doe@example.com';
	@override late final TranslationsForgotPasswordFormEmailErrorEn error = TranslationsForgotPasswordFormEmailErrorEn._(_root);
}

// Path: forgotPassword.form.submit
class TranslationsForgotPasswordFormSubmitEn implements TranslationsForgotPasswordFormSubmitEsCo {
	TranslationsForgotPasswordFormSubmitEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Reset Password';
}

// Path: resetPassword.form.password
class TranslationsResetPasswordFormPasswordEn implements TranslationsResetPasswordFormPasswordEsCo {
	TranslationsResetPasswordFormPasswordEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Password';
	@override late final TranslationsResetPasswordFormPasswordErrorEn error = TranslationsResetPasswordFormPasswordErrorEn._(_root);
}

// Path: resetPassword.form.submit
class TranslationsResetPasswordFormSubmitEn implements TranslationsResetPasswordFormSubmitEsCo {
	TranslationsResetPasswordFormSubmitEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Reset Password';
	@override String get success => 'Your password was reset.';
}

// Path: signIn.form.email
class TranslationsSignInFormEmailEn implements TranslationsSignInFormEmailEsCo {
	TranslationsSignInFormEmailEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Email';
	@override String get hint => 'john.doe@example.com';
	@override late final TranslationsSignInFormEmailErrorEn error = TranslationsSignInFormEmailErrorEn._(_root);
}

// Path: signIn.form.password
class TranslationsSignInFormPasswordEn implements TranslationsSignInFormPasswordEsCo {
	TranslationsSignInFormPasswordEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Password';
	@override late final TranslationsSignInFormPasswordErrorEn error = TranslationsSignInFormPasswordErrorEn._(_root);
}

// Path: signIn.form.submit
class TranslationsSignInFormSubmitEn implements TranslationsSignInFormSubmitEsCo {
	TranslationsSignInFormSubmitEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Sign In';
}

// Path: signUp.form.email
class TranslationsSignUpFormEmailEn implements TranslationsSignUpFormEmailEsCo {
	TranslationsSignUpFormEmailEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Email';
	@override String get hint => 'john.doe@example.com';
	@override late final TranslationsSignUpFormEmailErrorEn error = TranslationsSignUpFormEmailErrorEn._(_root);
}

// Path: signUp.form.password
class TranslationsSignUpFormPasswordEn implements TranslationsSignUpFormPasswordEsCo {
	TranslationsSignUpFormPasswordEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Password';
	@override late final TranslationsSignUpFormPasswordErrorEn error = TranslationsSignUpFormPasswordErrorEn._(_root);
}

// Path: signUp.form.repeatPassword
class TranslationsSignUpFormRepeatPasswordEn implements TranslationsSignUpFormRepeatPasswordEsCo {
	TranslationsSignUpFormRepeatPasswordEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Repeat Password';
	@override late final TranslationsSignUpFormRepeatPasswordErrorEn error = TranslationsSignUpFormRepeatPasswordErrorEn._(_root);
}

// Path: signUp.form.submit
class TranslationsSignUpFormSubmitEn implements TranslationsSignUpFormSubmitEsCo {
	TranslationsSignUpFormSubmitEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Sign Up';
}

// Path: signUp.resendEmailVerification.dialog
class TranslationsSignUpResendEmailVerificationDialogEn implements TranslationsSignUpResendEmailVerificationDialogEsCo {
	TranslationsSignUpResendEmailVerificationDialogEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Email Verification Link';
	@override String get cancel => 'Cancel';
	@override late final TranslationsSignUpResendEmailVerificationDialogSubmitEn submit = TranslationsSignUpResendEmailVerificationDialogSubmitEn._(_root);
}

// Path: family.invite.email
class TranslationsFamilyInviteEmailEn implements TranslationsFamilyInviteEmailEsCo {
	TranslationsFamilyInviteEmailEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Correo electrónico del miembro';
	@override String get hint => 'jane.doe@example.com';
	@override late final TranslationsFamilyInviteEmailErrorEn error = TranslationsFamilyInviteEmailErrorEn._(_root);
}

// Path: newFamilyMember.form.name
class TranslationsNewFamilyMemberFormNameEn implements TranslationsNewFamilyMemberFormNameEsCo {
	TranslationsNewFamilyMemberFormNameEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Nombre';
	@override String get hint => 'Jane Doe';
	@override late final TranslationsNewFamilyMemberFormNameErrorEn error = TranslationsNewFamilyMemberFormNameErrorEn._(_root);
}

// Path: newFamilyMember.form.email
class TranslationsNewFamilyMemberFormEmailEn implements TranslationsNewFamilyMemberFormEmailEsCo {
	TranslationsNewFamilyMemberFormEmailEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Correo electrónico';
	@override String get hint => 'jane.doe@example.com';
	@override late final TranslationsNewFamilyMemberFormEmailErrorEn error = TranslationsNewFamilyMemberFormEmailErrorEn._(_root);
}

// Path: newFamilyMember.form.submit
class TranslationsNewFamilyMemberFormSubmitEn implements TranslationsNewFamilyMemberFormSubmitEsCo {
	TranslationsNewFamilyMemberFormSubmitEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Agregar Miembro';
	@override String get success => 'Miembro de la familia agregado.';
}

// Path: newFamily.form.name
class TranslationsNewFamilyFormNameEn implements TranslationsNewFamilyFormNameEsCo {
	TranslationsNewFamilyFormNameEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Nombre de la Familia';
	@override String get hint => 'Los Doe';
	@override late final TranslationsNewFamilyFormNameErrorEn error = TranslationsNewFamilyFormNameErrorEn._(_root);
}

// Path: newFamily.form.submit
class TranslationsNewFamilyFormSubmitEn implements TranslationsNewFamilyFormSubmitEsCo {
	TranslationsNewFamilyFormSubmitEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Crear Familia';
	@override String get success => 'Familia creada.';
}

// Path: profile.form.name
class TranslationsProfileFormNameEn implements TranslationsProfileFormNameEsCo {
	TranslationsProfileFormNameEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Nombre';
	@override String get hint => 'John Doe';
}

// Path: profile.form.avatarUrl
class TranslationsProfileFormAvatarUrlEn implements TranslationsProfileFormAvatarUrlEsCo {
	TranslationsProfileFormAvatarUrlEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'URL del Avatar';
	@override String get hint => 'https://example.com/avatar.png';
}

// Path: forgotPassword.form.email.error
class TranslationsForgotPasswordFormEmailErrorEn implements TranslationsForgotPasswordFormEmailErrorEsCo {
	TranslationsForgotPasswordFormEmailErrorEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Please enter your email address.';
	@override String get invalid => 'Please enter a valid email address.';
}

// Path: resetPassword.form.password.error
class TranslationsResetPasswordFormPasswordErrorEn implements TranslationsResetPasswordFormPasswordErrorEsCo {
	TranslationsResetPasswordFormPasswordErrorEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Please enter a password.';
	@override String get invalid => 'Minimum 8 characters, upper and lower case, with at least one special character.';
}

// Path: signIn.form.email.error
class TranslationsSignInFormEmailErrorEn implements TranslationsSignInFormEmailErrorEsCo {
	TranslationsSignInFormEmailErrorEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Please enter your email address.';
	@override String get invalid => 'Please enter a valid email address.';
}

// Path: signIn.form.password.error
class TranslationsSignInFormPasswordErrorEn implements TranslationsSignInFormPasswordErrorEsCo {
	TranslationsSignInFormPasswordErrorEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Please enter a password.';
}

// Path: signUp.form.email.error
class TranslationsSignUpFormEmailErrorEn implements TranslationsSignUpFormEmailErrorEsCo {
	TranslationsSignUpFormEmailErrorEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Please enter your email address.';
	@override String get invalid => 'Please enter a valid email address.';
}

// Path: signUp.form.password.error
class TranslationsSignUpFormPasswordErrorEn implements TranslationsSignUpFormPasswordErrorEsCo {
	TranslationsSignUpFormPasswordErrorEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Please enter a password.';
	@override String get invalid => 'Minimum 8 characters, upper and lower case, with at least one special character.';
}

// Path: signUp.form.repeatPassword.error
class TranslationsSignUpFormRepeatPasswordErrorEn implements TranslationsSignUpFormRepeatPasswordErrorEsCo {
	TranslationsSignUpFormRepeatPasswordErrorEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Please repeat your password.';
	@override String get mismatch => 'Passwords do not match.';
}

// Path: signUp.resendEmailVerification.dialog.submit
class TranslationsSignUpResendEmailVerificationDialogSubmitEn implements TranslationsSignUpResendEmailVerificationDialogSubmitEsCo {
	TranslationsSignUpResendEmailVerificationDialogSubmitEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Resend';
	@override String get success => 'Your email verification link was resent.';
}

// Path: family.invite.email.error
class TranslationsFamilyInviteEmailErrorEn implements TranslationsFamilyInviteEmailErrorEsCo {
	TranslationsFamilyInviteEmailErrorEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Por favor ingresa un correo electrónico.';
	@override String get invalid => 'Por favor ingresa un correo electrónico válido.';
}

// Path: newFamilyMember.form.name.error
class TranslationsNewFamilyMemberFormNameErrorEn implements TranslationsNewFamilyMemberFormNameErrorEsCo {
	TranslationsNewFamilyMemberFormNameErrorEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Por favor ingresa un nombre.';
}

// Path: newFamilyMember.form.email.error
class TranslationsNewFamilyMemberFormEmailErrorEn implements TranslationsNewFamilyMemberFormEmailErrorEsCo {
	TranslationsNewFamilyMemberFormEmailErrorEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Por favor ingresa un correo electrónico.';
	@override String get invalid => 'Por favor ingresa un correo electrónico válido.';
}

// Path: newFamily.form.name.error
class TranslationsNewFamilyFormNameErrorEn implements TranslationsNewFamilyFormNameErrorEsCo {
	TranslationsNewFamilyFormNameErrorEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Por favor ingresa un nombre para la familia.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		return _flatMapFunction$0(path);
	}

	dynamic _flatMapFunction$0(String path) {
		switch (path) {
			case 'emailVerificationLinkSent.title': return 'Email Verification Link Sent';
			case 'emailVerificationLinkSent.subtitle': return 'Check your email for you email verification link.';
			case 'forgotPassword.title': return 'Forgot Password?';
			case 'forgotPassword.form.email.label': return 'Email';
			case 'forgotPassword.form.email.hint': return 'john.doe@example.com';
			case 'forgotPassword.form.email.error.empty': return 'Please enter your email address.';
			case 'forgotPassword.form.email.error.invalid': return 'Please enter a valid email address.';
			case 'forgotPassword.form.submit.label': return 'Reset Password';
			case 'home.title': return 'Home';
			case 'resetPasswordLinkSent.title': return 'Reset Password Link';
			case 'resetPasswordLinkSent.subtitle': return 'Check your email for your reset password link.';
			case 'resetPasswordLinkSent.resend.question': return 'Didn\'t receive a link?';
			case 'resetPasswordLinkSent.resend.action': return 'Resend';
			case 'resetPasswordLinkSent.resend.success': return 'Your reset password link was resent.';
			case 'resetPassword.title': return 'Reset Password';
			case 'resetPassword.form.password.label': return 'Password';
			case 'resetPassword.form.password.error.empty': return 'Please enter a password.';
			case 'resetPassword.form.password.error.invalid': return 'Minimum 8 characters, upper and lower case, with at least one special character.';
			case 'resetPassword.form.submit.label': return 'Reset Password';
			case 'resetPassword.form.submit.success': return 'Your password was reset.';
			case 'signIn.title': return 'Sign In';
			case 'signIn.signUp.question': return 'Need an account?';
			case 'signIn.signUp.action': return 'Sign Up';
			case 'signIn.forgotPassword.question': return 'Forgot password?';
			case 'signIn.form.email.label': return 'Email';
			case 'signIn.form.email.hint': return 'john.doe@example.com';
			case 'signIn.form.email.error.empty': return 'Please enter your email address.';
			case 'signIn.form.email.error.invalid': return 'Please enter a valid email address.';
			case 'signIn.form.password.label': return 'Password';
			case 'signIn.form.password.error.empty': return 'Please enter a password.';
			case 'signIn.form.submit.label': return 'Sign In';
			case 'signUp.title': return 'Sign Up';
			case 'signUp.form.email.label': return 'Email';
			case 'signUp.form.email.hint': return 'john.doe@example.com';
			case 'signUp.form.email.error.empty': return 'Please enter your email address.';
			case 'signUp.form.email.error.invalid': return 'Please enter a valid email address.';
			case 'signUp.form.password.label': return 'Password';
			case 'signUp.form.password.error.empty': return 'Please enter a password.';
			case 'signUp.form.password.error.invalid': return 'Minimum 8 characters, upper and lower case, with at least one special character.';
			case 'signUp.form.repeatPassword.label': return 'Repeat Password';
			case 'signUp.form.repeatPassword.error.empty': return 'Please repeat your password.';
			case 'signUp.form.repeatPassword.error.mismatch': return 'Passwords do not match.';
			case 'signUp.form.submit.label': return 'Sign Up';
			case 'signUp.resendEmailVerification.question': return 'Still need to verify you email?';
			case 'signUp.resendEmailVerification.action': return 'Resend';
			case 'signUp.resendEmailVerification.dialog.title': return 'Email Verification Link';
			case 'signUp.resendEmailVerification.dialog.cancel': return 'Cancel';
			case 'signUp.resendEmailVerification.dialog.submit.label': return 'Resend';
			case 'signUp.resendEmailVerification.dialog.submit.success': return 'Your email verification link was resent.';
			case 'family.title': return 'Familia';
			case 'family.addMember': return 'Agregar Miembro';
			case 'family.noMembers': return 'No hay miembros en tu familia.';
			case 'family.invite.title': return 'Invitar a la Familia';
			case 'family.invite.email.label': return 'Correo electrónico del miembro';
			case 'family.invite.email.hint': return 'jane.doe@example.com';
			case 'family.invite.email.error.empty': return 'Por favor ingresa un correo electrónico.';
			case 'family.invite.email.error.invalid': return 'Por favor ingresa un correo electrónico válido.';
			case 'family.invite.submit': return 'Enviar Invitación';
			case 'family.invitations.title': return 'Invitaciones';
			case 'family.invitations.noInvitations': return 'No tienes invitaciones pendientes.';
			case 'family.invitations.accept': return 'Aceptar';
			case 'family.invitations.decline': return 'Rechazar';
			case 'newFamilyMember.title': return 'Nuevo Miembro de la Familia';
			case 'newFamilyMember.form.name.label': return 'Nombre';
			case 'newFamilyMember.form.name.hint': return 'Jane Doe';
			case 'newFamilyMember.form.name.error.empty': return 'Por favor ingresa un nombre.';
			case 'newFamilyMember.form.email.label': return 'Correo electrónico';
			case 'newFamilyMember.form.email.hint': return 'jane.doe@example.com';
			case 'newFamilyMember.form.email.error.empty': return 'Por favor ingresa un correo electrónico.';
			case 'newFamilyMember.form.email.error.invalid': return 'Por favor ingresa un correo electrónico válido.';
			case 'newFamilyMember.form.submit.label': return 'Agregar Miembro';
			case 'newFamilyMember.form.submit.success': return 'Miembro de la familia agregado.';
			case 'newFamily.title': return 'Nueva Familia';
			case 'newFamily.form.name.label': return 'Nombre de la Familia';
			case 'newFamily.form.name.hint': return 'Los Doe';
			case 'newFamily.form.name.error.empty': return 'Por favor ingresa un nombre para la familia.';
			case 'newFamily.form.submit.label': return 'Crear Familia';
			case 'newFamily.form.submit.success': return 'Familia creada.';
			case 'profile.title': return 'Perfil';
			case 'profile.update': return 'Actualizar Perfil';
			case 'profile.signOut': return 'Cerrar Sesión';
			case 'profile.form.name.label': return 'Nombre';
			case 'profile.form.name.hint': return 'John Doe';
			case 'profile.form.avatarUrl.label': return 'URL del Avatar';
			case 'profile.form.avatarUrl.hint': return 'https://example.com/avatar.png';
			case 'parentDashboard.title': return 'Tablero de Padres';
			case 'parentDashboard.welcome': return '¡Bienvenido al Tablero de Padres!';
			case 'parentRewards.title': return 'Recompensas para Padres';
			case 'parentRewards.body': return 'Lista de recompensas para padres';
			case 'kids.title': return 'Kids';
			case 'kids.addKid': return 'Add Kid';
			case 'kids.addFirstKid': return 'Add First Kid';
			case 'kids.noKidsYet': return 'No kids added yet.';
			case 'kids.tryAgain': return 'Try Again';
			case 'kids.name': return 'Name';
			case 'kids.nameHint': return 'Enter kid\'s name';
			case 'kids.color': return 'Color';
			case 'kids.tapToSelectColor': return 'Tap to select a color';
			case 'kids.selectColorDescription': return 'Select a color for this kid';
			case 'kids.pickColor': return 'Pick a color';
			case 'kids.save': return 'Save';
			case 'kids.cancel': return 'Cancel';
			case 'kids.select': return 'Select';
			case 'kids.deleteKid': return 'Delete Kid';
			case 'kids.deleteKidConfirm': return ({required Object name}) => 'Are you sure you want to delete ${name}?';
			case 'kids.pleaseEnterName': return 'Please enter a name';
			case 'kids.addKidTitle': return 'Add Kid';
			case 'kids.editKidTitle': return 'Edit Kid';
			case 'kids.somethingWentWrong': return 'Something went wrong';
			case 'tasks.title': return 'Listado de tareas';
			case 'tasks.createTask': return 'Crear tarea';
			case 'tasks.createTaskTitle': return 'Crear tarea';
			case 'tasks.updateTaskTitle': return 'Actualizar tarea';
			case 'tasks.titleLabel': return 'Título';
			case 'tasks.titleHint': return 'Ingresa el título de la tarea';
			case 'tasks.titleRequired': return 'El título es requerido';
			case 'tasks.assignedTo': return 'A quién se le asigna?';
			case 'tasks.assignedToHint': return 'Selecciona un niño';
			case 'tasks.selectAKid': return 'Selecciona un niño';
			case 'tasks.assignedToLabel': return 'Asignado a:';
			case 'tasks.points': return 'Puntos (Opcional)';
			case 'tasks.pointsDescription': return 'Cantidad de puntos que vale la tarea';
			case 'tasks.pointsLabel': return 'Puntos:';
			case 'tasks.pointsHint': return '0';
			case 'tasks.specificDateTask': return 'Tarea para fecha específica';
			case 'tasks.specificDateDescription': return 'Marcar si es para un día específico';
			case 'tasks.specificDate': return 'Fecha específica';
			case 'tasks.specificDateHint': return 'Seleccionar fecha';
			case 'tasks.selectDateDescription': return 'Selecciona la fecha para esta tarea';
			case 'tasks.selectDateError': return 'Debes seleccionar una fecha';
			case 'tasks.weeklySchedule': return 'Programación semanal';
			case 'tasks.weeklyScheduleDescription': return 'Selecciona los días y partes del día para la tarea';
			case 'tasks.scheduleError': return 'Selecciona al menos un día y parte del día';
			case 'tasks.createButton': return 'Crear Tarea';
			case 'tasks.updateButton': return 'Actualizar';
			case 'tasks.noTasksAvailable': return 'No hay tareas disponibles.';
			case 'tasks.createFirstTask': return 'Crea tu primer tarea';
			case 'tasks.noSchedule': return 'Sin programación';
			case 'tasks.dateLabel': return 'Fecha:';
			case 'tasks.errorLoadingTask': return 'Error al cargar la tarea';
			case 'tasks.errorCreatingTask': return 'Error al crear la tarea';
			case 'tasks.errorUpdatingTask': return 'Error al actualizar la tarea';
			case 'tasks.deleteTask': return 'Eliminar tarea';
			case 'tasks.deleteTaskConfirm': return '¿Estás seguro que deseas eliminar esta tarea?';
			case 'tasks.delete': return 'Eliminar';
			case 'tasks.tryAgainButton': return 'Intentar de nuevo';
			case 'daysOfWeek.monday.short': return 'Mon';
			case 'daysOfWeek.monday.full': return 'Monday';
			case 'daysOfWeek.tuesday.short': return 'Tue';
			case 'daysOfWeek.tuesday.full': return 'Tuesday';
			case 'daysOfWeek.wednesday.short': return 'Wed';
			case 'daysOfWeek.wednesday.full': return 'Wednesday';
			case 'daysOfWeek.thursday.short': return 'Thu';
			case 'daysOfWeek.thursday.full': return 'Thursday';
			case 'daysOfWeek.friday.short': return 'Fri';
			case 'daysOfWeek.friday.full': return 'Friday';
			case 'daysOfWeek.saturday.short': return 'Sat';
			case 'daysOfWeek.saturday.full': return 'Saturday';
			case 'daysOfWeek.sunday.short': return 'Sun';
			case 'daysOfWeek.sunday.full': return 'Sunday';
			case 'partOfDay.morning': return 'Morning';
			case 'partOfDay.afternoon': return 'Afternoon';
			case 'partOfDay.night': return 'Night';
			default: return null;
		}
	}
}

