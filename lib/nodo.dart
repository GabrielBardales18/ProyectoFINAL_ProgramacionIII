import 'dart:math' show max;

class Nodo {
  int _dato = 0; //dato almacenado en el nodo
  Nodo? izquierda; //nodo hijo izquierdo
  Nodo? derecha; //nodo hijo derecha
  int altura = 0; //altura del nodo

  Nodo(int elemento, this.derecha, this.izquierda) {
    //Inicialización de variables
    _dato = elemento;
    derecha = null;
    izquierda = null;

  }

  //Función para calcular la altura del nodo
  int calcularAltura(){
    //Si ambos hijos son nulos, la altura es 0
    if(izquierda == null && derecha == null){
      return 0;
    } else if(izquierda == null) {
      //Si el hijo izquierdo es nulo, la altura es 1 más la altura del hijo derecho
      return 1 + derecha!.calcularAltura();
    } else if(derecha == null){
      //Si el hijo derecho es nulo, la altura es 1 más la altura del hijo izquierdo
      return 1 + izquierda!.calcularAltura();
    } else {
      // Si ambos hijos no son nulos, la altura es 1 más la máxima altura entre los dos hijos
      return 1 + max(izquierda!.calcularAltura(), derecha!.calcularAltura());
    }
  }
  
  //función para actualizar la altura del nodo
   void actualizarAltura() {
   altura = calcularAltura();
  }

   // Calcula el factor de equilibrio del nodo
  int factorEquilibrio() {
    // Altura del hijo izquierdo o -1 si es nulo
    int alturaIzquierda = (izquierda != null) ? izquierda!.altura : -1;
    // Altura del hijo derecho o -1 si es nulo
    int alturaDerecha = (derecha != null) ? derecha!.altura : -1;
    // Retorna la diferencia entre las alturas de los hijos
    return alturaIzquierda - alturaDerecha;
  }

  // metodo rotación derecha
    Nodo rotacionDerecha() {
    // El hijo izquierdo se convierte en la nueva raíz
    Nodo nuevaRaiz = izquierda!;
    // El hijo derecho de la nueva raíz se convierte en el hijo izquierdo del nodo actual
    izquierda = nuevaRaiz.derecha;
    // El nodo actual se convierte en el hijo derecho de la nueva raíz
    nuevaRaiz.derecha = this;
    actualizarAltura(); // Actualiza la altura del nodo actual
    nuevaRaiz.actualizarAltura(); // Actualiza la altura de la nueva raíz
    return nuevaRaiz; // Retorna la nueva raíz
  }

  //metodo rotación izquierda
  Nodo rotacionIzquierda() {
    Nodo nuevaRaiz = derecha!; // El hijo derecho se convierte en la nueva raíz
    derecha = nuevaRaiz.izquierda; // El hijo izquierdo de la nueva raíz se convierte en el hijo derecho del nodo actual
    nuevaRaiz.izquierda = this; // El nodo actual se convierte en el hijo izquierdo de la nueva raíz
    actualizarAltura(); // Actualiza la altura del nodo actual
    nuevaRaiz.actualizarAltura(); // Actualiza la altura de la nueva raíz
    return nuevaRaiz; // Retorna la nueva raíz
  }

    //metodo para rotación izquierda - derecha
    Nodo rotacionIzquierdaDerecha() {
    //realiza una rotación a la izquierda en el hijo izquierdo
    if (izquierda != null) {
      izquierda = izquierda!.rotacionIzquierda();
    }
    return rotacionDerecha(); //realiza una rotación a la derecha en el nodo actual
  }

    //metodo para rotación derecha - izquierda
    Nodo rotacionDerechaIzquierda() {
    //realiza una rotación a la derecha en el hijo derecho
    if (derecha != null) {
      derecha = derecha!.rotacionDerecha();
    }
    return rotacionIzquierda(); //realiza una rotación a la izquierda en el nodo actual
  }

  //Inserción de nodo en el árbol
  Nodo? insertar(Nodo? raiz, Nodo? nuevo) {
    if(nuevo == null){ 
      return raiz; // si el nodo nuevo es nulo, retorna la raíz actual
    } else if(raiz == null){
      return nuevo; // Si la raíz es nula, el nuevo nodo se convierte en la nueva raíz
    } else if (raiz.dato > nuevo.dato) {
    raiz.izquierda = insertar(raiz.izquierda, nuevo); // Inserta recursivamente en el subárbol izquierdo si el dato del nuevo nodo es menor
    } else if (raiz.dato < nuevo.dato) {
    raiz.derecha = insertar(raiz.derecha, nuevo); // Inserta recursivamente en el subárbol derecho si el dato del nuevo nodo es mayor
    }
    return raiz; // Retorna la raíz actualizada
  }
  
    // Método para establecer el dato
  void setDato(int dato) {
    _dato = dato;
  }

  // Método para obtener el dato
  int getDato() {
    return _dato;
  }
  
  int get dato{
    return _dato;
  }
}