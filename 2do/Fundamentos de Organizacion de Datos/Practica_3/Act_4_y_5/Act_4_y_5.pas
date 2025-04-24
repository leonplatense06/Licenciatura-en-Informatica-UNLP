program flores;
const
	corte = (-1); vA = MaxInt;
type
	reg_flor = record
		nombre: String[45];
		codigo: integer;
	end;
	
	tArchFlores = file of reg_flor;

procedure asignar_arc (var arc:tArchFlores);
begin
	assign(arc, 'archivo');
end;

procedure cargar_reg (var flor:reg_flor);
begin
	write('Ingrese Codigo de Flor (', corte, ' para finalizar): ');readln(flor.codigo);
	if (flor.codigo <> corte) then begin
		write('Ingrese el Nombre de la Flor: ');readln(flor.nombre);
	end;
end;

procedure cargar_arc (var arc:tArchFlores);
var
	flor:reg_flor;
begin
	rewrite(arc);
	flor.codigo := 0; flor.nombre := '';
	write(arc, flor);
	cargar_reg(flor);
	while (flor.codigo <> corte) do begin
		write(arc, flor);
		cargar_reg(flor);
	end;
	writeln('----------------------', LineEnding, 'Archivo Cargado.', LineEnding, '----------------------');
	close(arc);
end;

procedure leer (var arc:tArchFlores; var reg:reg_flor);
begin
	if (not eof(arc)) then
		read(arc, reg)
	else
		reg.codigo := vA;
end;

procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);
var
	cab, rAux:reg_flor;
begin
	reset(a);
	read(a, cab); // leo reg cabecera
	leer(a, rAux);
	while (rAux.codigo <> vA) and (rAux.codigo <> flor.codigo) do
		leer(a, rAux);
	if (rAux.codigo <> flor.codigo) then
		writeln('----------------------', LineEnding, 'La Flor no se Encuentra en el Archivo.', LineEnding, '----------------------')
	else begin
		seek(a, filepos(a)-1);
		write(a, cab);
		seek(a, 0);
		write(a, rAux);
		writeln('----------------------', LineEnding, 'Baja Efectuada.', LineEnding, '----------------------');
	end;
	close(a);
end;		

procedure alta (var arc:tArchFlores; flor:reg_flor);
var
	rAux, cab:reg_flor;
begin
	reset(arc);
	read(arc, cab); // leo reg cabecera
	if (cab.codigo = 0) then begin
		seek(arc, filesize(arc));
		write(arc, flor);
	end
	else begin
		seek(arc, -(cab.codigo));
		read(arc, rAux);
		seek(arc, filepos(arc)-1);
		write(arc, flor);
		seek(arc, 0);
		write(arc, rAux);
	end;
	writeln('----------------------', LineEnding, 'Alta Efectuada.', LineEnding, '----------------------');
	close(arc);
end;

procedure agregarFlor (var a:tArchFlores; nombre:String; codigo:integer);
var
	reg:reg_flor;
begin
	reg.codigo := codigo; reg.nombre := nombre;
	alta(a, reg);
end;

procedure mostrar_flor (flor:reg_flor);
begin
	writeln('----------------------', LineEnding, 'FLOR.');
	writeln();
	writeln('Codigo: ', flor.codigo, '.');
	writeln('Nombre: ', flor.nombre, '.');
	writeln('----------------------');
end;

procedure imprimir_arc (var arc:tArchFlores);
var
	reg:reg_flor;
begin
	reset(arc);
	read(arc, reg); // leo reg cabecera
	leer(arc, reg);
	while (reg.codigo <> vA) do begin
		if (reg.codigo > 0) then
			mostrar_flor(reg);
		leer(arc, reg);
	end;
end;

var
	arc:tArchFlores;
	c:integer;
	n:String[45];
	flor:reg_flor;
begin
	asignar_arc(arc);
	cargar_arc(arc);
	write('Agregar Una Flor.', LineEnding, 'Ingrese el Codigo de la Flor: ');readln(c);
	write('Ingrese el Nombre de la Flor: ');readln(n);
	agregarFlor(arc, n, c);
	imprimir_arc(arc);
	write('Eliminar Una Flor.', LineEnding, 'Ingrese el Codigo de la Flor: ');readln(flor.codigo);
	eliminarFlor(arc, flor);	
	imprimir_arc(arc);
end.
