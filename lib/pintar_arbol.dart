import 'package:flutter/material.dart';
import 'nodo.dart';
import 'arbol.dart';

class ArbolPainter extends CustomPainter {
  //Objeto de la clase Arbol que se va a pintar
  Arbol objArbol = Arbol();
  //Constantes para el tamaño del nodo
  static const double diametro = 15;
  static const double radio = diametro / 4;
  static const int ancho = 30;

  //Constructor que inicializa el objeto ArbolPainter con un objeto de la clase Arbol
  ArbolPainter(Arbol obj) {
    objArbol = obj;
  }
  //Metodo paint que se llama cada vez que se necesita repintar el lienzo
  @override
  void paint(Canvas canvas, Size size) {
    //Llama al método pintar para dibujar el árbol, comenzando desde la raíz
       pintar(canvas, size.width / 2, 15, objArbol.raiz);
  }

  //Método que indica si el lienzo debe repintarse
  @override
  bool shouldRepaint(ArbolPainter oldDelegate) => true;

  //Método recursivo para pintar cada nodo del árbol
  void pintar(Canvas canvas, double x, double y, Nodo? n) {
    if(n == null){
      return; //Si el nodo es nulo, retorna sin hacer nada
    }

    //Define la pintura y estilo para el borde del circulo del nodo
    Paint brushCirculoBorde = Paint()
      ..color = const Color.fromARGB(255, 10, 10, 10)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

      //Define la pintura para el relleno del círculo del nodo
      Paint brushCirculo = Paint()
      ..color = const Color.fromARGB(255, 1, 246, 58)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;
      
      //Define la pintura para las líneas que conectan los nodos
      Paint brushLinea = Paint()
      ..color = const Color.fromARGB(255, 5, 5, 5)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

      //Estilo de texto para el número dentro del nodo
      const textStyle = TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 12,
      fontWeight: FontWeight.bold,
      );

      //Crea un textSpan con el dato del nodo
      final textSpan = TextSpan(
      text: n.dato.toString(),
      style: textStyle,
      );

      //Configura el TextPainter para dibujar el texto
      final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      );
     textPainter.layout(
      minWidth: x,
      maxWidth: x,
     );

      //Calcula la posición del texto dentro del nodo
      final offsetText = Offset(x - 6, y - 6);
      double extra = n.altura * (ancho / 2);

    // Dibuja líneas hacia los nodos hijos si existen
    if (n.izquierda != null) {
        canvas.drawLine(Offset(x + radio, y - radio),
            Offset(x - ancho - extra + radio, y + ancho + radio * 0.2), brushLinea);
    }
    if (n.derecha != null) {
        canvas.drawLine(Offset(x + radio, y + radio * 0.2),
            Offset(x + ancho + extra + radio, y + ancho + radio), brushLinea);
    }
    
    //Dibuja el circulo del nodo y su borde
    canvas.drawCircle(Offset(x, y), diametro, brushCirculo);
    canvas.drawCircle(Offset(x, y), diametro, brushCirculoBorde);
    textPainter.paint(canvas, offsetText);

    // Llama recursivamente a pintar con los nodos hijos opcionales
    pintar(canvas, x - ancho - extra, y + ancho, n.izquierda);
    pintar(canvas, x + ancho + extra, y + ancho, n.derecha);

    }
}