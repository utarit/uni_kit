import 'dart:async';
import 'package:http/http.dart'
    as html; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart' as dom;
import 'package:uni_kit/features/dashboard/data/models/medico.dart';

class MedicoProvider {
  Medico medico;

  Future<Medico> getMedicoData() async {
    var url = 'https://srm.metu.edu.tr/tr/doktor-listesi';
    var response = await html.get(url);
    var document = parse(response.body);
    List<dom.Element> list = document.querySelectorAll('td');
    medico = Medico();
    int i = 0;
    do {
      Doctor doctor =
          Doctor(name: list[i].text.trim(), status: list[i + 1].text.trim());
      medico.doctors.add(doctor);
      i += 2;
    } while (i < list.length);

    return medico;
  }

  Stream<Medico> medicoStream() async* {
    Duration delay = Duration(minutes: 5);
    while (true) {
      yield* Stream<Medico>.fromFuture(getMedicoData());
      await Future.delayed(delay);
      if (DateTime.now().hour > 16 || DateTime.now().hour < 7) break;
    }
  }
}
