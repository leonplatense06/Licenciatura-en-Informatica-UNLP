program menu;
const
	valorImposible = 9999;
type
	emp = record
		nro:integer;
		ape:string;
		nom:string;
		edad:integer;
		dni:integer;
	end;
	arch_emp = file of emp;
	arch_text = Text;

procedure menuDeVisualizacion (var option:integer);
begin
	writeln('Opciones de "Visualizar Archivo":');
	writeln('1- Listar Datos de un Empleado a Partir de su Apellido/Nombre.', LineEnding, '2- Mostrar Todos los Empleados.', LineEnding, '3- Mostrar Empleados Proximos a Jubilarse.');
	write('Eleccion: ');readln(option);
end;

procedure menu (var option:integer);
begin
	write('Tarea a Realizar:', LineEnding, '1- Cargar un Archivo de Empleados.', LineEnding, '2- Visulizar Archivo.', LineEnding, '3- Agregar Empleado.', LineEnding, '4- Modificar la Edad de un Empleado.', LineEnding, '5- Exportar.', LineEnding, '6- Salir.', LineEnding, 'Eleccion: ');
	readln(option);
end;

procedure menuDeExportacion (var option:integer);
begin
	writeln('Opciones de "Exportar un Archivo":');
	writeln('1- Exportar Todos los Empleados.', LineEnding, '2- Exportar Empleados Faltantes de DNI.');
	write('Eleccion: ');readln(option);
end;

procedure leer (var e:emp);
begin
	write('apellido: ');readln(e.ape);
	if (e.ape <> 'fin') then begin
		write('nombre: ');readln(e.nom);
		write('nro. de Empleado: ');readln(e.nro);
		write('edad: ');readln(e.edad);
		write('DNI: ');readln(e.dni);
	end;
end;

procedure cargarArch(var arc:arch_emp);
	procedure cargar (var arc:arch_emp);
	var
		e:emp;
	begin
		writeln('Cargar un Empleado.');
		leer(e);
		while (e.ape <> 'fin') do begin
			write(arc, e);
			writeln();writeln('Cargar un Empleado.');writeln();
			leer(e);
		end;			
	end;	
begin
	rewrite(arc);
	cargar(arc);
	close(arc);
	writeln('----------------', LineEnding, 'ARCHIVO CARGADO', LineEnding, '----------------');
end;

procedure asignarArch(var arc:arch_emp);
var
	nomFisico:string[12];
begin
	write('Nombre del Archivo: ');readln(nomFisico);
	assign(arc, nomFisico);
end; 

procedure leer1 (var arc:arch_emp; var eAux:emp);
begin
	if not (eof(arc)) then
		read(arc, eAux)
	else
		eAux.nro := valorImposible;
end;

procedure imprimirEmple(e:emp; var i:integer);
begin
	writeln();
	writeln('-------------------', LineEnding, 'DATOS DEL EMPLEADO. (', i, ')');
	i := i + 1;
	writeln('Apellido y Nombre: ', e.ape, ' ', e.nom, '.');
	writeln('Nro. de Empleado: ', e.nro, '.');
	writeln('DNI: ', e.dni, '.');
	writeln('Edad: ', e.edad, '.');
	writeln('-------------------');
end;	

procedure mostrarApeNom(var arc:arch_emp);
var
	apenom:string;
	e:emp;
	i:integer;
begin
	write('Ingrese el Apellido/Nombre del Empleado: ');readln(apenom);
	reset(arc);
	i := 1;
	leer1(arc, e);
	while (e.nro <> valorImposible) do begin
		if ((e.ape = apenom) or (e.nom = apenom)) then
			imprimirEmple(e, i);
		leer1(arc, e);
	end;
	close(arc);
end;

procedure mostrarTodos(var arc:arch_emp);
var
	e:emp;
	i:integer;
begin
	reset(arc);
	i := 1;
	leer1(arc, e);
	while (e.nro <> valorImposible) do begin
		imprimirEmple(e, i);
		leer1(arc, e);
	end;
	close(arc);
end;

procedure mostrarProxJub(var arc:arch_emp);
var
	e:emp;
	i:integer;
begin
	reset(arc);
	leer1(arc, e);
	i := 1;
	while (e.nro <> valorImposible) do begin
		if (e.edad >= 70) then
			imprimirEmple(e, i);
		leer1(arc, e);			
	end;
	close(arc);
end;

