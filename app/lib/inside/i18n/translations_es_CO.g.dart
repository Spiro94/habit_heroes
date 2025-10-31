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
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.esCo,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es-CO>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsEmailVerificationLinkSentEsCo emailVerificationLinkSent = TranslationsEmailVerificationLinkSentEsCo._(_root);
	late final TranslationsForgotPasswordEsCo forgotPassword = TranslationsForgotPasswordEsCo._(_root);
	late final TranslationsHomeEsCo home = TranslationsHomeEsCo._(_root);
	late final TranslationsResetPasswordLinkSentEsCo resetPasswordLinkSent = TranslationsResetPasswordLinkSentEsCo._(_root);
	late final TranslationsResetPasswordEsCo resetPassword = TranslationsResetPasswordEsCo._(_root);
	late final TranslationsSignInEsCo signIn = TranslationsSignInEsCo._(_root);
	late final TranslationsSignUpEsCo signUp = TranslationsSignUpEsCo._(_root);
	late final TranslationsFamilyEsCo family = TranslationsFamilyEsCo._(_root);
	late final TranslationsNewFamilyMemberEsCo newFamilyMember = TranslationsNewFamilyMemberEsCo._(_root);
	late final TranslationsNewFamilyEsCo newFamily = TranslationsNewFamilyEsCo._(_root);
	late final TranslationsProfileEsCo profile = TranslationsProfileEsCo._(_root);
	late final TranslationsParentDashboardEsCo parentDashboard = TranslationsParentDashboardEsCo._(_root);
	late final TranslationsParentRewardsEsCo parentRewards = TranslationsParentRewardsEsCo._(_root);
	late final TranslationsKidsEsCo kids = TranslationsKidsEsCo._(_root);
	late final TranslationsTasksEsCo tasks = TranslationsTasksEsCo._(_root);
	late final TranslationsDaysOfWeekEsCo daysOfWeek = TranslationsDaysOfWeekEsCo._(_root);
	late final TranslationsPartOfDayEsCo partOfDay = TranslationsPartOfDayEsCo._(_root);
	late final TranslationsCommonEsCo common = TranslationsCommonEsCo._(_root);
	late final TranslationsKidsDashboardEsCo kidsDashboard = TranslationsKidsDashboardEsCo._(_root);
}

// Path: emailVerificationLinkSent
class TranslationsEmailVerificationLinkSentEsCo {
	TranslationsEmailVerificationLinkSentEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Enlace de verificación de correo electrónico enviado'
	String get title => 'Enlace de verificación de correo electrónico enviado';

	/// es-CO: 'Revisa tu correo electrónico para ver el enlace de verificación.'
	String get subtitle => 'Revisa tu correo electrónico para ver el enlace de verificación.';
}

// Path: forgotPassword
class TranslationsForgotPasswordEsCo {
	TranslationsForgotPasswordEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: '¿Olvidaste tu contraseña?'
	String get title => '¿Olvidaste tu contraseña?';

	late final TranslationsForgotPasswordFormEsCo form = TranslationsForgotPasswordFormEsCo._(_root);
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
	String get subtitle => 'Revisa tu correo electrónico para ver el enlace para restablecer la contraseña.';

	late final TranslationsResetPasswordLinkSentResendEsCo resend = TranslationsResetPasswordLinkSentResendEsCo._(_root);
}

// Path: resetPassword
class TranslationsResetPasswordEsCo {
	TranslationsResetPasswordEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Restablecer contraseña'
	String get title => 'Restablecer contraseña';

	late final TranslationsResetPasswordFormEsCo form = TranslationsResetPasswordFormEsCo._(_root);
}

// Path: signIn
class TranslationsSignInEsCo {
	TranslationsSignInEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Iniciar sesión'
	String get title => 'Iniciar sesión';

	late final TranslationsSignInSignUpEsCo signUp = TranslationsSignInSignUpEsCo._(_root);
	late final TranslationsSignInForgotPasswordEsCo forgotPassword = TranslationsSignInForgotPasswordEsCo._(_root);
	late final TranslationsSignInFormEsCo form = TranslationsSignInFormEsCo._(_root);
}

// Path: signUp
class TranslationsSignUpEsCo {
	TranslationsSignUpEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Regístrate'
	String get title => 'Regístrate';

	late final TranslationsSignUpFormEsCo form = TranslationsSignUpFormEsCo._(_root);
	late final TranslationsSignUpResendEmailVerificationEsCo resendEmailVerification = TranslationsSignUpResendEmailVerificationEsCo._(_root);
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

	late final TranslationsFamilyInviteEsCo invite = TranslationsFamilyInviteEsCo._(_root);
	late final TranslationsFamilyInvitationsEsCo invitations = TranslationsFamilyInvitationsEsCo._(_root);
}

// Path: newFamilyMember
class TranslationsNewFamilyMemberEsCo {
	TranslationsNewFamilyMemberEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Nuevo Miembro de la Familia'
	String get title => 'Nuevo Miembro de la Familia';

	late final TranslationsNewFamilyMemberFormEsCo form = TranslationsNewFamilyMemberFormEsCo._(_root);
}

