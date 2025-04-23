program maestro_detalle;
const
	vA = 9999;
	d = 10;
	supera = 50;
type
	reg_det = record
		codLoc:integer;
		codCepa:integer;
		casosAct:integer;
		casosNue:integer;
		casosRec:integer;
		casosFall:integer;
	end;
	reg_mae = record
		codLoc:integer;
		nomLoc:string[30];
		codCepa:integer;
		nomCepa:string[30];
		casosAct:integer;
		casosNue:integer;
		casosRec:integer;
		casosFall:integer;
	end;
	
	arch_det = file of reg_det;
	arch_mae = file of reg_mae;
	
	arrayDet = array[1..d] of arch_det;
	arrayReg = array[1..d] of reg_det;


procedure asignarArc (var mae:arch_mae; var vecDet:arrayDet);
var
	i:integer;
	num:string;
begin
	for i:=1 to d do begin
		Str(i, num);
		assign(vecDet[i], 'detalle' + num);
	end;
	assign(mae, 'maestro');
end;

procedure leer (var det:arch_det; var r:reg_det);
begin
	if (not eof(det)) then
		read(det, r)
	else
		r.codLoc := vA;
end;

procedure minimo (var vecDet:arrayDet; var vecReg:arrayReg; var min:reg_det);
var
	i, posMin:integer;
begin
	posMin := (-1);
	min.codLoc := vA;
	for i:=1 to d do begin
		if (vecReg[i].codLoc <> vA) then begin
			if (vecReg[i].codLoc < min.codLoc) then begin
				min := vecReg[i];
				posMin := i;
			end
			else if (vecReg[i].codLoc = min.codLoc) then
					if (vecReg[i].codCepa < min.codCepa) then begin
						min := vecReg[i];
						posMin := i;
					end;
		end;
	end;
	if (posMin <> (-1)) then
		leer(vecDet[posMin], vecReg[posMin]);
end;

procedure actualizarMaestro (var mae:arch_mae; var vecDet:arrayDet; var vecReg:arrayReg);
var
	i:integer;
	min:reg_det;
	regM:reg_mae;
begin
	for i:=1 to d do begin
		reset(vecDet[i]);
		leer(vecDet[i], vecReg[i]);
	end;
	reset(mae);
	minimo(vecDet, vecReg, min);
	while (min.codLoc <> vA) do begin
		read(mae, regM);
		while (regM.codLoc <> min.codLoc) or (regM.codCepa <> min.codCepa) do
			read(mae, regM);
		while (regM.codLoc = min.codLoc) and (regM.codCepa = min.codCepa) do begin
			regM.casosFall := regM.casosFall + min.casosFall;
			regM.casosRec := regM.casosRec + min.casosRec;
			regM.casosAct := min.casosAct;
			regM.casosNue := min.casosNue;
			minimo(vecDet, vecReg, min);
		end;
		seek(mae, filepos(mae)-1);
		write(mae, regM);
	end;
	writeln(LineEnding, '-------------------', LineEnding, 'Maestro Actulizado.', LineEnding, '-------------------');
	for i:=1 to d do
		close(vecDet[i]);
	close(mae);
end;

procedure informarSupera50 (var mae:arch_mae);
	procedure leer1 (var mae:arch_mae; var regM:reg_mae);
	begin
		if (not eof(mae)) then
			read(mae, regM)
		else
			regM.codLoc := vA;
	end;
var
	codLocAct, casos, cantSupera:integer;
	regM:reg_mae;
begin
	reset(mae);
	cantSupera := 0;
	leer1(mae, regM);
	while (regM.codLoc <> vA) do begin
		casos := 0;
		codLocAct := regM.codLoc;
		while (codLocAct = regM.codLoc) do begin
			casos := casos + regM.casosAct;
			leer1(mae, regM);
		end;
		if (casos > supera) then
			cantSupera := cantSupera + 1;
	end;
	writeln(LineEnding, '--------------------------------------------', LineEnding, cantSupera, ' Localidades Superan los ', supera, ' Casos Activos.', LineEnding, '--------------------------------------------');
	close(mae);
end;

var
	mae:arch_mae;
	vecDet:arrayDet;
	vecReg:arrayReg;
begin
	asignarArc(mae, vecDet);
	actualizarMaestro(mae, vecDet, vecReg);
	informarSupera50(mae);
end.
	
		
	






	
