program maestroDetalle;
const
	vA = (9999);
	m = 5; //Cantidad maquinas
type 
	fe = record
		anio:integer;
		mes:integer;
		dia:integer;
	end;
	reg_det = record
		cod:integer;
		fecha:fe;
		tiempo:integer; //tiempo en minutos
	end;
	reg_mae = record
		cod:integer;
		fecha:fe;
		tiempoTot:integer;
	end;
	
	arch_det = file of reg_det;
	arch_mae = file of reg_mae;
	
	arrayDet = array[1..m] of arch_det;
	arrayReg = array[1..m] of reg_det;

procedure leer (var det:arch_det; var r:reg_det);
begin
	if (not eof(det)) then
		read(det, r)
	else
		r.cod := vA;
end;

procedure asignarArc (var mae:arch_mae; var vecDet:arrayDet);
var
	i:integer;
	num:string;
begin
	for i:=1 to m do begin
		Str(i, num);
		assign(vecDet[i], 'detalle' + num);
	end;
	assign(mae, 'var/log');
end;

function fechaEsMenor (f1, f2:fe):boolean;
begin
	if (f1.anio <> f2.anio) then
		if (f1.anio < f2.anio) then
			fechaEsMenor := True
		else
			fechaEsMenor := False
	else if (f1.mes <> f2.mes) then
		if (f1.mes < f2.mes) then
			fechaEsMenor := True
		else
			fechaEsMenor := False
	else
		if (f1.dia <= f2.dia) then
			fechaEsMenor := True
		else
			fechaEsMenor := False;
end;

procedure minimo (var vecDet:arrayDet; var vecReg:arrayReg; var min:reg_det);
var
	i, posMin:integer;
begin
	min.cod := vA;
	posMin := (-1);
	for i:=1 to m do begin
		if (vecReg[i].cod <> vA) then begin
			if (vecReg[i].cod < min.cod) then begin 
				min := vecReg[i];
				posMin := i;
			end
			else if (vecReg[i].cod = min.cod) then //si codigos son iguales, ordenamos por fecha
					if (fechaEsMenor(vecReg[i].fecha, min.fecha)) then begin
						min := vecReg[i];
						posMin := i;
					end;
		end;
	end;
	if (posMin <> (-1)) then
		leer(vecDet[posMin], vecReg[posMin]);
end;

function fechasIguales (f1, f2:fe):boolean;
begin
	fechasIguales := (f1.anio = f2.anio) and (f1.mes = f2.mes) and (f1.dia = f2.dia);
end;

procedure crearMaestro (var mae:arch_mae; var vecDet:arrayDet; var vecReg:arrayReg);
var
	i:integer;
	min:reg_det;
	regM:reg_mae;
begin
	for i:=1 to m do begin
		reset(vecDet[i]);
		leer(vecDet[i],vecReg[i]);
	end;
	rewrite(mae);
	minimo(vecDet, vecReg, min);
	while (min.cod <> vA) do begin
		regM.cod := min.cod;
		regM.fecha := min.fecha;
		regM.tiempoTot := 0;
		while (min.cod = regM.cod) and (fechasIguales(regM.fecha, min.fecha)) do begin
			regM.tiempoTot := regM.tiempoTot + min.tiempo;
			minimo(vecDet, vecReg, min);
		end;
		write(mae, regM);
	end;
	close(mae);
	for i:=1 to m do
		close(vecDet[i]);
	writeln(LineEnding, '-------------', LineEnding, 'Log Cargado.', LineEnding, '-------------');
end;

procedure mostrarLog (var mae:arch_mae);
var
	regM:reg_mae;
begin
	reset(mae);
	while (not eof(mae)) do begin
		read(mae, regM);
		writeln('------------------');
		writeln('Codigo: ', regM.cod, '.');
		writeln('Fecha: ', regM.fecha.dia, '-', regM.fecha.mes, '-', regM.fecha.anio, '.');
		writeln('Duracion de Sesion: ', regM.tiempoTot, ' mins.');
		writeln('------------------');
	end;
end;		

var
	mae:arch_mae;
	vecDet:arrayDet;
	vecReg:arrayReg;
begin
	asignarArc(mae, vecDet);
	crearMaestro(mae, vecDet, vecReg);
	mostrarLog(mae);
end.