// Path: newFamily
class TranslationsNewFamilyEsCo {
	TranslationsNewFamilyEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Nueva Familia'
	String get title => 'Nueva Familia';

	late final TranslationsNewFamilyFormEsCo form = TranslationsNewFamilyFormEsCo._(_root);
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

	late final TranslationsProfileFormEsCo form = TranslationsProfileFormEsCo._(_root);
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

	late final TranslationsParentRewardsRedemptionsHistoryEsCo redemptionsHistory = TranslationsParentRewardsRedemptionsHistoryEsCo._(_root);
}

// Path: kids
class TranslationsKidsEsCo {
	TranslationsKidsEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Niños'
	String get title => 'Niños';

	/// es-CO: 'Agregar Niño'
	String get addKid => 'Agregar Niño';

	/// es-CO: 'Agrega a tu hijo'
	String get addFirstKid => 'Agrega a tu hijo';

	/// es-CO: 'No hay niños creados aún.'
	String get noKidsYet => 'No hay niños creados aún.';

	/// es-CO: 'Intentar de Nuevo'
	String get tryAgain => 'Intentar de Nuevo';

	/// es-CO: 'Nombre'
	String get name => 'Nombre';

	/// es-CO: 'Ingresa el nombre del niño'
	String get nameHint => 'Ingresa el nombre del niño';

	/// es-CO: 'Color'
	String get color => 'Color';

	/// es-CO: 'Toca para seleccionar un color'
	String get tapToSelectColor => 'Toca para seleccionar un color';

	/// es-CO: 'Selecciona un color para este niño'
	String get selectColorDescription => 'Selecciona un color para este niño';

	/// es-CO: 'Elige un color'
	String get pickColor => 'Elige un color';

	/// es-CO: 'Guardar'
	String get save => 'Guardar';

	/// es-CO: 'Cancelar'
	String get cancel => 'Cancelar';

	/// es-CO: 'Seleccionar'
	String get select => 'Seleccionar';

	/// es-CO: 'Eliminar Niño'
	String get deleteKid => 'Eliminar Niño';

	/// es-CO: '¿Estás seguro que deseas eliminar a $name?'
	String deleteKidConfirm({required Object name}) => '¿Estás seguro que deseas eliminar a ${name}?';

	/// es-CO: 'Por favor ingresa un nombre'
	String get pleaseEnterName => 'Por favor ingresa un nombre';

	/// es-CO: 'Agregar Niño'
	String get addKidTitle => 'Agregar Niño';

	/// es-CO: 'Editar Niño'
	String get editKidTitle => 'Editar Niño';

	/// es-CO: 'Algo salió mal'
	String get somethingWentWrong => 'Algo salió mal';
}

// Path: tasks
class TranslationsTasksEsCo {
	TranslationsTasksEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Listado de tareas'
	String get title => 'Listado de tareas';

	/// es-CO: 'Crear tarea'
	String get createTask => 'Crear tarea';

	/// es-CO: 'Crear tarea'
	String get createTaskTitle => 'Crear tarea';

	/// es-CO: 'Actualizar tarea'
	String get updateTaskTitle => 'Actualizar tarea';

	/// es-CO: 'Título'
	String get titleLabel => 'Título';

	/// es-CO: 'Ingresa el título de la tarea'
	String get titleHint => 'Ingresa el título de la tarea';

	/// es-CO: 'El título es requerido'
	String get titleRequired => 'El título es requerido';

	/// es-CO: '¿A quién se le asigna?'
	String get assignedTo => '¿A quién se le asigna?';

	/// es-CO: 'Selecciona un niño'
	String get assignedToHint => 'Selecciona un niño';

	/// es-CO: 'Selecciona un niño'
	String get selectAKid => 'Selecciona un niño';

	/// es-CO: 'Asignado a:'
	String get assignedToLabel => 'Asignado a:';

	/// es-CO: 'Puntos (Opcional)'
	String get points => 'Puntos (Opcional)';

	/// es-CO: 'Cantidad de puntos que vale la tarea'
	String get pointsDescription => 'Cantidad de puntos que vale la tarea';

	/// es-CO: 'Puntos:'
	String get pointsLabel => 'Puntos:';

	/// es-CO: '0'
	String get pointsHint => '0';

	/// es-CO: 'Tarea para fecha específica'
	String get specificDateTask => 'Tarea para fecha específica';

	/// es-CO: 'Marcar si es para un día específico'
	String get specificDateDescription => 'Marcar si es para un día específico';

	/// es-CO: 'Fecha específica'
	String get specificDate => 'Fecha específica';

	/// es-CO: 'Seleccionar fecha'
	String get specificDateHint => 'Seleccionar fecha';

	/// es-CO: 'Selecciona la fecha para esta tarea'
	String get selectDateDescription => 'Selecciona la fecha para esta tarea';

	/// es-CO: 'Debes seleccionar una fecha'
	String get selectDateError => 'Debes seleccionar una fecha';

	/// es-CO: 'Programación semanal'
	String get weeklySchedule => 'Programación semanal';

