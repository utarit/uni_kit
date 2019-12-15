import 'package:flutter/material.dart';

class BetaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "v.1.0.6\n",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "Deadline için sıralama algoritması değiştiği için daha önceki sürümde eklenmiş deadlineların silinmesinde sıkıntı çıkabilir. Uygulamanın datasını silin ya da uygulamayı silip baştan yükleyin.\n",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "Kurslara renk özelliği geldi. Yine daha önce eklenmiş kurslarda sıkıntı çıkarsa screenshotlarla bana ulaşın, uygulamanın datasını silip tekrar deneyin. Data sıfırlanınca sorun çıkmaması lazım.\n",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "Şimdi düşününce betadan çıkana kadar bol bol datayı sıfırlayabilirsiniz hazırlıklı olun :d",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
