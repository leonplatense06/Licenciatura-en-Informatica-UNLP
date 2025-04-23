program maestro_2detalles;
const valorAlto = 'zzz';
type
	prov = record
		nom:string;
		alfa:integer;
		tot:integer;
	end;
	censo = record
		nom:string;
		cod:integer;
		alfa:integer;
		tot:integer;
	end;
	
	arch_mae = file of prov;
	arch_det = file of censo;

procedure asignarArc (var mae:arch_mae; var det1, det2:arch_det);
begin
	assign(mae, 'maestro');assign(det1, 'detalle1');assign(det2, 'detalle2');
end;

procedure leer (var det:arch_det; var c:censo);
begin
	if (not eof(det)) then
		read(det, c)
	else
		c.nom := valorAlto;
end;

procedure minimo (var det1, det2:arch_det; var reg1, reg2, min:censo);
begin
	if (reg1.nom <= reg2.nom) then begin
		min := reg1;
		leer(det1, reg1);
	end
	else begin
		min := reg2;
		leer(det2, reg2);
	end;
end;

procedure actualizarMaestro (var mae:arch_mae; var det1, det2:arch_det);
var
	r1, r2, min:censo;
	regM:prov;
begin
	reset(mae);reset(det1);reset(det2);
	leer(det1, r1);leer(det2, r2);
	minimo(det1, det2, r1, r2, min);
	while (min.nom <> valorAlto) do begin
		read(mae, regM);
		while (regM.nom <> min.nom) do
			read(mae, regM);
		while (min.nom = regM.nom) do begin
			regM.alfa := regM.alfa + min.alfa;
			regM.tot := regM.tot + min.tot;
			minimo(det1, det2, r1, r2, min);
		end;
		seek(mae, filepos(mae)-1);
		write(mae, regM);
	end;
	close(mae);close(det1);close(det2);
	writeln(LineEnding, '-------------------', LineEnding, 'Maestro Actualizado.', LineEnding, '-------------------', LineEnding);
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
	det1, det2:arch_det;
begin
	asignarArc(mae, det1, det2);
	actualizarMaestro(mae, det1, det2);
	mostrarMaestro(mae);
end.
