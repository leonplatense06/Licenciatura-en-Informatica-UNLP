program lista_invertida;
const
	corte = (-1);
	vA = MaxInt;
type
	nov = record
		cod:integer;
		gen:integer;
		nom:string;
		dur:integer;
		dir:string;
		precio:real;
	end;
	
	arch = file of nov;
	arch_txt = Text;
	
procedure asignar_arc_nuevo (var arc:arch);
var
	n:string;
	cab:nov;
begin
	write('Ingrese el Nombre del Archivo: ');readln(n);
	assign(arc, n);
	cab.cod := 0;cab.gen := 0; cab.nom := ''; cab.dur := 0; cab.dir := ''; cab.precio := 0.0;
	rewrite(arc);
	write(arc, cab);
	close(arc);
end;

procedure asignar_arc_creado (var arc:arch);
var
	nom:string;
begin
	write('Ingrese el Nombre del Archivo: ');readln(nom);
	assign(arc, nom);
end;

procedure ingresar_nov (var r:nov);
begin
	write('Ingrese Codigo de la Novela (', corte,') Para Finalizar): ');readln(r.cod);
	if (r.cod <> corte) then begin
		write('Ingrese Genero de la Novela: ');readln(r.gen);
		write('Ingrese Nombre de la Novela: ');readln(r.nom);
		write('Ingrese Duracion en Minutos de la Novela: ');readln(r.dur);
		write('Ingrese Director de la Novela: ');readln(r.dir);
		write('Ingrese el Precio de la Novela: ');readln(r.precio);
	end;
end;

procedure cargar_archivo (var arc:arch);
var
	reg:nov;
begin
	reset(arc);
	seek(arc, filesize(arc));
	ingresar_nov(reg);
	while (reg.cod <> corte) do begin
		write(arc, reg);
		writeln(LineEnding, 'Novela Agregada.');
		writeln('-------------------------------', LineEnding);
		ingresar_nov(reg);
	end;
	writeln('-------------------------------', LineEnding, 'ARCHIVO CARGADO.', LineEnding, '-------------------------------');
	close(arc);
end;

procedure alta (var arc:arch);
	procedure actualizar_cabecera (var arc:arch; cab:nov);
	var
		rAux:nov;
	begin
		seek(arc, -(cab.cod));
		read(arc, rAux);
		seek(arc, 0);
		write(arc, rAux);
		seek(arc, -(cab.cod));
	end;
	procedure agregar_nov (var arc:arch);
	var
		reg:nov;
	begin
		ingresar_nov(reg);
		write(arc, reg);
	end;
var
	cab:nov;
begin
	reset(arc);
	read(arc, cab); //leer registro cabecera (estoy seguro de que existe ya que se crea junto con el archivo)
	if (cab.cod = 0) then begin
		seek(arc, filesize(arc));
		agregar_nov(arc);
	end		
	else begin
		actualizar_cabecera(arc, cab);
		agregar_nov(arc);
	end;
	close(arc);
	writeln('-------------------------------', LineEnding, 'ALTA EFECTUADA.', LineEnding, '-------------------------------');
end;

procedure leer (var arc:arch; var reg:nov);
begin
	if (not eof(arc)) then
		read(arc, reg)
	else
		reg.cod := vA;
end;

procedure informar_nov (reg:nov);
begin
	writeln('----------------------');
	writeln('Codigo: ', reg.cod);
	writeln('Nombre: ', reg.nom);
	writeln('Duracion: ', reg.dur);
	writeln('Director: ', reg.dir);
	writeln('Precio: ', reg.precio:0:2);
	writeln('----------------------');
end;

procedure modificar_datos(var r:nov);
begin
	write('Ingrese el Nuevo Nombre de la Novela: ');readln(r.nom);
	write('Ingrese la Nueva Duracion en Minutos de la Novela: ');readln(r.dur);
	write('Ingrese el Nuevo Director de la Novela: ');readln(r.dir);
	write('Ingrese el Nuevo Precio de la Novela: ');readln(r.precio);
end;

procedure modificar_novela (var arc:arch);
var
	reg:nov;
	cod:integer;
