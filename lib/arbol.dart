import 'nodo.dart';

class Arbol {
   Nodo? raiz;

  //Función para insertar un nuevo nodo en el árbol
 void insertarNodo(int elemento, Nodo? derecha, Nodo? izquierda) {
    Nodo nuevo = Nodo(elemento, derecha, izquierda); //Crea un nuevo nodo con el elemento proporcionado
    if (raiz == null) { //si el árbol está vacío, el nuevo nodo se convertirá en la raíz
        raiz = nuevo;
    } else { //Si el árbol no esta vacío se llama la funcion para insertar y balancear el nuevo nodo en el árbol
        raiz = insertarYBalancear(raiz, nuevo);
    }
}

//Función para eliminar un nodo del árbol
void eliminarNodo(int elemento){
  raiz = _eliminarNodo(raiz, elemento); //llama a la función recursiva para eliminar el nodo
}
 //Función recursiva para eliminar un nodo del árbol
Nodo? _eliminarNodo(Nodo? raiz, int elemento){
  if(raiz == null){
    return null; //Si la raíz es nula, retorna null
  }

  //Si el elemento es menor que el dato de la raíz, elimina recursivamente en el subárbol izquierdo
  if(elemento < raiz.dato){
    raiz.izquierda = _eliminarNodo(raiz.izquierda, elemento);
    //Si el elemento es mayor que el dato de la raíz, elimina recursivamente en el subárbol derecho
  } else if(elemento > raiz.dato){
    raiz.derecha = _eliminarNodo(raiz.derecha, elemento);

  } else{
    if(raiz.izquierda == null || raiz.derecha == null){ //Si el nodo hijo no tiene hijos (null)
      //Caso 1: El nodo a eliminar tiene un hijo o ninguno
      if(raiz.izquierda != null){
        return raiz.izquierda; //retorna el hijo izquierdo si no es nulo
      } else {
        return raiz.derecha; //Retorna el hijo derecho si no es nulo
      }

    } 
    
    else if(raiz.izquierda != null || raiz.derecha != null){ //Caso 2: El nodo a eliminar tiene ambos hijos
      //Buscar el sucesor en el subarbol izquierdo
      Nodo? sucesor = raiz.izquierda;
      while(sucesor!.derecha != null){
        sucesor = sucesor.derecha;
      }

      //Copiar los datos del sucesor al nodo actual
      raiz.setDato(sucesor.getDato());
      //Eliminar el sucesor del subarbol derecho
      raiz.izquierda = _eliminarNodo(raiz.izquierda, sucesor.dato);
    } else{

      //Buscar el sucesor en el subárbol derecho
      Nodo? sucesor = raiz.derecha;
      while(sucesor!.izquierda != null){
        sucesor = sucesor.izquierda;
      }

      //Copiar los datos del sucesor al nodo actual
      raiz.setDato(sucesor.getDato());
      //Eliminar el sucesor en el subárbol derecho
      raiz.derecha = _eliminarNodo(raiz.derecha, sucesor.dato);
    }
  }

  //actualizar la altura
  raiz.actualizarAltura();
  //balanceamos de nuevo el arbol para que siga equilibrado
  return insertarYBalancear(raiz, raiz);
}

//función que resetea el árbol
void resetArbol(){
  raiz = null;
}

//función para insertar un nuevo nodo y balancear el árbol para que esté equilibrado
Nodo insertarYBalancear(Nodo? raiz, Nodo nuevo) {
    // Inserta el nuevo nodo como en un árbol binario de búsqueda estándar
    if (raiz == null) {
        return nuevo; //Si la raíz es nula, el nuevo nodo se convierte en la nueva raíz
    }

    if (nuevo.dato < raiz.dato) { //si el elemento del nodo nuevo es menor que el de la raíz se inserta en el subárbol izquierdo
        raiz.izquierda = insertarYBalancear(raiz.izquierda, nuevo);
    } else if (nuevo.dato > raiz.dato) { //si el elemento del nodo nuevo es mayor que la raíz se inserta en el subárbol derecho
        raiz.derecha = insertarYBalancear(raiz.derecha, nuevo);
    } else {
        // Si el elemento ya existe, no se hace nada
        return raiz;
    }

    // Actualiza la altura del nodo actual
    raiz.actualizarAltura();

    // Verifica y realiza el balanceo del nodo actual
    int factorEquilibrio = raiz.factorEquilibrio();
    if (factorEquilibrio > 1 ) {
        // Rotaciones para balancear el subárbol izquierdo
        if (raiz.izquierda != null && nuevo.dato < raiz.izquierda!.dato) {
            return raiz.rotacionDerecha(); //rotación derecha
        } else {
            return raiz.rotacionIzquierdaDerecha(); //rotacion izquierda-derecha
        }
    } else if (factorEquilibrio < -1) {
        // Rotaciones para balancear el subárbol derecho
        if (nuevo.dato > raiz.derecha!.dato) {
            return raiz.rotacionIzquierda(); //rotación izquierda
        } else {
            return raiz.rotacionDerechaIzquierda(); //rotación derecha-izquierda
        }
    }

    return raiz;
  }

    // Método para obtener el recorrido en preorden del árbol
  List<int> preorden() {
    List<int> resultado = [];
    _preordenRecursivo(raiz, resultado); // Llama a la función recursiva para llenar la lista con el recorrido en preorden
    return resultado;
  }

 // Función recursiva para obtener el recorrido en preorden
  void _preordenRecursivo(Nodo? nodo, List<int> resultado) {
    if (nodo != null) {
      resultado.add(nodo.dato);
      _preordenRecursivo(nodo.izquierda, resultado);
      _preordenRecursivo(nodo.derecha, resultado);
    }
  }

  // Método para obtener el recorrido en inorden del árbol
  List<int> inorden() {
    List<int> resultado = [];
    _inordenRecursivo(raiz, resultado); // Llama a la función recursiva para llenar la lista con el recorrido en inorden
    return resultado;
  }

  // Función recursiva para obtener el recorrido en inorden
  void _inordenRecursivo(Nodo? nodo, List<int> resultado) {
    if (nodo != null) {
      _inordenRecursivo(nodo.izquierda, resultado);
      resultado.add(nodo.dato);
      _inordenRecursivo(nodo.derecha, resultado);
    }
  }

  // Método para obtener el recorrido en postorden del árbol 
  List<int> postorden() {
    List<int> resultado = [];
    _postordenRecursivo(raiz, resultado); // Llama a la función recursiva para llenar la lista con el recorrido en postorden
    return resultado;
  }

  // Función recursiva para obtener el recorrido en postorden
  void _postordenRecursivo(Nodo? nodo, List<int> resultado) {
    if (nodo != null) {
      _postordenRecursivo(nodo.izquierda, resultado);
      _postordenRecursivo(nodo.derecha, resultado);
      resultado.add(nodo.dato);
    }
  }

}