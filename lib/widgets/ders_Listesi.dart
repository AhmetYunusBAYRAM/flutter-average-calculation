import 'package:flutter/material.dart';
import 'package:flutter_application_2/constants/app_cpstants.dart';
import 'package:flutter_application_2/herlper/data_helper.dart';
import 'package:flutter_application_2/model/ders.dart';

class DersListesi extends StatelessWidget {
  final Function onDismiss;
  const DersListesi({required this.onDismiss, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Ders> tumDersler = DataHelper.tumEklenenDeresler;
    return tumDersler.length > 0
        ? ListView.builder(
            itemCount: tumDersler.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                onDismissed: (a) {
                  onDismiss(index);
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    child: ListTile(
                      title: Text(tumDersler[index].ad),
                      leading: CircleAvatar(
                        backgroundColor: Sabitler.anaRenk,
                        child: Text((tumDersler[index].harfDegeri *
                                tumDersler[index].krediDegeri)
                            .toStringAsFixed(2)),
                      ),
                      subtitle: Text(
                          '${tumDersler[index].krediDegeri} Kredi , Not Değeri : ${tumDersler[index].harfDegeri}'),
                    ),
                  ),
                ),
              );
            })
        : Container(
            child: Center(
                child: Text(
              'Lütfen Ders Ekleyiniz...',
              style: Sabitler.baslikStyle,
            )),
          );
  }
}
