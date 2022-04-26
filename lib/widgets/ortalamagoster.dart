import 'package:flutter/cupertino.dart';
import 'package:flutter_application_2/constants/app_cpstants.dart';

class OrtalamaGoster extends StatelessWidget {
  final double ortalama;
  final int dersSayisi;

  const OrtalamaGoster(
      {required this.dersSayisi, required this.ortalama, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            dersSayisi > 0 ? '$dersSayisi Ders Giriniz' : 'Ders Seçiniz',
            style: Sabitler.OrtalamaGosterBodyStyle,
          ),
          Text(
            ortalama >= 0 ? '${ortalama.toStringAsFixed(2)}' : '0.0',
            style: Sabitler.OrtalamaSyle,
          ),
          Text(
            'Ortalama',
            style: Sabitler.OrtalamaGosterBodyStyle,
          ),
        ]);
  }
}