procedure agregarEmple(var arc:arch_emp);
var
	e, eAux:emp;
	seguir:boolean;
begin
	writeln('Agregar un Empleado.');
	leer(e);
	while (e.ape <> 'fin') do begin
		reset(arc);
		leer1(arc, eAux);
		seguir := true;
		while ((eAux.nro <> valorImposible) and (seguir)) do begin
			if (eAux.nro = e.nro) then
				seguir := false
			else
				leer1(arc, eAux);
		end;
		if (seguir) then begin
			write(arc, e);
			writeln();writeln('-------------------', LineEnding, 'EMPLEADO AGREGADO.', LineEnding, '-------------------');writeln();
		end
		else
			writeln('-------------------------', LineEnding, 'Ese nro. de Empleado ya esta en el archivo.', LineEnding, '-------------------------');
		leer(e);
		close(arc);
	end;
end;

procedure modificarEdad (var arc:arch_emp);
var
	e:emp;
	nuevaEdad, nroEmp, uno:integer;
	seguir:boolean;
begin
	write('Ingrese el Nro. del Empleado: ');readln(nroEmp);
	reset(arc);
	leer1(arc, e);
	seguir := true;
	uno := 1;
	while (e.nro <> valorImposible) and (seguir) do begin
		if (e.nro = nroEmp) then
			seguir := false
		else
			leer1(arc, e);
	end;
	if not(seguir) then begin
		writeln();writeln('-------------------', LineEnding, 'ENCONTRADO.', LineEnding, '-------------------');
		imprimirEmple(e, uno);
		write('Ingese la Edad Que Desea Ajudicarle: ');readln(nuevaEdad);
		e.edad := nuevaEdad;
		seek(arc, filepos(arc)-1);
		write(arc, e);
	end
	else
		writeln();writeln('-------------------', LineEnding, 'NO EXISTE EMPLEADO.', LineEnding, '-------------------');
	close(arc);
end;

procedure asignarArchivoTexto (var arcTxt:arch_text; action:integer);
begin
	if (action = 1) then
		assign(arcTxt, 'todos_empleados.txt')
	else
		assign(arcTxt, 'faltaDNIEmpleado.txt');
	rewrite(arcTxt);
	close(arcTxt);
end;

procedure agregarAArchivoTxt (var arcTxt:arch_text; e:emp);
begin
	writeln(arcTxt, e.nro, ' ', e.dni, ' ', e.edad);
	writeln(arcTxt, e.nom);
	writeln(arcTxt, e.ape);
end;

procedure exportarTodos (var arc:arch_emp; var arcTxt:arch_text);
var
	e:emp;
begin
	reset(arc);append(arcTxt);
	while not (eof(arc)) do begin
		read(arc, e);
		agregarAArchivoTxt(arcTxt, e);
	end;
	close(arc);close(arcTxt);
end; 

procedure exportarFaltanDni (var arc:arch_emp; var arcTxt:arch_text);
var
	e:emp;
begin
	reset(arc);append(arcTxt);
	while not (eof(arc)) do begin
		read(arc, e);
		if (e.dni = 00) then
			agregarAArchivoTxt(arcTxt, e);
	end;
	close(arc);close(arcTxt);
end;

var
	op:integer;
	arc:arch_emp;
	arcTxtTodos, arcTxtDni00:arch_text;
begin
	menu(op);
	if (op <> 6) then
		asignarArch(arc);
	while (op <> 6) do begin
		if (op = 1) then
			cargarArch(arc)
		else if (op = 2) then begin
			menuDeVisualizacion(op);
			case op of
				1:mostrarApeNom(arc);
				2:mostrarTodos(arc);
				3:mostrarProxJub(arc);
			end;
		end
		else if (op = 3) then
			agregarEmple(arc)
		else if (op = 4) then
			modificarEdad(arc)
		else begin
			menuDeExportacion(op);
			case op of
				1:begin asignarArchivoTexto(arcTxtTodos, 1);exportarTodos(arc, arcTxtTodos);end;
				2:begin asignarArchivoTexto(arcTxtDni00, 2);exportarFaltanDni(arc, arcTxtDni00);end;
			end;
			writeln();writeln('-------------------', LineEnding, 'ARCHIVO EXPORTADO.', LineEnding, '-------------------');
		end;
		menu(op);
	end;
	writeln();writeln('--------------------', LineEnding, 'EJECUCION FINALIZADA', LineEnding, '--------------------');
end.