	/// es-CO: 'Selecciona los días y partes del día para la tarea'
	String get weeklyScheduleDescription => 'Selecciona los días y partes del día para la tarea';

	/// es-CO: 'Selecciona al menos un día y parte del día'
	String get scheduleError => 'Selecciona al menos un día y parte del día';

	/// es-CO: 'Crear Tarea'
	String get createButton => 'Crear Tarea';

	/// es-CO: 'Actualizar'
	String get updateButton => 'Actualizar';

	/// es-CO: 'No hay tareas disponibles.'
	String get noTasksAvailable => 'No hay tareas disponibles.';

	/// es-CO: 'Crea tu primera tarea'
	String get createFirstTask => 'Crea tu primera tarea';

	/// es-CO: 'Sin programación'
	String get noSchedule => 'Sin programación';

	/// es-CO: 'Fecha:'
	String get dateLabel => 'Fecha:';

	/// es-CO: 'Error al cargar la tarea'
	String get errorLoadingTask => 'Error al cargar la tarea';

	/// es-CO: 'Error al crear la tarea'
	String get errorCreatingTask => 'Error al crear la tarea';

	/// es-CO: 'Error al actualizar la tarea'
	String get errorUpdatingTask => 'Error al actualizar la tarea';

	/// es-CO: 'Eliminar tarea'
	String get deleteTask => 'Eliminar tarea';

	/// es-CO: '¿Estás seguro que deseas eliminar esta tarea?'
	String get deleteTaskConfirm => '¿Estás seguro que deseas eliminar esta tarea?';

	/// es-CO: 'Eliminar'
	String get delete => 'Eliminar';

	/// es-CO: 'Intentar de nuevo'
	String get tryAgainButton => 'Intentar de nuevo';

	/// es-CO: 'Aún no hay niños agregados'
	String get noKidsDialogTitle => 'Aún no hay niños agregados';

	/// es-CO: 'Debes agregar al menos un niño antes de crear una tarea. Las tareas deben asignarse a un niño.'
	String get noKidsDialogMessage => 'Debes agregar al menos un niño antes de crear una tarea. Las tareas deben asignarse a un niño.';

	/// es-CO: 'Agregar Niño'
	String get addKidButton => 'Agregar Niño';
}

// Path: daysOfWeek
class TranslationsDaysOfWeekEsCo {
	TranslationsDaysOfWeekEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsDaysOfWeekMondayEsCo monday = TranslationsDaysOfWeekMondayEsCo._(_root);
	late final TranslationsDaysOfWeekTuesdayEsCo tuesday = TranslationsDaysOfWeekTuesdayEsCo._(_root);
	late final TranslationsDaysOfWeekWednesdayEsCo wednesday = TranslationsDaysOfWeekWednesdayEsCo._(_root);
	late final TranslationsDaysOfWeekThursdayEsCo thursday = TranslationsDaysOfWeekThursdayEsCo._(_root);
	late final TranslationsDaysOfWeekFridayEsCo friday = TranslationsDaysOfWeekFridayEsCo._(_root);
	late final TranslationsDaysOfWeekSaturdayEsCo saturday = TranslationsDaysOfWeekSaturdayEsCo._(_root);
	late final TranslationsDaysOfWeekSundayEsCo sunday = TranslationsDaysOfWeekSundayEsCo._(_root);
}

// Path: partOfDay
class TranslationsPartOfDayEsCo {
	TranslationsPartOfDayEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Mañana'
	String get morning => 'Mañana';

	/// es-CO: 'Tarde'
	String get afternoon => 'Tarde';

	/// es-CO: 'Noche'
	String get night => 'Noche';
}

// Path: common
class TranslationsCommonEsCo {
	TranslationsCommonEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Cancelar'
	String get cancel => 'Cancelar';

	/// es-CO: 'Reintentar'
	String get retry => 'Reintentar';

	/// es-CO: 'Intentar de nuevo'
	String get tryAgain => 'Intentar de nuevo';

	/// es-CO: 'Error desconocido'
	String get unknownError => 'Error desconocido';

	/// es-CO: 'Error: $message'
	String errorWithMessage({required Object message}) => 'Error: ${message}';

	/// es-CO: '$points puntos'
	String pointsLabel({required Object points}) => '${points} puntos';

	/// es-CO: '$points pts'
	String pointsShort({required Object points}) => '${points} pts';
}

