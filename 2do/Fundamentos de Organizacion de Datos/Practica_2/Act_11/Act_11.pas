program horasExtra;
const vA = (-1); categs = 15;
type
	emp = record
		dpto:integer;
		division:integer;
		codEmple:integer;
		cate:integer;
		cantHoras:integer;
	end;
	
	arrayValor = array[1..categs] of integer;
	
	categs_horas = Text;
	
	arch = file of emp;

procedure asignarArc (var arc:arch; var arc_txt:categs_horas);
begin
	assign(arc, 'archivo_horas_extras');
	assign(arc_txt, 'monto_pagado_segun_categoria.txt');
end;

procedure cargarVector (var arc_txt:categs_horas; var vec:arrayValor);
var
	cate, monto:integer;
begin
	reset(arc_txt);
	while (not eof(arc_txt)) do begin
		read(arc_txt, cate);readln(arc_txt, monto);
		vec[cate] := monto;
	end;
	close(arc_txt);
end;

procedure leer (var arc:arch; var regM:emp);
begin
	if (not eof(arc)) then
		read(arc, regM)
	else
		regM.dpto := vA;
end;

procedure mostrarEnPantalla (var arc:arch; vec:arrayValor);
var
	regM:emp;
	dptoAct, cateEmp, horasAcu, codEmpAct, divAct, totHorasDpto, totMontoDpto, totHorasDiv, totMontoDiv:integer;
begin
	reset(arc);
	leer(arc, regM);
	while (regM.dpto <> vA) do begin
		dptoAct := regM.dpto;
		totHorasDpto := 0;
		totMontoDpto := 0;
		writeln('Departamento ', regM.dpto);
		while (regM.dpto = dptoAct) do begin
			totHorasDiv := 0;
			totMontoDiv := 0;
			divAct := regM.division;
			writeln('Division ', regM.division);
			writeln('Numero de Empleado     |     Total Hs.     |     Importe a Cobrar');
			while (regM.dpto = dptoAct) and (regM.division = divAct) do begin
				horasAcu := 0;
				codEmpAct := regM.codEmple;
				cateEmp := regM.cate;
				while (regM.dpto = dptoAct) and (regM.division = divAct) and (codEmpAct = regM.codEmple) do begin
					horasAcu := horasAcu + regM.cantHoras;
					leer(arc, regM);
				end;
				totHorasDiv := totHorasDiv + horasAcu;
				totMontoDiv := totMontoDiv + (vec[cateEmp]*horasAcu);
				writeln(codEmpAct, '                    |     ', horasAcu, '             |     ', (vec[cateEmp]*horasAcu));
			end;
			writeln('------------------------');
			writeln('Total Horas Divison: ', totHorasDiv);
			writeln('Total Monto Division: ', totMontoDiv);
			writeln('------------------------');
			totHorasDpto := totHorasDpto + totHorasDiv;
			totMontoDpto := totMontoDpto + totMontoDiv;
		end;
		writeln('Total Horas Departamento: ', totHorasDpto);
		writeln('Total Monto Departamento: ', totMontoDpto);
	end;
	close(arc);
end;		

var
	arc:arch;
	arc_txt:categs_horas;
	vec:arrayValor;
begin
	asignarArc(arc, arc_txt);
	cargarVector(arc_txt, vec);
	mostrarEnPantalla(arc, vec);
end.
