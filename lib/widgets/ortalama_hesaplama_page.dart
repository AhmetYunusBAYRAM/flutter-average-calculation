import 'package:flutter/material.dart';
import 'package:flutter_application_2/constants/app_cpstants.dart';
import 'package:flutter_application_2/herlper/data_helper.dart';
import 'package:flutter_application_2/model/ders.dart';
import 'package:flutter_application_2/widgets/ders_Listesi.dart';
import 'package:flutter_application_2/widgets/ortalamagoster.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({Key? key}) : super(key: key);

  @override
  _OrtalamaHesaplaPageState createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  var fromkey = GlobalKey<FormState>();
  double secilenHarfDegeri = 4;
  double secilenKrediDegeri = 1;
  String girilenDersAdi = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
            child: Text(
          Sabitler.baslikText,
          style: Sabitler.baslikStyle,
        )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildForm(),
              ),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(
                  dersSayisi: DataHelper.tumEklenenDeresler.length,
                  ortalama: DataHelper.ortalamaHesaplama(),
                ),
              )
            ],
          ),

          Expanded(
            child: DersListesi(
              onDismiss: (index) {
                DataHelper.tumEklenenDeresler.removeAt(index);
                setState(() {});
              },
            ),
          )
          //listen
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: fromkey,
      child: Column(
        children: [
          Padding(padding: Sabitler.yatayPadding8, child: _buildtextForm()),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                    padding: Sabitler.yatayPadding8, child: _buildHarfler()),
              ),
              Expanded(
                child: Padding(
                    padding: Sabitler.yatayPadding8, child: _buildKrediler()),
              ),
              IconButton(
                onPressed: _dersEkleVeOrtalamaHesapla,
                icon: Icon(Icons.arrow_forward_ios_sharp),
                color: Sabitler.anaRenk,
                iconSize: 30,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  _buildtextForm() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s) {
        if (s!.length <= 0) {
          return 'Ders adını giriniz.';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
          hintText: 'Ders Giriniz',
          border: OutlineInputBorder(
              borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
          filled: true,
          fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3)),
    );
  }

  Widget _buildHarfler() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.shade100.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: Sabitler.DropDownPadding,
      child: DropdownButton<double>(
        iconEnabledColor: Sabitler.anaRenk.shade200,
        elevation: 16,
        items: DataHelper.tumDerslerinHarfleri(),
        underline: Container(),
        onChanged: (dd) {
          setState(() {
            secilenHarfDegeri = dd!;
            print(dd);
          });
        },
        value: secilenHarfDegeri,
      ),
    );
  }

  Widget _buildKrediler() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.shade100.withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: Sabitler.DropDownPadding,
      child: DropdownButton<double>(
        iconEnabledColor: Sabitler.anaRenk.shade200,
        elevation: 16,
        items: DataHelper.tumDerslerinKredileri(),
        underline: Container(),
        onChanged: (dd) {
          setState(() {
            secilenKrediDegeri = dd!;
            print(dd);
          });
        },
        value: secilenKrediDegeri,
      ),
    );
  }

  void _dersEkleVeOrtalamaHesapla() {
    if (fromkey.currentState!.validate()) {
      fromkey.currentState!.save();
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDegeri,
          krediDegeri: secilenKrediDegeri);
      DataHelper.DersEkle(eklenecekDers);
      print(DataHelper.ortalamaHesaplama());
      setState(() {});
    }
  }
}
