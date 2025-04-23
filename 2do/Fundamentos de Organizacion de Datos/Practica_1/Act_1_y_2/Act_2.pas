program Act2;
type
	arch_int = file of integer;
procedure asignar(var arc:arch_int);
var
	nom:string[12];
begin
	write('Ingrese el Nombre del Archivo: ');
	read(nom);
	assign(arc, nom); //le digo al programa q, cuando hablo de arc en mi codigo, me refiero al archivo que el usuario me indicó
					  //q desea operar
end;
procedure procesarYMostrar (var arc:arch_int; var cantMenores:integer; var promedio:real; menor:integer);
var
	aux, suma, cant:integer;
begin
	reset(arc);
	suma := 0;
	cant := 0;
	writeln();
	writeln('Datos Guardados: ');
	while not(eof(arc)) do begin
		read(arc, aux);
		cant := cant + 1;
		writeln(aux, '.');
		if (aux < menor) then
			cantMenores := cantMenores + 1;
		suma := suma + aux;
	end;
	writeln();
	promedio := suma / cant;
end;

var
	menor, cantMenores:integer;
	promedio:real;
	arc:arch_int;
begin
	asignar(arc);
	menor := 1500;
	promedio := 0.0;
	cantMenores := 0;
	procesarYMostrar(arc, cantMenores, promedio, menor);
	writeln('La Cantidad de Numeros Menores a ', menor, ' Es: ', cantMenores);
	writeln();
	writeln('El Promedio de los Numeros Es: ', promedio:0:2);
end.
		
