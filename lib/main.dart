import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'arbol.dart';
import 'pintar_arbol.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arbol AVL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Arbol AVL',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Arbol objArbol = Arbol(); //instancia de la clase arbol (representa el arbol AVL)
  final _textFieldController = TextEditingController(); //controlador para el campo de texto
  late ArbolPainter _painter; //painter para el arbol

  //getters para los elementos del arbol
  int get elemento => 0;
  get derecha => null;
  get izquierda => null;
  //texto que muestra el orden del arbol
  String? orden = "No hay elementos en el árbol.";
  bool mostrarLista = false; //bool para mostrar o no la lista

  @override
  void initState() {
    super.initState();
    _painter = ArbolPainter(objArbol); //Inicializa el pintor del árbol en la instancia del arbol
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 75, 75, 75), //color de fondo de la aplicación
      body: SingleChildScrollView( //permite desplazar la pantalla si el contenido es muy largo
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 60,
                width: 60,
              ),
              const Center(child: Text("Arbol AVL", 
              style: TextStyle(
                 color: Colors.white,
                  fontSize: 20
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
                width: 10,
              ),
              CustomPaint( 
                painter: _painter, //painter para dibujar el árbol
                size: Size(MediaQuery.of(context).size.width, 250), //tamaño del área de dibujo
              ),
              if(mostrarLista) //si mostrar lista es verdadero, muestra el texto del "orden"
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  orden!,
                  style: const TextStyle(
                    color: Colors.white,
                     fontSize: 16,
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                    controller: _textFieldController,
                    keyboardType: TextInputType.number, //campo de texto para ingresar números  
                    decoration: const InputDecoration(hintText: "Ingresa un numero",
                    hintStyle: TextStyle(
                      color: Colors.white
                      )
                    ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row( //fila para contener los botones
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(5),
                          color: const Color.fromARGB(255, 50, 184, 93),
                          onPressed: () {
                            setState(() {
                            // Convierte el texto del campo de entrada a un entero
                              try {
                                  int elemento = int.parse(_textFieldController.text);
                                  objArbol.insertarNodo(elemento, null, null); //inserta el nodo en el árbol
                                  // Limpiar el campo de entrada
                                  _textFieldController.text = "";
                              } catch (e) {
                                  print("Error al convertir el valor de entrada: $e");
                                  // Maneja el error
                              }
                            });
                          },
                          child: const Text(
                            'Insertar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                     Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(5),
                          color: const Color(0xffff6464),
                          onPressed: () {
                            setState(() {
                                    // Convierte el texto del campo de entrada a un entero
                              try {
                                int elemento = int.parse(_textFieldController.text);
                                objArbol.eliminarNodo(elemento); //elimina el nodo del árbol
                                // Limpiar el campo de entrada
                                _textFieldController.text = "";
                              } catch (e) {
                                print("Error al eliminar el nodo: $e");
                                // Maneja el error
                              }
                            });
                          },
                          child: const Text(
                            'Eliminar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, //fila para los botones de orden del árbol
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(5),
                          color: Colors.lightBlue,
                          onPressed: (){
                            setState(() {
                              orden = objArbol.preorden().toString(); //Muestra el recorrido preorden del árbol
                              mostrarLista = true;
                            });
                          },
                          child: const Text('Pre-orden', 
                          style: TextStyle(
                            fontSize: 14, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(5),
                          color: Colors.amber,
                          onPressed: (){
                            setState(() {
                              orden = objArbol.inorden().toString(); //Muestra el recorrido inorden del árbol
                              mostrarLista = true;
                            });
                          },
                          child: const Text('In-Orden', 
                          style: TextStyle(
                            fontSize: 14,
                             fontWeight: FontWeight.bold, 
                             color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(5),
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              orden = objArbol.postorden().toString(); //Muestra el recorrido postorden del árbol
                              mostrarLista = true;
                            });
                          },
                          child: const Text('Post-orden',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton(
                  padding: const EdgeInsets.all(5),
                  color: Colors.black,
                  onPressed: () {
                    setState(() {
                      objArbol.resetArbol(); //resetea el árbol
                      mostrarLista = false; //oculta la lista de orden
                    });
                  },
                  child: const Text(
                    "    RESET Arbol    ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








