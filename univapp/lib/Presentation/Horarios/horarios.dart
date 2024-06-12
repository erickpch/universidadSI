import 'package:flutter/material.dart';
import 'package:univapp/Presentation/Layouts/header.dart';
import 'package:univapp/assets/widgets/styles.dart';

class Horario extends StatelessWidget {
  const Horario({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
        backgroundColor:Color.fromARGB(255, 16, 113, 240),
        appBar: headerAppBar(context),
        drawer: SideNav(),
        floatingActionButton:  FloatingActionButton(
            onPressed: () {
             // Navigator.pushNamed(context,roleCreateRoute());
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.black
        ),
        body: SafeArea(
          child: SizedBox.expand(
            child: Stack(
              children: <Widget>[
                //appBackground(),
                SingleChildScrollView(
                  child: todo(context),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

    Widget todo(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.center,
              color: Color.fromARGB(255, 0, 43, 124), 
              child: 
                        const Text(
                          "Horarios",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
            ),),
          
            SizedBox(height: 10),
            Container(
              height: 2,
              color: Colors.black, // Línea oscura
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
            listOfHorario(), // Supongo que listOfHorario es una función que devuelve la tabla
          ],
        ),
      ),
    );
  }

 Widget listOfHorario() {
    // Aquí deberías retornar la tabla
    return tablaHorarios();
  }

  Widget tablaHorarios() {
    // Aquí defines la tabla con los datos necesarios
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: DataTable(
        columns: [
          DataColumn(label: Text('Columna 1')),
          DataColumn(label: Text('Columna 2')),
          DataColumn(label: Text('Columna 3')),
          // Agrega más columnas según tu necesidad
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('Dato 1')),
            DataCell(Text('Dato 2')),
            DataCell(Text('Dato 3')),
            // Agrega más celdas según tu necesidad
          ]),
          // Agrega más filas según tu necesidad
        ],
      ),
    );
  }