// Path: kidsDashboard
class TranslationsKidsDashboardEsCo {
	TranslationsKidsDashboardEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsKidsDashboardAppBarEsCo appBar = TranslationsKidsDashboardAppBarEsCo._(_root);
	late final TranslationsKidsDashboardTabsEsCo tabs = TranslationsKidsDashboardTabsEsCo._(_root);
	late final TranslationsKidsDashboardNavigationEsCo navigation = TranslationsKidsDashboardNavigationEsCo._(_root);
	late final TranslationsKidsDashboardTasksEsCo tasks = TranslationsKidsDashboardTasksEsCo._(_root);
	late final TranslationsKidsDashboardRewardsEsCo rewards = TranslationsKidsDashboardRewardsEsCo._(_root);
	late final TranslationsKidsDashboardKidsPointsEsCo kidsPoints = TranslationsKidsDashboardKidsPointsEsCo._(_root);
	late final TranslationsKidsDashboardKidSelectionEsCo kidSelection = TranslationsKidsDashboardKidSelectionEsCo._(_root);
	late final TranslationsKidsDashboardRewardCardEsCo rewardCard = TranslationsKidsDashboardRewardCardEsCo._(_root);
	late final TranslationsKidsDashboardDateHeaderEsCo dateHeader = TranslationsKidsDashboardDateHeaderEsCo._(_root);
}

// Path: forgotPassword.form
class TranslationsForgotPasswordFormEsCo {
	TranslationsForgotPasswordFormEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsForgotPasswordFormEmailEsCo email = TranslationsForgotPasswordFormEmailEsCo._(_root);
	late final TranslationsForgotPasswordFormSubmitEsCo submit = TranslationsForgotPasswordFormSubmitEsCo._(_root);
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
	late final TranslationsResetPasswordFormPasswordEsCo password = TranslationsResetPasswordFormPasswordEsCo._(_root);
	late final TranslationsResetPasswordFormSubmitEsCo submit = TranslationsResetPasswordFormSubmitEsCo._(_root);
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
	late final TranslationsSignInFormEmailEsCo email = TranslationsSignInFormEmailEsCo._(_root);
	late final TranslationsSignInFormPasswordEsCo password = TranslationsSignInFormPasswordEsCo._(_root);
	late final TranslationsSignInFormSubmitEsCo submit = TranslationsSignInFormSubmitEsCo._(_root);
}

// Path: signUp.form
class TranslationsSignUpFormEsCo {
	TranslationsSignUpFormEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSignUpFormEmailEsCo email = TranslationsSignUpFormEmailEsCo._(_root);
	late final TranslationsSignUpFormPasswordEsCo password = TranslationsSignUpFormPasswordEsCo._(_root);
	late final TranslationsSignUpFormRepeatPasswordEsCo repeatPassword = TranslationsSignUpFormRepeatPasswordEsCo._(_root);
	late final TranslationsSignUpFormSubmitEsCo submit = TranslationsSignUpFormSubmitEsCo._(_root);
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

	late final TranslationsSignUpResendEmailVerificationDialogEsCo dialog = TranslationsSignUpResendEmailVerificationDialogEsCo._(_root);
}

// Path: family.invite
class TranslationsFamilyInviteEsCo {
	TranslationsFamilyInviteEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Invitar a la Familia'
	String get title => 'Invitar a la Familia';

	late final TranslationsFamilyInviteEmailEsCo email = TranslationsFamilyInviteEmailEsCo._(_root);

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
	late final TranslationsNewFamilyMemberFormNameEsCo name = TranslationsNewFamilyMemberFormNameEsCo._(_root);
	late final TranslationsNewFamilyMemberFormEmailEsCo email = TranslationsNewFamilyMemberFormEmailEsCo._(_root);
	late final TranslationsNewFamilyMemberFormSubmitEsCo submit = TranslationsNewFamilyMemberFormSubmitEsCo._(_root);
}

// Path: newFamily.form
class TranslationsNewFamilyFormEsCo {
	TranslationsNewFamilyFormEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsNewFamilyFormNameEsCo name = TranslationsNewFamilyFormNameEsCo._(_root);
	late final TranslationsNewFamilyFormSubmitEsCo submit = TranslationsNewFamilyFormSubmitEsCo._(_root);
}

// Path: profile.form
class TranslationsProfileFormEsCo {
	TranslationsProfileFormEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsProfileFormNameEsCo name = TranslationsProfileFormNameEsCo._(_root);
	late final TranslationsProfileFormAvatarUrlEsCo avatarUrl = TranslationsProfileFormAvatarUrlEsCo._(_root);
}

// Path: parentRewards.redemptionsHistory
class TranslationsParentRewardsRedemptionsHistoryEsCo {
	TranslationsParentRewardsRedemptionsHistoryEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Historial de canjes'
	String get title => 'Historial de canjes';

	/// es-CO: 'Intentar de nuevo'
	String get retryButton => 'Intentar de nuevo';

	/// es-CO: 'No hay canjes registrados'
	String get emptyTitle => 'No hay canjes registrados';

	/// es-CO: 'Los canjes de recompensas aparecerán aquí'
	String get emptySubtitle => 'Los canjes de recompensas aparecerán aquí';

	/// es-CO: 'Recompensa desconocida'
	String get unknownReward => 'Recompensa desconocida';

	/// es-CO: 'Niño desconocido'
	String get unknownKid => 'Niño desconocido';

	/// es-CO: 'Canjeado por: $name'
	String redeemedBy({required Object name}) => 'Canjeado por: ${name}';

	/// es-CO: '$points puntos'
	String points({required Object points}) => '${points} puntos';
}

