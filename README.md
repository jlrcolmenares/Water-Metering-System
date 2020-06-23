# Grafana Water Metering System

The idea of the following is to give you all the instructions and files to build a dashboard with Grafana. This environment is build using docker-compose app with three containers: Node-Red as a data generator. PostgreSQL as Databases and Grafana for Data visualization in real time. 

I'm writing this repo both in spanish and english. 

Some prerequisites or useful knowledge:

* Fundamentals a Javascript (Declaring variables and functions)
* Fundamentals of SQL (How to create table and write queries)
* Basic knowledge of Docker and Docker Compose



------

![](https://joseluisramoncolmenares.files.wordpress.com/2020/06/bannergrafanadashboard1.png)



## README [Español]

### A-Inicio Rápido

Si lo que quieres es tener un ambiente idéntico al que muestro en la imagen superior lo que debes hacer es,

#### A1-Docker

**Instalar Docker en tu PC**:

Si no tienes Docker instalado puedes seguir los tutoriales de instalación que indico [aquí](https://joseluisramoncolmenares.wordpress.com/2020/06/18/como-configurar-docker-para-tus-proyectos/)

#### A2-Docker-compose

**Crear el entorno de multi-contenedores con docker-compose**

El siguiente paso es abrir tu línea de comandos y mover el directorio de trabajo al directorio `src/compose_grafa` dentro estará únicamente el archivo **[docker-compose.yaml](https://docs.docker.com/compose/)**. Una vez dentro de la carpeta ejecutar el comando `docker-compose up` para iniciar el entorno de multi-contenedores.

En el Dashboard de contenedores se debería ver multicontenedor de nombre compose_grafana (como la carpeta que lo contiene) y que tiene 3 subcontenedores

* compose_grafana_node-red_1
* compose_grafana_db_1
* compose_grafaba_grafana_1

#### A3-PostgreSQL

**Crear base de datos 'logs' en la instancia de PostgreSQL**

Esto también lo pueden hacer desde la línea de comando. A continuación te doy el paso a paso: 

* Entrar a la línea de comando del contenedor con la base de datos Postgres por medio de

```bash
docker exec -it compose_grafana_db_1 psql -U grafana
```

* Visualizar todos las tablas creadas por grafana por medio del comando de psql

```
grafana=# \dt
```

* Crear una nueva tabla llamada logs

```plsql
grafana=# CREATE TABLE grafana.logs(
    log_id serial,
    datetime timestamp,
    slave_name varchar(20),
    master_name varchar(20),
    district_name varchar(20),
    water_amount integer,
    CONSTRAINT log_pkey PRIMARY KEY (log_id)
);
```

* Visualizar las características de la tabla creada por medio del comando;

```
grafana=# \d logs
```

Con esto listo puedes pasar al siguiente paso. Te recomiendo dejar la línea de comando abierta para realizar algunos query más adelante

#### A4-Node-RED

**Crear el generador de datos aleatorios en la instancia de Node-Red**

Abrir el contenedor de node-red o ir directamente a tu navegador y acceder a la dirección **localhost:1880**. Una haya cargado la página, acceder al menú que se encuentra en la esquina superior derecha e ir a la sección *Manage palette*.

Al hacer esto es abrirá un nuevo menú. Buscar la sección *Palette > Install* y luego buscar e instalar el módulo llamado **node-red-contrib-postgres-multi**.

Una vez instalado, hacer click nuevamente al menú de la esquina superior derecha y darle a *Import > Clipboard*. Se abrirá un modal que te permitirá importar un 'flow' en formato .JSON. Importar el archivo **data_generator_flow.json** que está en el directorio /src.

Por último hacer click en **Deploy** para que se empiecen a escribir datos en la tabla 'logs' de la base de datos. Revisar el debug de node-red para validar que no haya ningún problema. 

#### A5-Grafana

**(Abrir grafana e importar el dashboard creado)**

Abrir el contenedor de grafana o ir directamente a tu navegador y acceder a la dirección **localhost:3000**. Esto abrirá una ventana para hacer log. Para ingresar, la combinación [usuario/contraseña] es [admin/admin]. Seguidamente se procederá se te pedirá cambiar la clave de acceso al usuario 'admin'. Usar la de tu preferencia.

En la ventana de bienvenida se muestran los pasos a realizar para poder utilizar Grafana. Tal y como se indica. El siguiente paso en 'Creata a data source'. Se debe click en el ícono y luego buscar la base de datos PostgreSQL y hacer click en el ícono. 

Una dentro, los datos que se ingresarán son los siguientes: 

* Name: PostgreSQL
* PostgreSQL Connection
  * Host: **db:5432**
  * Database: **grafana**
  * User: **grafana**
  * Password: **password**
  * SSL Mode: **disable**

Con estos datos ingresados hacer click en **Save & Test**. Si todo está funcionando correctamente debería recibir un mensaje de *"Database Connection OK"*

Una vez confirmada la conexión, buscar en el menú izquierdo la pestaña *'Dashboard'*, haz click la pestaña *'Manage'* y luego en la sección *'Import'*.

Al hacer click se abrirá una ventana. Una vez allí debes darle click al botón 'Upload .json file' y cargar el archivo **grafana-dashboard.json** que se encuentra en el directorio /src. Asignarle Folser: General y borrar el Unique Identifier para que Grafana lo asigne automáticamente.

#### A6-Vídeo

Con todo lo anterior funcionando ya puedes empezar a jugar con tu repo. En este [vídeo](https://youtu.be/UO6tl2n1UvE) les explico el proceso y la motivación detrás de este proyecto.



## B-Mejoras

Si bien con los archivos que disponibles en este repo el proyecto está funcionando. Sería interesante poder agregarle otras capacidades. He pensado en algunas de ellas y las agrupo en 4 grandes áreas.

### B1-PostgreSQL

**(Almacenamiento)**

* Trabajar con entidades separadas en vez de escribir en una única tabla.
* Escribir directamente en la tablas de cada una de las entidades
* Crear el query que me produzcan la tabla 'logs'.

### B2-Node-RED

**(Generación de Datos)**

* Simplificar la forma en que se escriben los datos en la bases de datos. 
* Utilizar nodos JOIN para unir las lecturas generadas por cada uno de los medidores y escribir en la base de datos una única vez
* Generación de datos más realistas. Que sigan un patrón o una función.

### B3-Grafana

**Visualización de Datos** 

* Generar alarmas dentro de Grafana, que aparezcan en el tablero
* Descargar los datos de un usuario por medio de grafana. 
* Utilizar fuentes de datos adicionales.

### B4-Python

**(Manipulación de datos / Visualización)**

* Descargar el histórico de los datos generados. Darles formato con Pandas.
* Generar reportes históricos del consumo de una distrito y cualquier otro reporte de interés.







------

## README [English]

Hi! The objective with this project is to give you the opportunity to build you own dashboard with grafana. This video comes with a video explanation

### A-Easy Start

[Waiting for confirmation of spanish users]