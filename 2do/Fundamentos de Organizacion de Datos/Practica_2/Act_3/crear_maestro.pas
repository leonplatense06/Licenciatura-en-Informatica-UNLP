program maestro;
type
	prov = record
		nom:string;
		alfa:integer;
		tot:integer;
	end;
	arch_mae = file of prov;

procedure cargarReg (var p:prov);
begin
	write('Ingrese el Nombre de Prov.: ');readln(p.nom);
	if (p.nom <> 'zzz') then begin
		writeln('Ingrese Cant. de Alfabetizados: 0');p.alfa := 0;
		writeln('Ingrese Total de Encuestados: 0');p.tot := 0;
	end;
end;

procedure cargarMaestro (var mae:arch_mae);
var
	p:prov;
begin
	rewrite(mae);
	cargarReg(p);
	while (p.nom <> 'zzz') do begin
		write(mae, p);
		cargarReg(p);
	end;
	writeln(LineEnding, '-------------------', LineEnding, 'Maestro Cargado.', LineEnding, '-------------------', LineEnding);
	close(mae);
end;

procedure mostrarMaestro (var mae:arch_mae);
var
	p:prov;
begin
	reset(mae);
	while (not eof(mae)) do begin
		read(mae, p);
		writeln('-------------------', LineEnding, 'Provincia.', LineEnding, '-------------------');
		writeln('Nombre de la Prov.: ', p.nom, '.');
		writeln('Alfabetizados: ', p.alfa, '.');
		writeln('Total de Encuestados: ', p.tot, '.');
		writeln('-------------------');
	end;
	close(mae);
end;

var
	mae:arch_mae;
begin
	assign(mae, 'maestro');
	cargarMaestro(mae);
	mostrarMaestro(mae);
end.
