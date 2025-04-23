program editorial;
const vA = 9999; dets = 100;
type
	fe = record
		dia:integer;
		mes:integer;
		ano:integer;
	end;
	
	emi = record
		fecha:fe;
		cod:integer;
		nom:string;
		desc:string;
		precio:real;
		totEjem:integer;
		vendidos:integer;
	end;
	
	reg_det = record
		fecha:fe;
		cod:integer;
		vendidos:integer;
	end;
	
	cod_cant = record
		cod:integer;
		vendidos:integer;
	end;
	
	nodo = ^obj;
	
	emi_int = record
		reg:emi;
		vendidos:integer;
	end;
	
	obj = record
		elem:emi_int;
		sig:nodo;
	end;
	
	arch_mae = file of emi;
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

procedure leer (var arc:arch_det; var r:reg_det);
begin
	if (not eof(arc)) then
		read(arc, r)
	else begin
		r.fecha.ano := vA;
		r.cod := vA;
	end;
end;

function fechasIguales (f1, f2:fe):boolean;
begin
	fechasIguales := (f1.dia = f2.dia) and (f1.mes = f2.mes) and (f1.ano = f2.ano);
end;

function fechaEsMenor(f1, f2: fe): boolean;
begin
  if f1.ano < f2.ano then
    fechaEsMenor := true
  else if (f1.ano = f2.ano) and (f1.mes < f2.mes) then
    fechaEsMenor := true
  else if (f1.ano = f2.ano) and (f1.mes = f2.mes) and (f1.dia < f2.dia) then
    fechaEsMenor := true
  else
    fechaEsMenor := false;
end;

procedure minimo (var vecDet:arrayDet; var vecReg:arrayReg; var min:reg_det);
var
	i, posMin:integer;
begin
	posMin := vA;
	min.fecha.dia := 99; min.fecha.mes := 99; min.fecha.ano := 9999;
	min.cod := vA;
	for i:=1 to dets do begin
		if (vecReg[i].cod <> vA) then begin
			if (fechaEsMenor(vecReg[i].fecha, min.fecha)) then begin
				posMin := i;
				min := vecReg[i]
			end
			else if (fechasIguales(vecReg[i].fecha, min.fecha)) then 
				if (vecReg[i].cod < min.cod) then begin
					posMin := i;
					min := vecReg[i];
				end;
		end;
	end;
	if (posMin <> vA) then
		leer(vecDet[posMin], vecReg[posMin]);
end;

procedure agregarAdelante (var pI:nodo; reg:emi; ventAcu:integer);
var
	nue:nodo;
begin
	new(nue);
	nue^.elem.reg := reg;
	nue^.elem.vendidos := ventAcu;
	nue^.sig := pI;
	pI := nue;
end;	

procedure buscar_agregar (var pI:nodo; regM:emi; ventAcu:integer);
var
	auxpI:nodo;
	halle:boolean;
begin
	auxpI := pI;
	halle := False;
	while (auxpI <> nil) and (not halle) do begin
		if (auxpI^.elem.reg.cod = regM.cod) then begin
			auxpI^.elem.vendidos := auxpI^.elem.vendidos + ventAcu;
			halle := True;
		end;
	end;
	if (not halle) then
		agregarAdelante(pI, regM, ventAcu);
end;

procedure actualizarMaestro (var pI:nodo; var mae:arch_mae; var vecDet:arrayDet);	
var
	vecReg:arrayReg;
	regM : emi;
	i, ventasAcu:integer;
	min:reg_det;
begin
	for i:=1 to dets do begin
		reset(vecDet[i]);
		leer(vecDet[i], vecReg[i]);
	end;
	reset(mae);
	minimo(vecDet, vecReg, min);
	while (min.cod <> vA) do begin
		read(mae, regM);
		ventasAcu := 0;
		while (not fechasIguales(regM.fecha, min.fecha)) or (regM.cod <> min.cod) do
			read(mae, regM);
		while (fechasIguales(regM.fecha, min.fecha)) and (regM.cod = min.cod) do begin
			ventasAcu := ventasAcu + min.vendidos;
			minimo(vecDet, vecReg, min);
		end;
		regM.vendidos := regM.vendidos + ventasAcu;
		buscar_agregar(pI, regM, ventasAcu);
		seek(mae, filepos(mae)-1);
		write(mae, regM);
	end;
	close(mae);
end;

procedure max_min (pI:nodo);
	procedure mostrarReg (r:emi);
	begin
		writeln('Fecha: ', r.fecha.dia, '/', r.fecha.mes, '/', r.fecha.ano, '.');
		writeln('Codigo: ', r.cod, '.');
		writeln('Nombre: ', r.nom, '.', LineEnding, 'Descripcion: ', r.desc);
		writeln('Precio: ', r.precio:0:2, ',.');
	end;		
var
	regMax, regMin:emi;
begin
	regMax.vendidos := (-1);regMin.vendidos := MaxInt;
	while (pI <> nil) do begin
		if (pI^.elem.vendidos > regMax.vendidos) then
			regMax := pI^.elem.reg;
		if (pI^.elem.vendidos < regMin.vendidos) then
			regMin := pI^.elem.reg;
		pI := pI^.sig;
	end;
	writeln('Semanario Mas Vendido: ');
	mostrarReg(regMax);
	writeln();
	writeln('Semanario Menos Vendido: ');
	mostrarReg(regMin);
end;

var
	pI:nodo;
	mae:arch_mae;
	vecDet:arrayDet;
begin
	pI := nil;
	asignarArc(mae, vecDet);
	actualizarMaestro(pI, mae, vecDet);
end.
