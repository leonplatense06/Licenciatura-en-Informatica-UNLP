program detalles;
type
	censo = record
		nom:string;
		cod:integer;
		alfa:integer;
		tot:integer;
	end;
	arch_det = file of censo;
	
procedure asignarArc (var det1, det2:arch_det);
begin
	assign(det1, 'detalle1');
	assign(det2, 'detalle2');
end;

procedure cargarReg (var c:censo);
begin
	write('Ingrese Nombre de Prov.: ');readln(c.nom);
	if (c.nom <> 'zzz') then begin
		write('Ingrese Codigo de Localidad: ');c.cod := Random(99) + 1;writeln(c.cod, '.');
		write('Ingrese Cant. de Alfabetizados: ');readln(c.alfa);
		write('Ingrese el Total de Encuestados: ');readln(c.tot);
		readln;
	end;
end;

procedure cargarDetalle (var det:arch_det);
var
	c:censo;
begin
	rewrite(det);
	cargarReg(c);
	while (c.nom <> 'zzz') do begin
		write(det, c);
		cargarReg(c);
	end;
	writeln(LineEnding, '-------------------', LineEnding, 'Termino la Carga del Detalle.', LineEnding, '-------------------');
	close(det);
end;

var
	det1, det2:arch_det;
begin
	asignarArc(det1, det2);
	cargarDetalle(det1);cargarDetalle(det2);
end.