// Path: daysOfWeek.monday
class TranslationsDaysOfWeekMondayEsCo {
	TranslationsDaysOfWeekMondayEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Lun'
	String get short => 'Lun';

	/// es-CO: 'Lunes'
	String get full => 'Lunes';
}

// Path: daysOfWeek.tuesday
class TranslationsDaysOfWeekTuesdayEsCo {
	TranslationsDaysOfWeekTuesdayEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Mar'
	String get short => 'Mar';

	/// es-CO: 'Martes'
	String get full => 'Martes';
}

// Path: daysOfWeek.wednesday
class TranslationsDaysOfWeekWednesdayEsCo {
	TranslationsDaysOfWeekWednesdayEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Mié'
	String get short => 'Mié';

	/// es-CO: 'Miércoles'
	String get full => 'Miércoles';
}

// Path: daysOfWeek.thursday
class TranslationsDaysOfWeekThursdayEsCo {
	TranslationsDaysOfWeekThursdayEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Jue'
	String get short => 'Jue';

	/// es-CO: 'Jueves'
	String get full => 'Jueves';
}

// Path: daysOfWeek.friday
class TranslationsDaysOfWeekFridayEsCo {
	TranslationsDaysOfWeekFridayEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Vie'
	String get short => 'Vie';

	/// es-CO: 'Viernes'
	String get full => 'Viernes';
}

// Path: daysOfWeek.saturday
class TranslationsDaysOfWeekSaturdayEsCo {
	TranslationsDaysOfWeekSaturdayEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Sáb'
	String get short => 'Sáb';

	/// es-CO: 'Sábado'
	String get full => 'Sábado';
}

// Path: daysOfWeek.sunday
class TranslationsDaysOfWeekSundayEsCo {
	TranslationsDaysOfWeekSundayEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Dom'
	String get short => 'Dom';

	/// es-CO: 'Domingo'
	String get full => 'Domingo';
}

// Path: kidsDashboard.appBar
class TranslationsKidsDashboardAppBarEsCo {
	TranslationsKidsDashboardAppBarEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: '¡Hola, Héroes!'
	String get greetingMobile => '¡Hola, Héroes!';

	/// es-CO: 'Hola, Héroes!'
	String get greetingTablet => 'Hola, Héroes!';
}

// Path: kidsDashboard.tabs
class TranslationsKidsDashboardTabsEsCo {
	TranslationsKidsDashboardTabsEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Mis tareas'
	String get myTasks => 'Mis tareas';

	/// es-CO: 'Recompensas'
	String get rewards => 'Recompensas';
}

// Path: kidsDashboard.navigation
class TranslationsKidsDashboardNavigationEsCo {
	TranslationsKidsDashboardNavigationEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Tareas'
	String get tasks => 'Tareas';

	/// es-CO: 'Recompensas'
	String get rewards => 'Recompensas';
}

// Path: kidsDashboard.tasks
class TranslationsKidsDashboardTasksEsCo {
	TranslationsKidsDashboardTasksEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'No hay tareas para hoy!'
	String get emptyTitle => 'No hay tareas para hoy!';

	/// es-CO: 'Disfruta tu día libre'
	String get emptySubtitle => 'Disfruta tu día libre';

	/// es-CO: 'Ahora'
	String get now => 'Ahora';
}

// Path: kidsDashboard.rewards
class TranslationsKidsDashboardRewardsEsCo {
	TranslationsKidsDashboardRewardsEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Recompensas Disponibles'
	String get title => 'Recompensas Disponibles';

	/// es-CO: 'No hay recompensas disponibles'
	String get empty => 'No hay recompensas disponibles';

	/// es-CO: 'Reintentar'
	String get retry => 'Reintentar';

	/// es-CO: 'Recompensa canjeada!'
	String get successSnack => 'Recompensa canjeada!';
}

// Path: kidsDashboard.kidsPoints
class TranslationsKidsDashboardKidsPointsEsCo {
	TranslationsKidsDashboardKidsPointsEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Puntos por niño'
	String get title => 'Puntos por niño';

	/// es-CO: 'Puntos Acumulados'
	String get accumulated => 'Puntos Acumulados';

	/// es-CO: '$points pts'
	String total({required Object points}) => '${points} pts';
}

// Path: kidsDashboard.kidSelection
class TranslationsKidsDashboardKidSelectionEsCo {
	TranslationsKidsDashboardKidSelectionEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Selecciona quién redime'
	String get title => 'Selecciona quién redime';

	/// es-CO: '$points puntos'
	String points({required Object points}) => '${points} puntos';

	/// es-CO: 'Cancelar'
	String get cancel => 'Cancelar';
}

// Path: kidsDashboard.rewardCard
class TranslationsKidsDashboardRewardCardEsCo {
	TranslationsKidsDashboardRewardCardEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Canjear'
	String get redeem => 'Canjear';

	/// es-CO: 'No hay puntos'
	String get notEnoughPoints => 'No hay puntos';

	/// es-CO: '$points puntos'
	String points({required Object points}) => '${points} puntos';
}

