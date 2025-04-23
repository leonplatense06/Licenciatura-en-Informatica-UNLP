program baja_logica;
const vA = (-1); c = '*'; inferior = 1000;
type
	asis = record
		nro:integer;
		ape_nom:string;
		email:string;
		tel:integer;
		dni:integer;
	end;
	
	arch = file of asis;

procedure asignar_arc (var arc:arch);
begin
	assign(arc, 'archivo');
end;

procedure leer (var arc:arch; var r:asis);
begin
	if (not eof(arc)) then
		read(arc, r)
	else
		r.nro := vA;
end;

procedure cargar_reg (var r:asis);
begin
	Randomize;
	writeln('------------------------------------------------------');
	write('Ingrese el Nro. de asistente (', vA, ' para terminar): ');readln(r.nro);
	if (r.nro <> vA) then begin
		write('Ingrese Apellido y Nombre del asistente: ');readln(r.ape_nom);
		write('Ingrese Email del Asistente: ');readln(r.email);
		r.tel := Random(300) + 100; writeln('Telefono: ', r.tel);
		r.dni := Random(500) + 100; writeln('DNI: ', r.dni);
	end;
	writeln('------------------------------------------------------');
end;

procedure cargar_archivo (var arc:arch);
var
	reg:asis;
begin
	rewrite(arc);
	cargar_reg(reg);
	while (reg.nro <> vA) do begin
		write(arc, reg);
		cargar_reg(reg);
	end;
	close(arc);
	writeln();
	writeln('----------------------------');
	writeln('Finalizo Carga del Archivo.');
	writeln('----------------------------');
end;

procedure bajas_logicas (var arc:arch);
var
	reg:asis;
begin
	reset(arc);
	leer(arc, reg);
	while (reg.nro <> vA) do begin
		if (reg.nro < inferior) then begin
			reg.ape_nom := c + reg.ape_nom; // c = '*'
			seek(arc, filepos(arc)-1);
			write(arc, reg);
		end;
		leer(arc, reg);
	end;
	writeln(LineEnding, '--------------------------', LineEnding, 'Bajas Logicas Efectuadas.', LineEnding, '--------------------------');
	writeln();
	close(arc);
end;

procedure imprimir_archivo (var arc:arch);
	procedure mostrar_reg (reg:asis);
	begin
		writeln('--------------------');
		writeln('Nro. de Asistente: ', reg.nro);
		writeln('Apellido y Nombre: ', reg.ape_nom);
		writeln('Email: ', reg.email);
		writeln('Telefono: ', reg.tel);
		writeln('DNI: ', reg.dni);
		writeln('--------------------');
	end;
var
	reg:asis;
	i:integer;
begin
	reset(arc);
	leer(arc, reg);
	i := 1;
	while (reg.nro <> vA) do begin
		writeln('--------------------', LineEnding, 'Asistente ', i, '.', LineEnding, '--------------------');
		mostrar_reg(reg);
		i := i + 1;
		leer(arc, reg);
	end;
	writeln(LineEnding, '--------------------------', LineEnding, 'Finalizo la Impresion del Archivo.', LineEnding, '--------------------------');
	close(arc);
end;

var
	arc:arch;
begin
	asignar_arc(arc);
	cargar_archivo(arc);
	bajas_logicas(arc);
	imprimir_archivo(arc);
end.
