import 'package:flutter/material.dart';

class BetaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "v.1.0.9\n",
          style: TextStyle(color: Colors.white),
        ),
        Text(
"""
  NOTIFICATIONS ARE NOT READY! I WITHDRAW THE FEATURE

  Uygulamayı biraz spagetti yazmıştım aklımda birkaç güzel fikir var, onları yapmadan kodu bir toplamak istedim.
  Sevgili beta testerlarıma bir de sorum olarak. Büyük ihtimal bu uygulamayı bu isimle yayınlayamayacağım Metu ve Budddy ayrı ayrı telif yeme ihtimali var.
O yüzden yakın zamanda bir isim anketi açmayı düşünüyorum. İsim fikirleriniz varsa anket öncesi bana ulaşabilirsiniz.
""",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