begin
	write('Ingrese el Codigo de la Novela a Modificar: ');readln(cod);
	reset(arc);
	leer(arc, reg);
	while (reg.cod <> vA) and (reg.cod <> cod) do
		leer(arc, reg);
	if (reg.cod = cod) then begin
		writeln('-------------------------------', LineEnding, 'NOVELA.', LineEnding, '-------------------------------');
		informar_nov(reg);
		writeln('-------------------------------', LineEnding, 'REALIZAR CAMBIOS.', LineEnding, '-------------------------------');
		modificar_datos(reg);
		seek(arc, filepos(arc)-1);
		write(arc, reg);
		writeln('-------------------------------', LineEnding, 'NOVELA MODIFICADA.', LineEnding, '-------------------------------');
	end
	else
		writeln('-------------------------------', LineEnding, 'LA NOVELA NO SE ENCUENTRA EN EL ARCHIVO.', LineEnding, '-------------------------------');
	close(arc);
end;

procedure baja (var arc:arch);
	procedure efectuar_baja_logica (var arc:arch; cab, rAux:nov);
	begin
		seek(arc, filepos(arc)-1);
		write(arc, cab);
		cab := rAux;
		cab.cod := -(filepos(arc)-1);
		seek(arc, 0);
		write(arc, cab);
	end;
var
	cod:integer;
	cab, rAux:nov;
begin
	write('Ingrese el Codigo de la Novela a Borrar: ');readln(cod);
	reset(arc);
	read(arc, cab); //leo registro cabecera
	leer(arc, rAux);
	while (rAux.cod <> vA) and (rAux.cod <> cod) do
		leer(arc, rAux);
	if (not rAux.cod = cod) then
		writeln('-------------------------------', LineEnding, 'LA NOVELA NO SE ENCUENTRA EN EL ARCHIVO.', LineEnding, '-------------------------------')
	else begin
		efectuar_baja_logica(arc, cab, rAux);
		writeln('-------------------------------', LineEnding, 'NOVELA BORRADA.', LineEnding, '-------------------------------');
	end;
	close(arc);
end;

procedure exportar_a_txt (var arc:arch; var arcTxt:arch_txt);
	procedure escribir_linea (var arcTxt:arch_txt; reg:nov);
	begin
		writeln(arcTxt, reg.cod, ' | ', reg.gen, ' | ', reg.nom, ' | ', reg.dur, 'mins. | ', reg.dir, ' | $', reg.precio:0:2);
	end;
var
	reg:nov;
begin
	assign(arcTxt, 'novelas.txt');
	rewrite(arcTxt);
	reset(arc);
	read(arc, reg); //cabecera
	if (reg.cod <> 0) then
		escribir_linea(arcTxt, reg);
	leer(arc, reg);
	while (reg.cod <> vA) do begin
		if (reg.cod <> 0) then
			escribir_linea(arcTxt, reg);
		leer(arc, reg);
	end;
	writeln('-------------------------------', LineEnding, 'SE HA CREADO "novelas.txt".', LineEnding, '-------------------------------');
	close(arc);
	close(arcTxt);
end;

procedure menu (var op:integer);
begin
	writeln('-------------------------------');
	writeln('1- Crear un Archivo de Novelas.', LineEnding, '2- Agregar Una Novela.', LineEnding, '3- Modificar Una Novela', LineEnding, '4- Eliminar una Novela.', LineEnding, '5- Exportar a "novelas.txt".', LineEnding, '0- Salir.'); 
	readln(op);
	writeln('-------------------------------');
end;
var
	arc:arch;
	arcTxt:arch_txt;
	op:integer;
	ans:char;
begin
	menu(op);
	if (op <> 0) then begin
		if (op <> 1) then begin
			writeln('Usar Archivo Existente? [y/n]: ');readln(ans);
			if (ans = 'y') then
				asignar_arc_creado(arc)
			else
				asignar_arc_nuevo(arc);
		end;
	end;
	while (op <> 0) do begin
		case op of
			1:cargar_archivo(arc);
			2:alta(arc);
			3:modificar_novela(arc);
			4:baja(arc);
			5:exportar_a_txt(arc, arcTxt);
		end;
		menu(op);
	end;
end.
