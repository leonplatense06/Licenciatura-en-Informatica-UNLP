program maestroDetalle;
const
	vA = (9999);
	cantDet = 30;
type
	reg_mae = record
		cod:integer;
		nom:string[20];
		desc:string;
		stockAct:integer;
		stockMin:integer;
		precio:real;
	end;
	reg_det = record
		cod:integer;
		cant:integer;
	end;
	arch_mae = file of reg_mae;
	arch_det = file of reg_det;
	
	arrayDet = array[1..cantDet] of arch_det;
	arrayReg = array[1..cantDet] of reg_det;

procedure leer (var det:arch_det; var r:reg_det);
begin
	if (not eof(det)) then
		read(det, r)
	else
		r.cod := vA;
end;

procedure minimo (var vecDet:arrayDet; var vecReg:arrayReg; var min:reg_det);
var
	i, posMin:integer;
begin
	min.cod := vA;
	for i:=1 to cantDet do begin
		if (vecReg[i].cod <= min.cod) then begin
			min.cod := vecReg[i].cod;
			posMin := i;
		end;
	end;
	min := vecReg[posMin];
	leer(vecDet[posMin], vecReg[posMin]);
end;

procedure informar (var arcTxt:Text; regM:reg_mae);
begin
	writeln(arcTxt, regM.nom, ' | ', regM.desc, ' | ', regM.stockAct, ' | ', regM.stockMin, ' | $', regM.precio:0:2, ' |');
end;

procedure actualizarMaestro (var mae:arch_mae; var vecDet:arrayDet; var vecReg:arrayReg; var arcTxt:Text);
var
	min:reg_det;
	regM:reg_mae;
begin
	reset(mae);rewrite(arcTxt);
	minimo(vecDet, vecReg, min);
	while (min.cod <> vA) do begin
		read(mae, regM);
		writeln('FUERA WHILE: regM.cod = ', regM.cod, ' --- min.cod = ', min.cod);
		while (regM.cod <> min.cod) do begin
			read(mae, regM);
			writeln('DENTRO WHILE: regM.cod = ', regM.cod, ' --- min.cod = ', min.cod);
		end;
		while (min.cod = regM.cod) do begin
			regM.stockAct := regM.stockAct - min.cant;
			minimo(vecDet, vecReg, min);
		end;
		seek(mae, filepos(mae)-1);
		write(mae, regM);
		if (regM.stockAct < regM.stockMin) then
			informar(arcTxt, regM);
	end;
	writeln('-------------', LineEnding, 'Maestro Actualizado.', LineEnding, '-------------');
	close(mae);close(arcTxt);
end;		

var
	i:integer;
	num:string;
	vecDet:arrayDet;
	vecReg:arrayReg;
	mae:arch_mae;
	arcTxt:Text;	
begin
	for i:=1 to cantDet do begin
		Str(i, num);
		assign(vecDet[i], 'detalle' + num);
		reset(vecDet[i]);
		leer(vecDet[i], vecReg[i]);
	end;
	assign(mae, 'maestro');assign(arcTxt, 'stock_minimo.txt');
	actualizarMaestro(mae, vecDet, vecReg, arcTxt);
	
	for i:=1 to cantDet do
		close(vecDet[i]);
end.