// Path: kidsDashboard.dateHeader
class TranslationsKidsDashboardDateHeaderEsCo {
	TranslationsKidsDashboardDateHeaderEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: '$day de $month'
	String date({required Object day, required Object month}) => '${day} de ${month}';
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

	late final TranslationsForgotPasswordFormEmailErrorEsCo error = TranslationsForgotPasswordFormEmailErrorEsCo._(_root);
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

	late final TranslationsResetPasswordFormPasswordErrorEsCo error = TranslationsResetPasswordFormPasswordErrorEsCo._(_root);
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

	late final TranslationsSignInFormEmailErrorEsCo error = TranslationsSignInFormEmailErrorEsCo._(_root);
}

// Path: signIn.form.password
class TranslationsSignInFormPasswordEsCo {
	TranslationsSignInFormPasswordEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Contraseña'
	String get label => 'Contraseña';

	late final TranslationsSignInFormPasswordErrorEsCo error = TranslationsSignInFormPasswordErrorEsCo._(_root);
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

	late final TranslationsSignUpFormEmailErrorEsCo error = TranslationsSignUpFormEmailErrorEsCo._(_root);
}

// Path: signUp.form.password
class TranslationsSignUpFormPasswordEsCo {
	TranslationsSignUpFormPasswordEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Contraseña'
	String get label => 'Contraseña';

	late final TranslationsSignUpFormPasswordErrorEsCo error = TranslationsSignUpFormPasswordErrorEsCo._(_root);
}

// Path: signUp.form.repeatPassword
class TranslationsSignUpFormRepeatPasswordEsCo {
	TranslationsSignUpFormRepeatPasswordEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Repetir contraseña'
	String get label => 'Repetir contraseña';

	late final TranslationsSignUpFormRepeatPasswordErrorEsCo error = TranslationsSignUpFormRepeatPasswordErrorEsCo._(_root);
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

	late final TranslationsSignUpResendEmailVerificationDialogSubmitEsCo submit = TranslationsSignUpResendEmailVerificationDialogSubmitEsCo._(_root);
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

	late final TranslationsFamilyInviteEmailErrorEsCo error = TranslationsFamilyInviteEmailErrorEsCo._(_root);
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

	late final TranslationsNewFamilyMemberFormNameErrorEsCo error = TranslationsNewFamilyMemberFormNameErrorEsCo._(_root);
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

	late final TranslationsNewFamilyMemberFormEmailErrorEsCo error = TranslationsNewFamilyMemberFormEmailErrorEsCo._(_root);
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

	late final TranslationsNewFamilyFormNameErrorEsCo error = TranslationsNewFamilyFormNameErrorEsCo._(_root);
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
	String get invalid => 'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un caracter especial.';
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
	String get invalid => 'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un caracter especial.';
}

// Path: signUp.form.repeatPassword.error
class TranslationsSignUpFormRepeatPasswordErrorEsCo {
	TranslationsSignUpFormRepeatPasswordErrorEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Por favor repite tu contraseña.'
	String get empty => 'Por favor repite tu contraseña.';

	/// es-CO: 'Las contraseñas no coinciden.'
	String get mismatch => 'Las contraseñas no coinciden.';
}

// Path: signUp.resendEmailVerification.dialog.submit
class TranslationsSignUpResendEmailVerificationDialogSubmitEsCo {
	TranslationsSignUpResendEmailVerificationDialogSubmitEsCo._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// es-CO: 'Reenviar'
	String get label => 'Reenviar';

