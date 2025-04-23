program menu;
type
	emp = record
		nro:integer;
		ape:string;
		nom:string;
		edad:integer;
		dni:integer;
	end;
	arch_emp = file of emp;

procedure menu2 (var option:integer);
begin
	writeln('Opciones de "Visualizar Archivo":');
	writeln('3- Listar Datos de un Empleado a Partir de su Apellido/Nombre.', LineEnding, '4- Mostrar Todos los Empleados.', LineEnding, '5- Mostrar Empleados Proximos a Jubilarse.');
	write('Eleccion: ');readln(option);
end;

procedure menu (var option:integer);
begin
	write('Tarea a Realizar:', LineEnding, '1- Cargar un Archivo de Empleados.', LineEnding, '2- Visulizar Archivo.', LineEnding, 'Eleccion: ');
	readln(option);
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
var
	nomFisico:string[12];
begin
	write('Nombre del Archivo: ');readln(nomFisico);
	assign(arc, nomFisico);
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
	while not (eof(arc)) do begin
		read(arc, e);
		if ((e.ape = apenom) or (e.nom = apenom)) then
			imprimirEmple(e, i);
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
	while not (eof(arc)) do begin
		read(arc, e);
		imprimirEmple(e, i);
	end;
	close(arc);
end;

procedure mostrarProxJub(var arc:arch_emp);
var
	e:emp;
	i:integer;
begin
	reset(arc);
	i := 1;
	while not (eof(arc)) do begin
		read(arc, e);
		if (e.edad >= 70) then
			imprimirEmple(e, i);
	end;
	close(arc);
end;

var
	op:integer;
	arc:arch_emp;
begin
	menu(op);
	if (op = 1) then
		cargarArch(arc)
	else begin
		asignarArch(arc);
		menu2(op);
		case op of
			3:mostrarApeNom(arc);
			4:mostrarTodos(arc);
			5:mostrarProxJub(arc);
		end;
	end;
end.
