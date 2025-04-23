program act1;
type 
	arch_int = file of integer;
procedure cargarArch (var arc:arch_int);
var
	nro:integer;
begin
	write('Introduzca un Nro. para Guardar (30000 para finalizar): ');read(nro);writeln();
	while nro <> 30000 do begin
		write(arc, nro);
		write('Introduzca un Nro. para Guardar (30000 para finalizar): ');read(nro);
		writeln();
	end;
	writeln('Fin de la Carga.');
end;

var
	arc:arch_int;
	nom_arc:string[12];
begin
	write('Introduzca el Nombre del Archivo: ');read(nom_arc);
	assign(arc, nom_arc);
	rewrite(arc);
	cargarArch(arc);
	close(arc);
end.
