program ONG;
const
	vA = (9999);
	dets = 10;
type
	reg_mae = record
		codProv:integer;
		nomProv:string;
		codLoc:integer;
		nomLoc:string;
		vivSinLuz:integer;
		vivSinGas:integer;
		vivDeChapa:integer;
		vivSinAgua:integer;
		vivSinSanitario:integer;
	end;
	
	reg_det = record
		codProv:integer;
		codLoc:integer;
		vivConLuz:integer;
		vivConstru:integer;
		vivConagua:integer;
		vivConGas:integer;
		entregaSanitario:integer;
	end;
	
	arch_mae = file of reg_mae;
	arch_det = file of reg_det;
	
	arrayDet = array[1..dets] of arch_det;
	arrayReg = array[1..dets] of reg_det;
	
procedure asignarArc (var mae:arch_mae; var vecDet:arrayDet);
var
	i:integer;
	num:string;
begin
	assign(mae, 'maestro');
	for i:=1 to dets do begin
		Str(i, num);
		assign(vecDet[i], 'detalle' + num);
	end;
end;

procedure leer (var det:arch_det; var r:reg_det);
begin
	if (not eof(det)) then
		read(det, r)
	else
		r.codProv := vA;
end;

procedure minimo (var vecDet:arrayDet; var vecReg:arrayReg; var min:reg_det);
var
	i, posMin:integer;
begin
	min.codProv := vA;
	min.codLoc := vA;
	posMin := vA;
	for i:=1 to dets do begin
		if (vecReg[i].codProv <> vA) then begin
			if (vecReg[i].codProv < min.codProv) then begin
				min := vecReg[i];
				posMin := i;
			end
			else if (vecReg[i].codProv = min.codProv) and (vecReg[i].codLoc < min.codLoc) then begin
				min := vecReg[i];
				posMin := i;
			end;
		end;
	end;
	if (posMin <> vA) then
		leer(vecDet[posMin], vecReg[posMin]);
end;

procedure actualizar_reg (var regM:reg_mae; min:reg_det);
begin
	regM.vivSinLuz := regM.vivSinLuz - min.vivConLuz;
	regM.vivSinAgua := regM.vivSinAgua - min.vivConAgua;
	regM.vivSinGas := regM.vivSinGas - min.vivConGas;
	regM.vivSinSanitario := regM.vivSinSanitario - min.entregaSanitario;
	regM.vivDeChapa := regM.vivDeChapa - min.vivConstru;
end;

function contar_sin_viv_con_chapa (cant_viv_chapa, contador:integer):integer;
begin
	if (cant_viv_chapa = 0) then
		contar_sin_viv_con_chapa := contador + 1
	else
		contar_sin_viv_con_chapa := contador;
end;

procedure actualizar_maestro (var mae:arch_mae; var vecDet:arrayDet);
var
	vecReg:arrayReg;
	min:reg_det;
	regM:reg_mae;
	i, contador:integer;
	
begin
	for i:=1 to dets do begin
		reset(vecDet[i]);
		leer(vecDet[i], vecReg[i]);
	end;
	contador := 0;
	reset(mae);
	minimo(vecDet, vecReg, min);
	while (min.codProv <> vA) do begin
		read(mae, regM);
		while (regM.codProv <> min.codProv) or (regM.codLoc <> min.codLoc) do begin
			contador := contar_sin_viv_con_chapa(regM.vivDeChapa, contador);
			read(mae, regM);
		end;
		// La misma combinación de provincia y localidad aparecen a lo sumo una única vez, x lo q no hace falta un while
		actualizar_reg(regM, min);
		contador := contar_sin_viv_con_chapa(regM.vivDeChapa, contador);
		seek(mae, filepos(mae)-1);
		write(mae, regM);
		minimo(vecDet, vecReg, min);
	end;
	close(mae);
	for i:=1 to dets do 
		close(vecDet[i]);
	writeln('Existen ', contador, ' Localidades Sin Viviendas De Chapa.');
end;

var
	mae:arch_mae;
	vecDet:arrayDet;
begin
	asignarArc(mae, vecDet);
	actualizar_maestro(mae, vecDet);
end.
