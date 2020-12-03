<?php

    include_once("ui/unit.php");
    include_once("ui/a2b.php");
    include_once("ui/activate.php");
    include_once("ui/ajax.php");
    include_once("ui/alliance.php");
    include_once("ui/artefacts.php");
    include_once("ui/build.php");
    include_once("ui/contact.php");
    include_once("ui/dorf.php");
    include_once("ui/hero.php");
    include_once("ui/hero_adv.php");
    include_once("ui/hero_auc.php");
    include_once("ui/hero_inv.php");
    include_once("ui/karte.php");
    include_once("ui/login.php");
    include_once("ui/logout.php");
    include_once("ui/market.php");
    include_once("ui/message.php");
    include_once("ui/plus.php");
    include_once("ui/profile.php");
    include_once("ui/register.php");
    include_once("ui/report.php");
    include_once("ui/user.php");
    include_once("ui/village.php");
    include_once("ui/warsim.php");




    define("DIRECTION", "ltr");
    define("TRAVIAN", "تراوین");


    //Html
    define("HTM_REFRESH", "تازه سازی");
    define("HTM_MADECHANGEALERT", "تغییراتی ایجاد شده است ! آیا میخواهید این صفحه را ببندید ؟");

    //Header
    define("HDR_RES", "منابع");
    define("HDR_VILCENTER", "مرکز دهکده");
    define("HDR_MAP", "نقشه");
    define("HDR_STATIS", "آمار");
    define("HDR_REPORTS", "گزارش ها||تعداد گزارش ها :");
    define("HDR_MESSAGES", "پیام ها||تعداد پیام ها : ");
    define("HDR_PROFILE", "پروفایل||تغییر پروفایل");
    define("HDR_OPTION", "تنظیمات||تنظیمات اکانت");
    define("HDR_FORUM", "قروم||مشاهده فروم بازی");
    define("HDR_CHAT", "چت||بزودی ...");
    define("HDR_HELP", "راهنما||دستور ها و راهنمایی ها");
    define("HDR_LOGOUT", "خروج||خروج از بازی");
    define("HDR_GOLD", "طلا");
    define("HDR_BUYGOLD", "خرید طلای تراوین");
    define("HDR_SILVER", "نقره");
    define("HDR_PROFILE2", "پروفایل");
    define("HDR_OPTION2", "تنظیمات");
    define("HDR_FORUM2", "قروم");
    define("HDR_HELP2", "راهنما");
    define("HDR_LOGOUT2", "خروج");
    define("HDR_CLICKMOREINFO", "برای اطلاعات بیشتر کلیک کنید");
    define("HDR_WAREHOUSE", "انبار غذا");
    define("HDR_GRANARY", "انبار گندم");
    define("HDR_WOOD_PROD", "چوب||تولیدات : ");
    define("HDR_CLAY_PROD", "خشت||تولیدات : ");
    define("HDR_IRON_PROD", "آهن||تولیدات : ");
    define("HDR_CROP_PROD", "گندم||تولیدات : ");
    define("HDR_CROP_PROD2", "محصول رایگان برای ساختمان های بیشتر است.||تعادل گندم: ");

    //HERO SIDE
    define("HS_ADVENTURE", " ماجراجویی");
    define("HS_INHOME", " قهرمان در دهکده است");
    define("HS_HERODEAD", " قهرمان زنده نیست");
    define("HS_MOVING", " در حرکت");
    define("HS_RETURN", " درحال بازگشت");
    define("HS_NOTINVIL", " قهرمان شما در دهکده نیست");
    define("HS_HEROOVER", "مشاهده قهرمان||");
    define("HS_HEROPOINT", "امتیازات قهرمان||کلیک کنید !");
    define("HS_HEROHEALTH", "سلامتی : ");
    define("HS_HEROEXP", "تجربه : ");
    define("HS_DMINFO", "نمایش اطلاعات بیشتر");
    define("HS_HINFO", "مخفی کردن");

    //Alliance
    define("AL_AUCTION", "حراجی||در حال بارگزاری ...");
    define("AL_CONSTEMBASY", "اتحاد بساز.");
    define("AL_ALLYFORUM", "فروم اتحاد||");
    define("AL_ALLYOVER", "بررسی اتحاد||");
    define("AL_NOALLY", "در اتحاد نیستید");
    define("AL_ALLIANCE", "اتحاد");
    define("AL_TOALLYFORUM", "فروم اتحاد");

    //infomsg
    define("IM_PLUSDEACTIVE", "اتمام اکانت پلاس در");
    define("IM_WOODDEACTIVE", "پایان تولید بیشتر برای گندم در");
    define("IM_CLAYDEACTIVE", "پایان تولید بیشتر برای خشت در");
    define("IM_IRONDEACTIVE", "پایان تولید بیشتر برای آهن در");
    define("IM_CROPDEACTIVE", "پایان تولید بیشتر برای گندم در");
    define("IM_EXTEND", "گسترش");

    define("IM_STILL", "شما هنوز تا");
    define("IM_BEGINERPROT", "تحت حمایت هستید");
    define("IM_TOTMSG", "مجموع پیام ها :");

    //link list
    define("LL_LINKLIST", "لیست لینک||تراوین پلاس امکان درج لینک هارا به شما می دهد");
    define("LL_LINKLIST2", "لیست لینک ها");
    define("LL_TPLUS", "تراوین پلاس امکان درج لینک ها را شما می دهد");
    define("LL_DELETEIN", "حذف در");

    //movement
    define("MV_TROOPMOVEMENT", "حرکت لشکریان :");
    define("MV_ARIREINTROOP", "رسید نیرو های پشتیبان");
    define("MV_ARIATTTROOP", "رسیدن نیرو های مهاجم");
    define("MV_ATTACK", "حمله");
    define("MV_HOUR", "ساعت");
    define("MV_OWNREINTROOP", "نیروهای پشتبانی خودی");
    define("MV_REINF_SHORT", "پشتیبانی");
    define("MV_OWNATTTROOP", "نیروهای حمله خودی");
    define("MV_NEWVILLAGE", "دهکده جدید");
    define("MV_ADVENTURE", "ماجراجویی");

    //production
    define("PD_PRODPERHR", "تولیدات در ساعت :");
    define("PD_LUMBER", "چوب");
    define("PD_CLAY", "خشت");
    define("PD_IRON", "آهن");
    define("PD_CROP", "گندم");
    define("PD_WOODBONUS", "افزایش تولید چوب");
    define("PD_CLAYBONUS", "افزایش تولید خشت");
    define("PD_IRONBONUS", "افزایش تولید آهن");
    define("PD_CROPBONUS", "افزایش تولید گندم");
    define("PD_MINFO", "اطلاعات بیشتر در مورد افزایش تولیدات");

    //troops
    define("TR_TROOPS", "لشکریان :");
    define("TR_NOTROOPS", "هیچ");

    //sideinfo
    define("SI_DIRECTLINK", "لینک ها||این امکان نیاز به تراوین پلاس دارد");
    define("SI_BUILDWORKSHOP", "کارگاه بنا کن.");
    define("SI_BUILDSTABLEP", "اصطبل بنا کن.");
    define("SI_BUILDBARRACKS", "سربازخان بنا کن.");
    define("SI_BUILDMARKET", "بازار بنا کن.");
    define("SI_LOYALTY", "وفاداری");
    define("SI_CHANGEVILNAME", "تغییر نام دهکده");
    define("SI_NEWVILNAME", "نام جدید :");
    define("SI_SAVE", "ذخیره");

    //multivillage
    define("MV_PLUS", "تراوین پلاس||امکانات ویژه پلاس");
    define("MV_PLUS2", "پلاس");

    define("MV_BANK", "بانک طلا||ذخیره سازی طلای تراوین");
    define("MV_BANK2", "بانک طلا");
    define("MV_VILL", "دهکده ها  :");
    define("MV_CULTURE", "امتیاز فرهنگی جهت احداث دهکده بعدی :");
    define("MV_VILL2", "دهکده ها");

    define("MV_SHOWCORD", "نمایش مختصات");
    define("MV_HIDECORD", "مخفی کردن مختصات");

    //quest
    define("QS_DISPTASK", "نمایش لیست وظایف");
    define("QS_DISPINTERF", "نمایش راهنما");

    define("QS_TASKHELP", "وظایف");
    define("QS_DISWELCOME", "خوش آمدید");
    define("QS_STARTTUT", "شروع وظایف");
    define("QS_ACCINFO", "اطلاعات اکانت");

    //footer
    define("FT_SERVERTIME", "زمان سرور");
    define("FT_HOMEPAGE", "صفحه اصلی");
    define("FT_FORUM", "فروم");
    define("FT_LINKS", "لینک ها");
    define("FT_FAQANS", "پرسش و پاسخ");
    define("FT_TERMS", "شرایط");
    define("FT_RULES", "قوانین");
    define("FT_COPYRIGHT", "&copy; 2004 - 2015 Travian Game -Travian System by O&#951;&#8467;&#1091; &#969;&#953;&#8467;D<b></b>");

define('MAXSELL','5');
define('MAXSELLDESC','You can have %s sell at the same time!');
    define("CUR_PROD", "تولید کنونی ");
    define("NEXT_PROD", "تولید در سطح بعد");
    define("CUR_INC_PROD", "افزایش در تولیدات");
    define("NEXT_INC_PROD", "افزایش در سطح ");
    define("CUR_CAP", "ظرفیت کنونی");
    define("NEXT_CAP", "ظرفیت در سطح بعد ");
    define("CUR_SPEEDUP", "افزایش سرعت کنونی (درصد)");
    define("NEXT_SPEEDUP", "افزایش سرعت در سطح");
    define("CUR_CTIME", "زمان ساخت و ساز کنونی");
    define("NEXT_CTIME", "زمان ساخت و ساز در سطح بعد");