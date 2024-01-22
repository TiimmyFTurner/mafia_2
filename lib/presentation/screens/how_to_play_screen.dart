import 'package:flutter/material.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("روش بازی")),
      body: const Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              '''
بازی مافيا بر ميگردد به بهار سال ۱۹۸۶ که توسط يک دانشجوی روانشناسی  دانشگاه مرکزی مسکو به نام ديميتری ديويدف خلق و اجرا شد که از آن برای سرگرمی در خوابگاهای دانشکده بين دانشجويان استفاده ميشد ،

با استقبالی که از اين بازی شد به سرعت اين بازی در کلاس های درس ، راهروها و اردوهای دانشکده و سپس بين ساير موسسات آموزشی و دانشکده های ديگر گسترش يافت.

ديميتری ديويدف بعد از فارغ التحصيلی در رشته روانشناسی ، در همان دانشکده روانشناسی دانشگاه مرکزی مسکو مشغول تدريس شد و اين فرصت مناسبی بود که به بسط و توسعه اين بازی بپردازد و در اين فرصت اين بازی برای دانشجويان بورسيه شده در مسکو نيز آموزش داده شد و اين آغازی بود برای جهانی شدن اين بازی.

مافیا یک بازی گروهی است که نبرد بین یک اقلیت آگاه و یک اکثریت ناآگاه را شبیه‌سازی می‌کند. بازیکنان به‌طور مخفیانه تعیین نقش می‌شوند: مافیا که همدیگر را می‌شناسند یا شهروند که تنها از تعداد افراد مافیا آگاه هستند و عده معدودی از آن‌ها از برخی نقش‌ها اطلاع دارند. در فاز شب بازی، افراد مافیا به صورت مخفیانه یک شهروند را به قتل می‌رسانند. در طول فاز روز، تمام بازیکنان بازمانده در مورد هویت‌های مافیایی بحث می‌کنند و برای حذف یک مظنون رای‌گیری می‌کنند.

بازی ادامه می‌یابد تا زمانی که همهٔ مافیاها حذف شوند (برد شهروندان) یا تعد مافیاها و شهروندان برابر شود (برد مافیا) یا یکی از شخصیت‌های مستقل که هر کدام شرایط برد متفاوتی دارد، برنده بازی شود. در یک بازی معمولاً نقش‌ها باید به گونه‌ای چیده شود که برای هر شخصیت، شخصیت‌های مقابل و مکمل قرار گیرد.
''',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
