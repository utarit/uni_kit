class Medico {
  List<Doctor> doctors;
  Medico(){
    doctors = List<Doctor>();
  }

}

class Doctor {
  String name;
  String status;
  Doctor({this.name, this.status});
  @override
  String toString() {
    return "$name<$status>";
  }
}