import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

//widgets
import 'widgets/appbar_event.dart';
import 'widgets/first_clip_path_widget.dart';

import '../widgets/custom_navigationbar.dart';

class EventView extends StatefulWidget {
  const EventView({Key? key}) : super(key: key);

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  int currentPage = 1;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarEvent(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 800,
            ),
            const FirstClipPath(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: const Color.fromARGB(
                  149,
                  218,
                  205,
                  83,
                ), // Color de fondo amarillo con opacidad
                elevation: 4, // Elevación del card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    16,
                  ), // Bordes redondeados
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _calendarFormat = CalendarFormat.week;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (states) => _calendarFormat == CalendarFormat.week
                                  ? Colors
                                      .black // Color cuando está seleccionado
                                  : Colors
                                      .transparent, // Color cuando no está seleccionado
                            ),
                          ),
                          child: Text(
                            'Por semana',
                            style: TextStyle(
                              color: _calendarFormat == CalendarFormat.week
                                  ? Colors
                                      .white // Color del texto cuando está seleccionado
                                  : Colors
                                      .black, // Color del texto cuando no está seleccionado
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _calendarFormat = CalendarFormat.twoWeeks;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (states) => _calendarFormat ==
                                      CalendarFormat.twoWeeks
                                  ? Colors
                                      .black // Color cuando está seleccionado
                                  : Colors
                                      .transparent, // Color cuando no está seleccionado
                            ),
                          ),
                          child: Text(
                            'Por día',
                            style: TextStyle(
                              color: _calendarFormat == CalendarFormat.twoWeeks
                                  ? Colors
                                      .white // Color del texto cuando está seleccionado
                                  : Colors
                                      .black, // Color del texto cuando no está seleccionado
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _calendarFormat = CalendarFormat.month;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (states) => _calendarFormat ==
                                      CalendarFormat.month
                                  ? Colors
                                      .black // Color cuando está seleccionado
                                  : Colors
                                      .transparent, // Color cuando no está seleccionado
                            ),
                          ),
                          child: Text(
                            'Por mes',
                            style: TextStyle(
                              color: _calendarFormat == CalendarFormat.month
                                  ? Colors
                                      .white // Color del texto cuando está seleccionado
                                  : Colors
                                      .black, // Color del texto cuando no está seleccionado
                            ),
                          ),
                        ),
                      ],
                    ),
                    _buildCalendar(),
                    if (_calendarFormat == CalendarFormat.twoWeeks)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _focusedDay =
                                    _focusedDay.subtract(Duration(days: 1));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: const Text(
                              'Día anterior',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _focusedDay =
                                    _focusedDay.add(Duration(days: 1));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: const Text('Día siguiente',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            // Nuevo Card debajo del primer Card
            Positioned(
              top: 430,
              left: 20,
              child: SizedBox(
                height: 160,
                width: 360,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  elevation: 8,
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: Image.asset('assets/capilla.png',
                              fit: BoxFit.contain),
                        ),
                        const Positioned(
                            top: 25,
                            left: 20,
                            right: 20,
                            child: SizedBox(
                              height: 90,
                              child: Text(
                                'Próximo evento',
                                textAlign: TextAlign.center, // Centro el texto
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14, // Tamaño de fuente
                                ),
                              ),
                            )),
                        const Positioned(
                            top: 40,
                            left: 20,
                            right: 20,
                            child: SizedBox(
                              height: 90,
                              child: Text(
                                '23/02/2024',
                                textAlign: TextAlign.center, // Centro el texto
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight:
                                        FontWeight.bold // Tamaño de fuente
                                    ),
                              ),
                            )),
                        const Positioned(
                            top: 80,
                            left: 20,
                            right: 20,
                            child: SizedBox(
                              height: 90,
                              child: Text(
                                'Datos del evento',
                                textAlign: TextAlign.center, // Centro el texto
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16, // Tamaño de fuente
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 600,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para manejar la acción del botón
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.transparent, // Hace que el botón sea transparente
                  elevation: 0, // Quita la elevación del botón
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                ),
                child: SizedBox(
                  height: 100, // Establece el mismo tamaño que el botón
                  width: 360, // Establece el mismo tamaño que el botón
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    elevation: 8,
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      child: Stack(
                        children: [
                          Opacity(
                            opacity: 0.2, // Cambia la opacidad según lo deseado
                            child: Image.asset('assets/manos_alabanza.png',
                                fit: BoxFit.contain),
                          ),
                          const Positioned(
                            top: 30,
                            left: 20,
                            right: 20,
                            child: SizedBox(
                              height: 90,
                              child: Text(
                                'Añadir nuevo evento', // Cambia el título
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        20, // Cambia el tamaño de fuente según lo deseado
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(currentPage: currentPage),
    );
  }

  Widget _buildCalendar() {
    if (_calendarFormat == CalendarFormat.twoWeeks) {
      final selectedDate = _focusedDay;
      final dateFormat = DateFormat('EEEE, d MMMM yyyy', 'es_ES');

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              dateFormat.format(selectedDate),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    } else {
      return TableCalendar(
        locale: 'es_ES',
        calendarFormat: _calendarFormat,
        focusedDay: _focusedDay,
        firstDay: DateTime.utc(2022, 1, 1),
        lastDay: DateTime.utc(2040, 12, 31),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          outsideTextStyle: TextStyle(
            color: Color.fromARGB(255, 103, 61, 243),
          ),
          weekendTextStyle: TextStyle(
            color: Colors.black,
          ),
          // Estilo específico para cuando está en formato de semana
          weekendDecoration: BoxDecoration(
            color: _calendarFormat == CalendarFormat.week
                ? Colors.blue.withOpacity(
                    0.5) // Color de fondo para la semana seleccionada
                : Colors.transparent, // Mantener transparente en otros casos
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          weekendStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
      );
    }
  }
}
