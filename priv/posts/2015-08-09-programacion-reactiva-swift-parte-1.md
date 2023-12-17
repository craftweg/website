---
title: 'Programación Reactiva en Swift: Parte 1, Introducción'
tags: [reactive, objective-c, swift, reactive cocoa]
---

Con la llegada de Swift y la introducción de interesantes operadores, conceptos funcionales, y la seguridad de tipos el paradigma de programación reactiva ha cobrado especial importancia en el desarrollo de apps. En comparación con la programación imperativa a la que la mayoría de desarrolladores estamos acostumbrados _(yo incluido)_ programar de forma reactiva consiste en modelar los sucesos que tienen lugar en el sistema como un conjunto de _eventos_ que son enviados a través de un “stream” de datos. El concepto es bastante sencillo, y aunque no todos los sucesos tienen carácter de _stream_, pueden acabar siendo modelados como tal. Desde acciones que realiza el usuario sobre la UI, hasta la información que proviene del framework de localización.

Todas las librerías que encontramos hoy en día si echamos un vistazo en Github tratan de modelar todos los conceptos reactivos a través de una serie componentes y operadores para manipular y procesar los eventos. La diferencia entre ellas es principalmente la sintaxis y el nombre que usan para los componentes. Algunas de ellas incluso añaden operaciones como por ejemplo de _retry_. Encontramos librerías como [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) que recientemente ha actualizado toda su API para adaptarse a las ventajas que Swift aporta como lenguaje, o [RXSwift](https://github.com/ReactiveX/RxSwift) cuya base es ReactiveX disponible para otros lenguajes como Java o Javascript.

> Si tienes curiosidad en el repositorio de [RXSwift](https://github.com/ReactiveX/RxSwift) encontrarás una tabla donde comparan RXSwift con el resto de alternativas para Swift.

![Reactive stream](/images/posts/reactive_sream.png)

## Patrones de observación

Cuando empecé a introducir los conceptos reactivos una de mis primeras inquietudes fue entender qué patrones similares había estado usando hasta ahora, que problemas presentaban, y de qué forma la programación reactiva ayudaba o facilitaba estos patrones. La mayoría de ellos los usas a diario:

### KVO

Extensivamente usado en Cocoa. Permite observar el estado de las properties de un objeto determinado y reaccionar antes sus cambios. El mayor problema de KVO es que no es fácil de usar, su API está demasiado recargada y todavía no dispone de una interfaz basada en bloques (o closures en Swift)

```language-swift
objectToObserve.addObserver(self, forKeyPath: "myDate", options: .New, context: &myContext)
```

### Delegados

Uno de los primeros patrones que aprendes cuando das tus primeros pasos en el desarrollo para iOS/OSX ya que la mayoría de componentes de los frameworks de Apple lo implementan. _UITableViewDelegate, UITableViewDataSource_, … son algunos ejemplos. El principal problema que presenta este patrón es que sólo puede haber un delegado registrado. Si estamos ante un escenario más complejo donde con una entidad suscrita no es suficiente el patrón requiere de algunas modificaciones para que pueda soportar múltiples delegados.

```language-swift
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
}
```

### Notificaciones

Cuando es complejo aproximarnos al componente fuente del evento para _subscribirnos_ se usa el patrón que consiste en el envío de notificaciones. ¿Conóces NSNotificationCenter? CoreData lo utiliza por ejemplo para notificar cuando un contexto va a ejecutar una operación de guardado. El problema que tiene este patrón es que toda la información enviada se retorna en un diccionario, _UserInfo_, y el observador tiene que conocer previamente la estructura de este diccionario para poder interpretarlo. No hay por lo tanto seguridad ni en la estructura ni en los tipos enviados.

```language-swift
NSNotificationCenter.defaultCenter().addObserver(self, selector: "contextWillSave:", name: NSManagedObjectContextWillSaveNotification, object: self)
```

> Las librerías reactivas disponibles actualmente ofrecen extensiones para pasar de esos patrones al formato reactivo. Desde generar señales para notificaciones enviadas al NSNotificationCenter, como para detectar los taps de un UIButton.

## Ventajas de programar de forma Reactiva

La programación reactiva tiene grandes ventajas usada en esos ámbitos donde es bastante directo aplicar el sentido de stream. Como bien comentaba al comienzo, todo puede ser modelado como un stream, y podrías de hecho tener un proyecto completamente reactivo pero bajo mi punto de vista, acabarías teniendo una compleja lógica de generación de streams que acabará dificultando la lectura del código.

> Con la programación Reactiva sucede algo similar a la programación Funcional. Se trata de un paradigma de programación que ha tenido un gran impulso en el desarrollo de iOS/OSX con la llegada de Swift pero no es necesario agobiarse y sentir una presión inmensa por migrar proyectos hacia esos paradigmas. Usa estos en tus proyectos a medida que te vayas sintiendo cómodo y notes que tu proyecto te los pide en determinadas partes. ¡Eras feliz sin ellos!, ahora puedes serlo incluso más, pero con tranquilidad…

Después de unos meses usando [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) en mis proyectos, especialmente en la parte relativa a la fuente de datos (local & remota) he percibido una serie de ventajas:

- **Seguridad de tipos**: Gracias al uso de genéricos podemos tener validación de tipos a nivel de compilador y evitar tener que estar trabajando con tipos genéricos como _AnyObject_ o _NSObjects_.
- **Facilita la manipulación de datos**: Los eventos recibidos a través de los streams pueden ser mapeados, filtrados, reducidos. Gracias al uso de funciones definidas podemos aplicar infinidad de operaciones sobre los eventos.
- **Subscripción en threads**: Independientemente de la gestión interna de threads que pueda llevar a cabo la ejecución de un stream _(por ejemplo, una petición web)_, podemos indicar en qué thread subscribirnos para escuchar las respuestas. La forma de indicar el thread de subscripción se traduce en una simple linea de código.
- **Fácil composición y reusabilidad:** Los streams pueden ser combinados de infinitas formas (gracias a los operadores que los propios frameworks facilitan). Además podemos generar los nuestros propios de forma que podamos obtener streams de eventos a partir de una combinación de otros muchos.
- **Bindeado de datos:** Podemos conectar todos los eventos que llegan a través de un stream por ejemplo con una colección de forma que nuevas colecciones que lleguen en formato de eventos actualizarán la colección _“bindeada”_. De la misma forma por podemos actualizar una property de un elemento de UI con eventos recibidos.
- **Gestión de errores:** Por defecto los frameworks reactivos dan la opción de reintentar la operación fuente del stream en el caso de fallo. Por ejemplo, si un stream recibe la respuesta de una petición web y queremos que está se reintente en el caso de fallo podemos usar el operador y la petición se volverá a ejecutar:

```language-swift
NSURLSession.sharedSession().rac_dataWithRequest(URLRequest)
            |> retry(2)
            |> catch { error in
                println("Network error occurred: \(error)")
                return SignalProducer.empty
            }
```

- **Simplificación de estados:** Debido al hecho de que la información se modela en un stream _unidireccional_. El número de estados que puedan introducirse se reduce simplificando la lógica de nuestro código.

##Reactive Cocoa
Aunque para Swift podamos encontrar varios frameworks que tratan de modelar todo el paradigma reactivo a través de una serie de componentes y operadores, los siguientes posts estarán basados en [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa). La principal diferencia de ReactiveCocoa con el resto es que este no se trata de un port de la librería original de [Microsoft (Rx)](https://msdn.microsoft.com/en-us/data/gg577609.aspx) sino que implementa su propia API, más sencilla y cercana a las convenciones Cocoa.

Este es el primero de una serie de posts de introducción a la Programación Reactiva donde además detallaremos el uso de la misma en el modelado de las fuentes de datos (API, y local). Todos serán recopilados en este libro [https://leanpub.com/programacionreactivaenswift](https://leanpub.com/programacionreactivaenswift) que actualmente estoy escribiendo y qué publicaré en unos meses.

**En el siguiente post realizaré una introducción a los componentes de Reactive Cocoa.**

### Recomendación

En el siguiente [enlace](https://gist.github.com/staltz/868e7e9bc2a7b8c1f754) encontrarás una interesante explicación de la programación Reactiva con ejemplos en Javascript.