	/// es-CO: 'Se reenvió el enlace de verificación de correo electrónico.'
	String get success => 'Se reenvió el enlace de verificación de correo electrónico.';
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
			case 'emailVerificationLinkSent.title': return 'Enlace de verificación de correo electrónico enviado';
			case 'emailVerificationLinkSent.subtitle': return 'Revisa tu correo electrónico para ver el enlace de verificación.';
			case 'forgotPassword.title': return '¿Olvidaste tu contraseña?';
			case 'forgotPassword.form.email.label': return 'Correo electrónico';
			case 'forgotPassword.form.email.hint': return 'john.doe@example.com';
			case 'forgotPassword.form.email.error.empty': return 'Por favor ingresa tu correo electrónico.';
			case 'forgotPassword.form.email.error.invalid': return 'Por favor ingresa un correo electrónico válido.';
			case 'forgotPassword.form.submit.label': return 'Restablecer contraseña';
			case 'home.title': return 'Inicio';
			case 'resetPasswordLinkSent.title': return 'Enlace para restablecer la contraseña';
			case 'resetPasswordLinkSent.subtitle': return 'Revisa tu correo electrónico para ver el enlace para restablecer la contraseña.';
			case 'resetPasswordLinkSent.resend.question': return '¿No recibiste un enlace?';
			case 'resetPasswordLinkSent.resend.action': return 'Reenviar';
			case 'resetPasswordLinkSent.resend.success': return 'Se reenvió el enlace para restablecer la contraseña.';
			case 'resetPassword.title': return 'Restablecer contraseña';
			case 'resetPassword.form.password.label': return 'Contraseña';
			case 'resetPassword.form.password.error.empty': return 'Por favor ingresa una contraseña.';
			case 'resetPassword.form.password.error.invalid': return 'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un caracter especial.';
			case 'resetPassword.form.submit.label': return 'Restablecer contraseña';
			case 'resetPassword.form.submit.success': return 'Tu contraseña fue restablecida.';
			case 'signIn.title': return 'Iniciar sesión';
			case 'signIn.signUp.question': return '¿Necesitas una cuenta?';
			case 'signIn.signUp.action': return 'Regístrate';
			case 'signIn.forgotPassword.question': return '¿Olvidaste tu contraseña?';
			case 'signIn.form.email.label': return 'Correo electrónico';
			case 'signIn.form.email.hint': return 'john.doe@example.com';
			case 'signIn.form.email.error.empty': return 'Por favor ingresa tu correo electrónico.';
			case 'signIn.form.email.error.invalid': return 'Por favor ingresa un correo electrónico válido.';
			case 'signIn.form.password.label': return 'Contraseña';
			case 'signIn.form.password.error.empty': return 'Por favor ingresa una contraseña.';
			case 'signIn.form.submit.label': return 'Iniciar sesión';
			case 'signUp.title': return 'Regístrate';
			case 'signUp.form.email.label': return 'Correo electrónico';
			case 'signUp.form.email.hint': return 'john.doe@example.com';
			case 'signUp.form.email.error.empty': return 'Por favor ingresa tu correo electrónico.';
			case 'signUp.form.email.error.invalid': return 'Por favor ingresa un correo electrónico válido.';
			case 'signUp.form.password.label': return 'Contraseña';
			case 'signUp.form.password.error.empty': return 'Por favor ingresa una contraseña.';
			case 'signUp.form.password.error.invalid': return 'Mínimo 8 caracteres, mayúsculas y minúsculas, con al menos un caracter especial.';
			case 'signUp.form.repeatPassword.label': return 'Repetir contraseña';
			case 'signUp.form.repeatPassword.error.empty': return 'Por favor repite tu contraseña.';
			case 'signUp.form.repeatPassword.error.mismatch': return 'Las contraseñas no coinciden.';
			case 'signUp.form.submit.label': return 'Regístrate';
			case 'signUp.resendEmailVerification.question': return '¿Aún necesitas verificar tu correo electrónico?';
			case 'signUp.resendEmailVerification.action': return 'Reenviar';
			case 'signUp.resendEmailVerification.dialog.title': return 'Enlace de verificación de correo electrónico';
			case 'signUp.resendEmailVerification.dialog.cancel': return 'Cancelar';
			case 'signUp.resendEmailVerification.dialog.submit.label': return 'Reenviar';
			case 'signUp.resendEmailVerification.dialog.submit.success': return 'Se reenvió el enlace de verificación de correo electrónico.';
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
			case 'parentRewards.redemptionsHistory.title': return 'Historial de canjes';
			case 'parentRewards.redemptionsHistory.retryButton': return 'Intentar de nuevo';
			case 'parentRewards.redemptionsHistory.emptyTitle': return 'No hay canjes registrados';
			case 'parentRewards.redemptionsHistory.emptySubtitle': return 'Los canjes de recompensas aparecerán aquí';
			case 'parentRewards.redemptionsHistory.unknownReward': return 'Recompensa desconocida';
			case 'parentRewards.redemptionsHistory.unknownKid': return 'Niño desconocido';
			case 'parentRewards.redemptionsHistory.redeemedBy': return ({required Object name}) => 'Canjeado por: ${name}';
			case 'parentRewards.redemptionsHistory.points': return ({required Object points}) => '${points} puntos';
			case 'kids.title': return 'Niños';
			case 'kids.addKid': return 'Agregar Niño';
			case 'kids.addFirstKid': return 'Agrega a tu hijo';
			case 'kids.noKidsYet': return 'No hay niños creados aún.';
			case 'kids.tryAgain': return 'Intentar de Nuevo';
			case 'kids.name': return 'Nombre';
			case 'kids.nameHint': return 'Ingresa el nombre del niño';
			case 'kids.color': return 'Color';
			case 'kids.tapToSelectColor': return 'Toca para seleccionar un color';
			case 'kids.selectColorDescription': return 'Selecciona un color para este niño';
			case 'kids.pickColor': return 'Elige un color';
			case 'kids.save': return 'Guardar';
			case 'kids.cancel': return 'Cancelar';
			case 'kids.select': return 'Seleccionar';
			case 'kids.deleteKid': return 'Eliminar Niño';
			case 'kids.deleteKidConfirm': return ({required Object name}) => '¿Estás seguro que deseas eliminar a ${name}?';
			case 'kids.pleaseEnterName': return 'Por favor ingresa un nombre';
			case 'kids.addKidTitle': return 'Agregar Niño';
			case 'kids.editKidTitle': return 'Editar Niño';
			case 'kids.somethingWentWrong': return 'Algo salió mal';
			case 'tasks.title': return 'Listado de tareas';
			case 'tasks.createTask': return 'Crear tarea';
			case 'tasks.createTaskTitle': return 'Crear tarea';
			case 'tasks.updateTaskTitle': return 'Actualizar tarea';
			case 'tasks.titleLabel': return 'Título';
			case 'tasks.titleHint': return 'Ingresa el título de la tarea';
			case 'tasks.titleRequired': return 'El título es requerido';
			case 'tasks.assignedTo': return '¿A quién se le asigna?';
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
			case 'tasks.createFirstTask': return 'Crea tu primera tarea';
			case 'tasks.noSchedule': return 'Sin programación';
			case 'tasks.dateLabel': return 'Fecha:';
			case 'tasks.errorLoadingTask': return 'Error al cargar la tarea';
			case 'tasks.errorCreatingTask': return 'Error al crear la tarea';
			case 'tasks.errorUpdatingTask': return 'Error al actualizar la tarea';
			case 'tasks.deleteTask': return 'Eliminar tarea';
			case 'tasks.deleteTaskConfirm': return '¿Estás seguro que deseas eliminar esta tarea?';
			case 'tasks.delete': return 'Eliminar';
			case 'tasks.tryAgainButton': return 'Intentar de nuevo';
			case 'tasks.noKidsDialogTitle': return 'Aún no hay niños agregados';
			case 'tasks.noKidsDialogMessage': return 'Debes agregar al menos un niño antes de crear una tarea. Las tareas deben asignarse a un niño.';
			case 'tasks.addKidButton': return 'Agregar Niño';
			case 'daysOfWeek.monday.short': return 'Lun';
			case 'daysOfWeek.monday.full': return 'Lunes';
			case 'daysOfWeek.tuesday.short': return 'Mar';
			case 'daysOfWeek.tuesday.full': return 'Martes';
			case 'daysOfWeek.wednesday.short': return 'Mié';
			case 'daysOfWeek.wednesday.full': return 'Miércoles';
			case 'daysOfWeek.thursday.short': return 'Jue';
			case 'daysOfWeek.thursday.full': return 'Jueves';
			case 'daysOfWeek.friday.short': return 'Vie';
			case 'daysOfWeek.friday.full': return 'Viernes';
			case 'daysOfWeek.saturday.short': return 'Sáb';
			case 'daysOfWeek.saturday.full': return 'Sábado';
			case 'daysOfWeek.sunday.short': return 'Dom';
			case 'daysOfWeek.sunday.full': return 'Domingo';
			case 'partOfDay.morning': return 'Mañana';
			case 'partOfDay.afternoon': return 'Tarde';
			case 'partOfDay.night': return 'Noche';
			case 'common.cancel': return 'Cancelar';
			case 'common.retry': return 'Reintentar';
			case 'common.tryAgain': return 'Intentar de nuevo';
			case 'common.unknownError': return 'Error desconocido';
			case 'common.errorWithMessage': return ({required Object message}) => 'Error: ${message}';
			case 'common.pointsLabel': return ({required Object points}) => '${points} puntos';
			case 'common.pointsShort': return ({required Object points}) => '${points} pts';
			case 'kidsDashboard.appBar.greetingMobile': return '¡Hola, Héroes!';
			case 'kidsDashboard.appBar.greetingTablet': return 'Hola, Héroes!';
			case 'kidsDashboard.tabs.myTasks': return 'Mis tareas';
			case 'kidsDashboard.tabs.rewards': return 'Recompensas';
			case 'kidsDashboard.navigation.tasks': return 'Tareas';
			case 'kidsDashboard.navigation.rewards': return 'Recompensas';
			case 'kidsDashboard.tasks.emptyTitle': return 'No hay tareas para hoy!';
			case 'kidsDashboard.tasks.emptySubtitle': return 'Disfruta tu día libre';
			case 'kidsDashboard.tasks.now': return 'Ahora';
			case 'kidsDashboard.rewards.title': return 'Recompensas Disponibles';
			case 'kidsDashboard.rewards.empty': return 'No hay recompensas disponibles';
			case 'kidsDashboard.rewards.retry': return 'Reintentar';
			case 'kidsDashboard.rewards.successSnack': return 'Recompensa canjeada!';
			case 'kidsDashboard.kidsPoints.title': return 'Puntos por niño';
			case 'kidsDashboard.kidsPoints.accumulated': return 'Puntos Acumulados';
			case 'kidsDashboard.kidsPoints.total': return ({required Object points}) => '${points} pts';
			case 'kidsDashboard.kidSelection.title': return 'Selecciona quién redime';
			case 'kidsDashboard.kidSelection.points': return ({required Object points}) => '${points} puntos';
			case 'kidsDashboard.kidSelection.cancel': return 'Cancelar';
			case 'kidsDashboard.rewardCard.redeem': return 'Canjear';
			case 'kidsDashboard.rewardCard.notEnoughPoints': return 'No hay puntos';
			case 'kidsDashboard.rewardCard.points': return ({required Object points}) => '${points} puntos';
			case 'kidsDashboard.dateHeader.date': return ({required Object day, required Object month}) => '${day} de ${month}';
			default: return null;
		}
	}
}

