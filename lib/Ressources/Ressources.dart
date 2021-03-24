
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String token;
bool firstOpen;

Duration durGlobal = Duration(seconds:0);
Duration durInitGlobal = Duration(seconds:0);
bool isRunningInBack = false;
int valueCpl = 25;
int nbCblG = 0;

Duration durPress = Duration(milliseconds: 500);


BuildContext cxt_contextTawrhik;
BuildContext cxt_contextTimer;
bool   notified         = false;
const String shared_firstOpen = 'game_is_OpenBefore';
const String shared_token     = 'game_token';
const String shared_role      = 'game_role';
const String shared_name      = 'game_name';
const String shared_insta     = 'game_insta';
const String shared_isBanned  = 'game_isBanned ';
const String shared_Date      = 'game_dateLoadCpl';
const String shared_nbCpl     = 'game_nbCapsules';
const String shared_target    = 'game_target';
const String shared_picture   = 'game_picture';
const String shared_hasChallenge =  'game_hasChallenge';

const String shared_task1        = 'game_task1';
const String shared_task2        = 'game_task2';
const String shared_task3        = 'game_task3';
const String shared_task4        = 'game_task4';
const String shared_task5        = 'game_task5';
const String shared_task6        = 'game_task6';
const String shared_DatePoint    = 'game_datePoint';


const String str_register      = 'إنشاء حساب جديد';
const String str_email         = 'البريد الإلكتروني';
const String str_password      = 'كلمة السر';
const String str_cPassword     = 'تأكيد كلمة السر';

const String str_dontHaveAcc   = '،إذا لم يكن لديك حساب .';
const String str_createAcc     = '. أنشئ حسابا';

const String str_login         = 'تسجيل الدخول';
const String str_exit          = 'تسجيل الخروج';
const String str_confirmAcc    = 'أكد حسابك';
const String str_confirmAccMsg = 'أدخل رمز التحقق المرسل إلى حسابك الإلكتروني لتأكيد حسابك';
const String str_confirmAccC   = 'رمز التحقق';
const String str_ByTgDev       = 'By\n TG Developers';

const String str_codeConfirm    = ' رمز التأكيد ';
const String str_resendConfirm  = 'إعادة ارسال رمز التأكيد';
const String str_haveConfirm    = 'لديك رمز التأكيد؟';
const String str_createChallenge = 'إنشاء تحدي';
const String str_goToChallenge   = 'هدف تحدي الستين';

const String err_codeConfirm     = 'رجاء انسخ كود التأكيد المرسل إلى بريدك الإلكتروني';
const String err_mailConfirm     = 'رجاء انسخ كود التأكيد المرسل إلى بريدك الإلكتروني';
const String err_cPwdNotEqualPwd = 'كلمة المرور وتأكيدها غير متوافقان';
const String err_pwdLength       = 'عدد حروف كلمة المرور يجب أن تكون أكبر من 7 حروف';
const String err_codeMissed      =  'You must verify your account';
const String err_emailTaken      =  'The social id has already been taken.';
const String err_fillData        = 'رجاء املء معلوماتك لتسجل الدخول';
const String err_errConnexion    = 'تأكد من اتصالك بالأنترنت';
const String err_errVerify       = 'يرجى إعادة المحاولة';


const int color_blue  = 0xff2F80C4;
const Color cText   = Colors.black;
const Color cField  = Colors.white;
const Color cHint   = Colors.black38;
const Color cBorder = Colors.black;
const Color cWhite  = Colors.white;
const Color cGrey   = Color(0xffEBEBEB); 
const Color cLGrey  = Color(0x59000000);

List <TextInputFormatter> formatTxtAr = [WhitelistingTextInputFormatter(RegExp("[\ ,ا-يؤ,ئ,أ,إA-Za-z]")),];
List <TextInputFormatter> formatTxt   = [WhitelistingTextInputFormatter(RegExp("[.,_,-1-9A-Za-z]")),];

const String fntAljazeera = 'aldjazeera';
const String fntAqua      = 'aqua';